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
    var i = (c.level / 90.0) * 100 +
        (w.level / 90.0) * 100 +
        character.rarity / 5 * 100;
    if (todo) {
      return 500 + i;
    }
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

  bool chargeEfficiencyAsDPS(ArtifactService as) =>
      artifacts.where((a) => a.setKey == as.findSet("绝缘之旗印").key).length >= 4;

  List<GOODArtifact> graduatedArtifacts(
    ArtifactService as, {
    List<GOODArtifact>? defaultArtifacts,
  }) {
    var b = character.characterBuildFor(c.role);
    var rankRadios = b.appendPropRankRadios(
      chargeEfficiencyAsDPS: chargeEfficiencyAsDPS(as),
      location: character.key,
    );

    var depot = as.artifactAppendPropDepots![501]!;

    var props = rankRadios.keys.map((fp) {
      var tfp = fp;

      switch (fp) {
        case FightProp.ATTACK:
          tfp = FightProp.ATTACK_PERCENT;
          break;
        case FightProp.HP:
          tfp = FightProp.HP_PERCENT;
          break;
        case FightProp.DEFENSE:
          tfp = FightProp.DEFENSE_PERCENT;
          break;
        default:
      }

      return GOODSubStat(key: GOODArtifact.statKeyFromFightProp(tfp))
          .withStringValue(
        GSArtifactAppendDepot.format(depot.avgValue(tfp) * rankRadios[fp]!),
      );
    });

    return (defaultArtifacts ?? artifacts)
        .mapIndexed((i, e) => e.copyWith(
              substats: i == 0 ? props.toList() : [],
            ))
        .toList();
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
    bool? asDetails,
    String? location,
    bool? chargeEfficiencyAsDPS,
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

    var rankRadios = builds.appendPropRankRadios(
      chargeEfficiencyAsDPS: chargeEfficiencyAsDPS ?? false,
      location: location,
    );

    bool isUsed(FightProp fp) => (rankRadios.keys.contains(fp));

    Map<String, Rank> ranks = {};

    int fpRarity(FightProp fp, double rank, double max) {
      if (max == 0) {
        return 0;
      }
      return [1, 2, 3, 4]
          .map((v) => v / 4 * max)
          .fold<int>(1, (v, b) => (rank >= b * 1) ? v + 1 : v);
    }

    double rank = 0;
    double critRank = 0;

    for (var fp in rankRadios.keys) {
      var val = appendPropRanks[fp] ?? 0;

      switch (fp) {
        case FightProp.CRITICAL:
        case FightProp.CRITICAL_HURT:
          rank += val;
          critRank += val;
          break;
        default:
          rank += val;
      }
    }

    var rankLabel = "${rankRadios.keys.map((fp) {
      switch (fp) {
        case FightProp.ELEMENT_MASTERY:
          return "精";
        case FightProp.CHARGE_EFFICIENCY:
          return "充";
        default:
          return fp.label()[0];
      }
    }).join("")}${critRank > 0 ? "" : "词条"}";

    var totalRadio = rankRadios.values
        .fold<double>(0, (previousValue, v) => previousValue + v);

    ranks[rankLabel] = Rank(
      value: rank,
      indexes: [],
      used: true,
      rarity: rankRadios.keys
          .fold<double>(
              0,
              (previousValue, fp) =>
                  previousValue +
                  ((rankRadios[fp]! / totalRadio) *
                      fpRarity(fp, appendPropRanks[fp] ?? 0, rankRadios[fp]!)))
          .round(),
    );

    if (critRank > 0) {
      var critRankRarity = fpRarity(
          FightProp.CRITICAL,
          critRank,
          ((rankRadios[FightProp.CRITICAL] ?? 0) +
              (rankRadios[FightProp.CRITICAL_HURT] ?? 0)));

      ranks["双暴词条"] = Rank(
        value: critRank,
        indexes: [],
        used: true,
        rarity: critRankRarity.round(),
      );
    }

    if (asDetails ?? false) {
      for (var fp in (appendPropRanks.keys.toList()
        ..sort((a, b) => a.index - b.index))) {
        var rank = appendPropRanks[fp]!;

        ranks[fp.label()] = Rank(
          value: rank,
          indexes: appendPropIndexes[fp]!,
          used: isUsed(fp),
          rarity: fpRarity(fp, rank, rankRadios[fp] ?? 0),
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
