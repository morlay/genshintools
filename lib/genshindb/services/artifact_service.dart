import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/good/good.dart';
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
    Map<String, GSArtifactSet>? artifactSets,
    Map<int, List<FightProp>>? artifactMainPropDepots,
    Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots,
    List<List<int>>? artifactLevelupExps,
    List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues,
  }) = _ArtifactService;

  factory ArtifactService.fromJson(Map<String, dynamic> json) =>
      _ArtifactService.fromJson(json);

  int levelUpCost(int rarity, int current, int to) {
    return artifactLevelupExps?.let((artifactLevelupExps) => levelUpCostFor(
            artifactLevelupExps[rangeLimit(rarity, 1, 5) - 1], current, to)) ??
        -1;
  }

  GSArtifact find(String keyOrName) {
    var a = findOrNull(keyOrName);
    if (a == null) {
      throw "artifact $keyOrName not found";
    }
    return a;
  }

  final Map<String, int> _indexes = {};

  GSArtifact? findOrNull(String keyOrName) {
    if (_indexes.isEmpty) {
      artifacts?.forEach((key, value) {
        _indexes["${value.id}"] = value.id;
        for (var lang in value.name.keys) {
          _indexes[value.name.text(lang)] = value.id;
        }
      });
    }

    return artifacts?[_indexes[keyOrName]];
  }

  final Map<String, String> _setIndexes = {};
  final Map<String, Map<EquipType, String>> _setNames = {};

  GSArtifactSet findSet(String keyOrName) {
    return findSetOrNull(keyOrName)!;
  }

  GSArtifactSet? findSetOrNull(String keyOrName) {
    if (_setIndexes.isEmpty) {
      artifactSets?.forEach((key, value) {
        _setIndexes["${value.id}"] = value.key;
        for (var lang in value.name.keys) {
          _setIndexes[value.name.text(lang)] = value.key;
        }
      });
    }

    if (_setNames.isEmpty) {
      artifacts?.forEach((key, value) {
        _setNames[value.setKey] = {
          ...?_setNames[value.setKey],
          value.equipType: value.key,
        };
      });
    }

    return artifactSets?[_setIndexes[keyOrName]]?.copyWith(
        artifacts: _setNames[_setIndexes[keyOrName]]
            ?.map((key, id) => MapEntry(key, find(id))));
  }

  List<GSArtifactSet> resolveArtifactSets(List<GOODArtifact> artifacts) {
    return artifacts
        .map((a) => a.setKey)
        .where((v) => v != "")
        .groupListsBy((v) => v)
        .values
        .where((list) => list.length >= 2)
        .map((list) => findSet(list[0]).copyWith(activeNum: list.length))
        .toList();
  }

  List<GOODArtifact> buildArtifactsBySetPair(
      List<String> setNames, GSCharacterBuild builds,
      [List<GOODArtifact>? playerArtifacts]) {
    var sets = setNames.map((setName) => findSet(setName)).toList();

    Map<EquipType, GOODArtifact> ret = {};

    EquipType.values.forEachIndexed((i, equipType) {
      if (sets.isEmpty) {
        return;
      }

      var s = sets[i < 2
          ? 0
          : sets.length == 2
              ? 1
              : 0];

      var a = s.artifacts![equipType]!;

      int level = 0;
      StatKey main =
          GOODArtifact.statKeyFromFightProp(builds.defaultMainProp(equipType));
      List<GOODSubStat> substats = [];

      playerArtifacts
          ?.firstWhereOrNull((pa) => pa.slotKey.asEquipType() == equipType)
          ?.let((it) {
        main = it.mainStatKey;
        level = it.level;
        substats = it.substats;
      });

      ret[equipType] = GOODArtifact(
        location: "",
        setKey: s.key,
        rarity: a.rarity,
        level: level,
        mainStatKey: main,
        slotKey: SlotKey.values[equipType.index],
        substats: substats,
      );
    });

    return ret.values.toList();
  }

  FightProps fightProps(List<GOODArtifact> artifacts) {
    var fps = FightProps({});

    resolveArtifactSets(artifacts).forEach((artifactSet) {
      for (var ea in artifactSet.equipAffixes) {
        if ((artifactSet.activeNum ?? 0) >= ea.activeWhenNum!) {
          fps = fps.merge(ea.patchedFightProps());
        }
      }
    });

    for (var a in artifacts) {
      fps = fps.add(
        a.mainStatKey.asFightProp(),
        mainFightProp(a.mainStatKey.asFightProp(), a.rarity, a.level),
      );

      fps = fps.merge(appendFightProps(a.rarity, a.substatsAsFightProps()));
    }

    return fps;
  }

  List<FightProp> mainCanFightProps(String keyOrName) {
    var c = find(keyOrName);

    switch (c.equipType) {
      case EquipType.BRACER:
        return [FightProp.HP];
      case EquipType.NECKLACE:
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

  GSArtifactAppendDepot artifactAppendDepot(String keyOrName) {
    return artifactAppendPropDepots![find(keyOrName).appendPropDepotId]!;
  }

  double mainFightProp(
    FightProp mainFightProp,
    int rarity,
    int level,
  ) {
    rarity = rangeLimit(rarity, 1, 5);
    level = rangeLimit(level, 0, rarity * 4);

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
