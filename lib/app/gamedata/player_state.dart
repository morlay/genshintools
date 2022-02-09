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
    List<FightProps>? buffs,
  }) = _CharacterWithState;

  bool get todo => artifacts.length == 5;

  double weight() {
    var i = c.level / 90.0 * 100 + character.rarity / 5 * 100;
    return i;
  }

  bool hasBuff(FightProps buff) {
    return buffs?.where((b) => b.name == buff.name).isNotEmpty ?? false;
  }

  FightProps computeFightProps(GSDB db) {
    return db.character
        .fightProps(
          c.key,
          c.level,
          c.constellation,
        )
        .merge(db.weapon.fightProps(
          w.key,
          w.level,
          w.refinement,
        ))
        .merge(db.artifact.fightProps(
          artifacts,
        ))
        .mergeAll(buffs ?? [])
        .compute();
  }

  double calcSkillValue(FightProps fightProps, SkillType st, String label,
      double Function(String, List<double> params) calc) {
    var s = character.skills.firstWhereOrNull((v) => v.skillType == st);

    if (s != null) {
      var p = s.paramNames!.firstWhereOrNull((i18n) =>
          i18n.values.values.map((e) => e.split("|").first).contains(label));

      if (p != null) {
        return calc(
          p.text(Lang.CHS).split("|").last,
          s.paramsForLevel(fightProps.fixSkillLevel(st, c.skillLevel(st))),
        );
      }
    }

    return 0;
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
        var tfp = fp;

        switch (fp) {
          case FightProp.HP_PERCENT:
            tfp = FightProp.HP;
            break;
          case FightProp.DEFENSE_PERCENT:
            tfp = FightProp.DEFENSE;
            break;
          case FightProp.ATTACK_PERCENT:
            tfp = FightProp.ATTACK;
            break;
          default:
        }

        appendPropIndexes[tfp] = [
          ...?appendPropIndexes[tfp],
          ...artifactAppendDepot.valueNs(
            ss.key.asFightProp(),
            ss.stringValue(),
          )
        ]..sort((a, b) => b - a);

        appendPropRanks[tfp] = (appendPropRanks[tfp] ?? 0) +
            artifactAppendDepot.rank(
              fp,
              artifactAppendDepot.valueNs(
                ss.key.asFightProp(),
                ss.stringValue(),
              ),
              fightProps,
              location,
            );
      }
    }

    double valueFix(FightProp fp, num v) =>
        v * (fp == FightProp.ATTACK && location == "HuTao" ? 0.4 : 1);

    bool isUsed(FightProp fp) =>
        (builds.artifactAffixPropTypes?.contains(fp) ?? false);

    int fpRarity(FightProp fp, double rank) {
      return [1, 2, 3, 4].map((v) => valueFix(fp, v)).fold<int>(
            1,
            (v, b) => (rank >=
                    b *
                        ((fp == FightProp.CRITICAL ||
                                fp == FightProp.CRITICAL_HURT)
                            ? (2.5)
                            : 1))
                ? v + 1
                : v,
          );
    }

    var isDPS = isUsed(FightProp.CRITICAL_HURT);

    Map<String, Rank> ranks = {};

    var critRanges = [8, 12, 16, 20];

    double allRank = 0;
    double dpsRank = 0;
    double critRank = 0;

    List<FightProp> dpsKeys = [];

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
              dpsRank += val;
              dpsKeys.add(FightProp.ATTACK);
              break;
            case FightProp.HP:
            case FightProp.HP_PERCENT:
              dpsRank += val;
              dpsKeys.add(FightProp.HP);
              break;
            case FightProp.DEFENSE:
            case FightProp.DEFENSE_PERCENT:
              dpsRank += val;
              dpsKeys.add(FightProp.DEFENSE);
              break;
            case FightProp.ELEMENT_MASTERY:
              dpsRank += val;
              dpsKeys.add(fp);
              break;
            case FightProp.CHARGE_EFFICIENCY:
              if (chargeEfficiencyAsDPS ?? false) {
                dpsRank += val;
                dpsKeys.add(fp);
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
      var props = dpsKeys.toSet().toList();

      var critR = Rank(
        value: critRank,
        indexes: [],
        used: true,
        rarity: critRanges.fold<int>(1, (v, b) => (critRank > b) ? v + 1 : v),
      );

      double totalN = props.fold(20, (t, fp) => (t + valueFix(fp, 4)));

      double otherR = (20 / totalN) * critR.rarity;

      for (var fp in props) {
        otherR +=
            (valueFix(fp, 4) / totalN) * fpRarity(fp, appendPropRanks[fp]!);
      }

      ranks["${props.map((fp) => fp == FightProp.ELEMENT_MASTERY ? "精" : fp.label()[0]).join("")}双暴"] =
          Rank(
        value: dpsRank,
        indexes: [],
        used: true,
        rarity: otherR.round(),
      );

      ranks["双暴词条"] = critR;
    }

    if (asDetails ?? false) {
      for (var fp in (appendPropRanks.keys.toList()
        ..sort((a, b) => a.index - b.index))) {
        var rank = appendPropRanks[fp]!;

        ranks[fp.label()] = Rank(
          value: rank,
          indexes: appendPropIndexes[fp]!,
          used: isUsed(fp),
          rarity: fpRarity(fp, rank),
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
