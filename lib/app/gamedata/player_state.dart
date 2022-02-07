import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';
import 'package:genshintools/genshindb/services/artifact_service.dart';

part 'generated/player_state.freezed.dart';

@freezed
class CharacterWithState with _$CharacterWithState {
  CharacterWithState._();

  factory CharacterWithState({
    required GSCharacter character,
    required GOODCharacter c,
    required GOODWeapon w,
    required List<GOODArtifact> artifacts,
  }) = _CharacterWithState;

  bool get todo => artifacts.length == 5;

  double weight() {
    var i = c.level / 90.0 * 100 + character.rarity / 5 * 100;
    return i;
  }

  Map<String, Rank> appendPropsRanks(
    ArtifactService as,
    GSCharacterBuild builds,
    FightProps fightProps, {
    bool? details,
  }) {
    Map<FightProp, List<int>> appendPropIndexes = {};
    Map<FightProp, double> appendPropRanks = {};

    for (var a in artifacts) {
      var artifactAppendDepot =
          as.artifactAppendDepotFromSetKey(a.setKey, a.slotKey.asEquipType());

      for (var ss in a.substats) {
        var fp = ss.key.asFightProp();

        appendPropIndexes[fp] = [
          ...?appendPropIndexes[fp],
          ...artifactAppendDepot.valueIndexes(
            ss.key.asFightProp(),
            ss.stringValue(),
          )
        ]..sort((a, b) => b - a);

        appendPropRanks[fp] =
            artifactAppendDepot.rank(fp, appendPropIndexes[fp]!, fightProps);
      }
    }

    bool isUsed(FightProp fp) =>
        (builds.artifactAffixPropTypes?.contains(fp) ?? false);

    var isDPS = isUsed(FightProp.CRITICAL_HURT);

    Map<String, Rank> ranks = {};

    ranks["有效词条"] = Rank(
      value: appendPropRanks.keys.fold<double>(
          0, (c, fp) => (c + (isUsed(fp) ? appendPropRanks[fp]! : 0))),
      indexes: [],
      used: true,
    );

    if (isDPS) {
      ranks["输出词条"] = Rank(
        value: ranks["有效词条"]!.value -
            appendPropRanks.keys.fold<double>(
                0,
                (c, fp) => (c +
                    ((fp == FightProp.CHARGE_EFFICIENCY ||
                                fp == FightProp.ELEMENT_MASTERY) &&
                            isUsed(fp)
                        ? appendPropRanks[fp]!
                        : 0))),
        indexes: [],
        used: true,
      );

      ranks["双暴词条"] = Rank(
        value: appendPropRanks.keys.fold<double>(
            0,
            (c, fp) => (c +
                ((fp == FightProp.CRITICAL || fp == FightProp.CRITICAL_HURT) &&
                        isUsed(fp)
                    ? appendPropRanks[fp]!
                    : 0))),
        indexes: [],
        used: true,
      );
    }

    if (details ?? false) {
      for (var fp in (appendPropRanks.keys.toList()
        ..sort((a, b) => a.index - b.index))) {
        ranks[fp.label()] = Rank(
          value: appendPropRanks[fp]!,
          indexes: appendPropIndexes[fp]!,
          used: isUsed(fp),
        );
      }
    }

    return ranks;
  }
}

class Rank {
  double value;
  List<int> indexes;
  bool used;

  Rank({
    required this.value,
    required this.indexes,
    this.used = false,
  });
}
