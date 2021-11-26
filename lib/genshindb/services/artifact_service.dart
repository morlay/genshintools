import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/types.dart';
import 'package:genshintools/genshindb/utils.dart';

part 'generated/artifact_service.freezed.dart';
part 'generated/artifact_service.g.dart';

@freezed
class ArtifactService with _$ArtifactService {
  ArtifactService._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  @FightPropStringConverter()
  factory ArtifactService({
    Map<int, GSArtifact>? artifacts,
    Map<int, GSArtifactSet>? artifactSets,
    Map<int, List<FightProp>>? artifactMainPropDepots,
    Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots,
    List<List<int>>? artifactLevelupExps,
    List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues,
  }) = _ArtifactService;

  factory ArtifactService.fromJson(Map<String, dynamic> json) =>
      _ArtifactService.fromJson(json);

  final Map<String, int> _indexes = {};

  final Map<String, int> _setIndexes = {};
  final Map<int, Map<EquipType, String>> _setNames = {};

  int levelUpCost(int rarity, int current, int to) {
    return artifactLevelupExps?.let((artifactLevelupExps) => levelUpCostFor(
            artifactLevelupExps[rangeLimit(rarity, 1, 5) - 1], current, to)) ??
        -1;
  }

  GSArtifact find(String idOrName) {
    return findOrNull(idOrName)!;
  }

  GSArtifact? findOrNull(String idOrName) {
    if (_indexes.isEmpty) {
      artifacts?.forEach((key, value) {
        _indexes["${value.id}"] = value.id;
        for (var lang in value.name.keys) {
          _indexes[value.name.text(lang)] = value.id;
        }
      });
    }

    return artifacts?[_indexes[idOrName]];
  }

  GSArtifactSet findSet(String idOrName) {
    return findSetOrNull(idOrName)!;
  }

  GSArtifactSet? findSetOrNull(String idOrName) {
    if (_setIndexes.isEmpty) {
      artifactSets?.forEach((key, value) {
        _setIndexes["${value.id}"] = value.id;
        for (var lang in value.name.keys) {
          _setIndexes[value.name.text(lang)] = value.id;
        }
      });
    }

    if (_setNames.isEmpty) {
      artifacts?.forEach((key, value) {
        _setNames[value.setId] = {
          ...?_setNames[value.setId],
          value.equipType: value.nameID,
        };
      });
    }

    return artifactSets?[_setIndexes[idOrName]]?.copyWith(
        artifacts: _setNames[_setIndexes[idOrName]]
            ?.map((key, id) => MapEntry(key, find(id))));
  }

  List<GSArtifactSet> resolveArtifactSets(
    Map<EquipType, PlayerArtifact> artifacts,
  ) {
    return EquipType.values
        .map(
          (type) =>
              artifacts[type]?.let(
                (a) => findOrNull(a.name)?.setId.toString(),
              ) ??
              "",
        )
        .where((v) => v != "")
        .groupListsBy((v) => v)
        .values
        .where((list) => list.length >= 2)
        .map((list) => findSet(list[0]).copyWith(activeNum: list.length))
        .toList();
  }

  Map<EquipType, PlayerArtifact> buildArtifactsBySetPair(
    List<String> setNames,
    GSCharacterBuild builds,
    Map<EquipType, PlayerArtifact>? playerArtifacts,
  ) {
    var sets = setNames.map((setName) => findSet(setName)).toList();

    Map<EquipType, PlayerArtifact> ret = {};

    EquipType.values.forEachIndexed((i, equipType) {
      if (sets.isEmpty) {
        return;
      }

      var a = sets[i < 2
              ? 0
              : sets.length == 2
                  ? 1
                  : 0]
          .artifacts![equipType]!;

      var main = playerArtifacts?[equipType]?.main ??
          builds.defaultMainProp(equipType);

      ret[equipType] = PlayerArtifact(
        usedBy: 0,
        equipType: equipType,
        name: a.name.text(Lang.CHS),
        rarity: a.rarity,
        level: 0,
        main: main,
        appends: playerArtifacts?[equipType]?.appends ?? {},
      );
    });

    return ret;
  }

  FightProps fightProps(
    Map<EquipType, PlayerArtifact> artifacts,
  ) {
    var fps = FightProps({});

    resolveArtifactSets(artifacts).forEach((artifactSet) {
      for (var ea in artifactSet.equipAffixes) {
        if ((artifactSet.activeNum ?? 0) >= ea.activeWhenNum!) {
          fps = fps.merge(ea.patchedFightProps());
        }
      }
    });

    for (var a in artifacts.values) {
      fps = fps.add(
        a.main,
        mainFightProp(a.main, a.rarity, a.level),
      );

      fps = fps.merge(appendFightProps(a.rarity, a.appends));
    }

    return fps;
  }

  List<FightProp> mainCanFightProps(String idOrName) {
    var c = find(idOrName);

    switch (c.equipType) {
      case EquipType.FLOWER:
        return [FightProp.HP];
      case EquipType.FEATHER:
        return [FightProp.ATTACK];
      default:
        return artifactMainPropDepots?[c.mainPropDepotId]
                ?.where((fp) => !fp.string().contains("_SUB_"))
                .where((fp) => !(fp == FightProp.HP ||
                    fp == FightProp.ATTACK ||
                    fp == FightProp.DEFENSE))
                .toList() ??
            [];
    }
  }

  GSArtifactAppendDepot artifactAppendDepot(String idOrName) {
    return artifactAppendPropDepots![find(idOrName).appendPropDepotId]!;
  }

  double mainFightProp(
    FightProp mainFightProp,
    int rarity,
    int level,
  ) {
    rarity = rangeLimit(rarity, 1, 5);
    level = rangeLimit(level, 1, rarity * 4);

    return artifactLevelupMainPropValues?[rarity - 1][level][mainFightProp] ??
        0;
  }

  FightProps appendFightProps(int rarity, Map<FightProp, String> appends) {
    var fps = FightProps({});

    var depot = artifactAppendPropDepots![rarity * 100 + 1]!;

    for (var fp in appends.keys) {
      fps = fps.add(fp, depot.valueFor(fp, appends[fp]));
    }

    return fps;
  }

  List<GSArtifact> toList() => artifacts?.values.toList() ?? [];
}

double avg(List<double> rng) {
  if (rng.isEmpty) {
    return 0;
  }
  return rng.fold<double>(0, (previousValue, n) => previousValue + n) /
      rng.length;
}
