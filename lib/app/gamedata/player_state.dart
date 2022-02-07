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
    String? location,
    bool? chargeEfficiencyAsDPS,
    bool? asDetails,
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

        appendPropRanks[fp] = artifactAppendDepot.rank(
            fp, appendPropIndexes[fp]!, fightProps, location);
      }
    }

    bool isUsed(FightProp fp) =>
        (builds.artifactAffixPropTypes?.contains(fp) ?? false);

    var isDPS = isUsed(FightProp.CRITICAL_HURT);

    Map<String, Rank> ranks = {};

    double allRank = 0;
    double dpsRank = 0;
    double critRank = 0;
    List<String> dpsKeys = [];

    for (var fp in appendPropRanks.keys) {
      if (isUsed(fp)) {
        var val = appendPropRanks[fp]!;

        allRank += val;

        if (isDPS) {
          switch (fp) {
            case FightProp.CRITICAL:
            case FightProp.CRITICAL_HURT:
              dpsRank += val;
              critRank += val;
              break;
            case FightProp.ATTACK:
            case FightProp.ATTACK_PERCENT:
            case FightProp.HP:
            case FightProp.HP_PERCENT:
            case FightProp.DEFENSE:
            case FightProp.DEFENSE_PERCENT:
              dpsRank += val;
              dpsKeys.add(fp.label()[0]);
              break;
            case FightProp.ELEMENT_MASTERY:
              dpsRank += val;
              dpsKeys.add("精");
              break;
            case FightProp.CHARGE_EFFICIENCY:
              if (chargeEfficiencyAsDPS ?? false) {
                dpsRank += val;
                dpsKeys.add("充");
              }
              break;
            default:
          }
        }
      }
    }

    ranks["有效词条"] = Rank(
      value: allRank,
      indexes: [],
      used: true,
    );

    if (critRank > 0) {
      var rankRanges = [22, 25, 28, 31, 34];

      ranks[dpsKeys.toSet().toList().join("") + "双暴"] = Rank(
        value: dpsRank,
        indexes: [],
        used: true,
        rarity: rankRanges.fold<int>(1, (v, b) => (dpsRank > b) ? v + 1 : v),
      );

      ranks["双暴词条"] = Rank(
          value: critRank,
          indexes: [],
          used: true,
          rarity: rankRanges.fold<int>(
              1, (v, b) => (critRank > b / 2) ? v + 1 : v));
    }

    if (asDetails ?? false) {
      for (var fp in (appendPropRanks.keys.toList()
        ..sort((a, b) => a.index - b.index))) {
        ranks[fp.label()] = Rank(
          value: appendPropRanks[fp]!,
          indexes: appendPropIndexes[fp]!,
          used: isUsed(fp),
          rarity:
              (appendPropIndexes[fp]!.fold<double>(0, (r, e) => r + (2 + e)) /
                      appendPropIndexes[fp]!.length)
                  .round(),
        );
      }
    }

    return ranks;
  }
}

class Rank {
  double value;
  int rarity;
  List<int> indexes;
  bool used;

  Rank({
    required this.value,
    required this.indexes,
    this.used = false,
    this.rarity = 1,
  });
}
