import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/utils.dart';

part 'generated/fight_props.freezed.dart';
part 'generated/fight_props.g.dart';

@freezed
class FightProps with _$FightProps {
  FightProps._();

  factory FightProps(
    @FightPropStringConverter() Map<FightProp, double> fightProps,
  ) = _FightProps;

  factory FightProps.fromJson(Map<String, dynamic> json) =>
      _FightProps.fromJson({"fightProps": json});

  Iterable<FightProp> get keys => fightProps.keys;

  operator [](FightProp? key) {
    return fightProps[key];
  }

  double get(FightProp fp) {
    return fightProps[fp] ?? 0;
  }

  double calc(String label, List<double> params) {
    Map<String, FightProp> bases = {
      "基础攻击力": FightProp.BASE_ATTACK,
      "攻击力": FightProp.ATTACK,
      "防御力": FightProp.DEFENSE,
      "生命值上限": FightProp.HP,
      "最大生命值": FightProp.HP,
    };

    return label.split("+").fold<double>(0, (previousValue, l) {
      var base = 0.0;
      l = l.trim();

      for (var n in bases.keys) {
        if (l.contains(n)) {
          l = l.replaceAll(n, "");
          base = get(bases[n]!);
          break;
        }
      }

      l = l.replaceAll("每秒", "");

      return previousValue +
          double.parse(
            exec(l, params, (v, fmt) {
              if (fmt == "I") {
                return "$v";
              }
              return "${base * v}";
            }),
          );
    });
  }

  int fixSkillLevel(SkillType st, int level) {
    switch (st) {
      case SkillType.ELEMENTAL_SKILL:
        return level + get(FightProp.ADD_ELEMENTAL_SKILL_LEVEL).toInt();
      case SkillType.ELEMENTAL_BURST:
        return level + get(FightProp.ADD_ELEMENTAL_BURST_LEVEL).toInt();
      default:
        return level;
    }
  }

  FightProps add(FightProp fp, double v) {
    return FightProps({
      ...fightProps,
      fp: get(fp) + v,
    });
  }

  FightProps merge(FightProps fps) {
    return fps.fightProps.isEmpty
        ? this
        : FightProps({
            ...fightProps,
            ...fps.fightProps
                .map((fp, v) => MapEntry(fp, (fightProps[fp] ?? 0) + v))
          });
  }

  FightProps compute() {
    var computedFightProps = FightProps({
      FightProp.LEVEL: rangeLimit(fightProps[FightProp.LEVEL] ?? 1, 1, 90),
    });

    for (var key in FightProp.values) {
      var v = fightProps[key] ?? 0;

      if (v == 0) {
        continue;
      }

      switch (key) {
        case FightProp.LEVEL:
          break;
        case FightProp.ADD_LEVEL:
          computedFightProps = computedFightProps.add(FightProp.LEVEL, v);
          break;
        case FightProp.ENEMY_ADD_LEVEL:
          computedFightProps = computedFightProps.add(FightProp.ENEMY_LEVEL, v);
          break;
        case FightProp.ELEMENT_MASTERY:
          if (v > 0) {
            computedFightProps = computedFightProps.add(
              FightProp.ELEMENT_MASTERY,
              v,
            );
          }
          break;
        case FightProp.ATTACK_PERCENT:
          computedFightProps = computedFightProps.add(
            FightProp.ATTACK,
            fightProps[FightProp.BASE_ATTACK]! * v,
          );
          break;
        case FightProp.HP_PERCENT:
          computedFightProps = computedFightProps.add(
            FightProp.HP,
            fightProps[FightProp.BASE_HP]! * v,
          );
          break;
        case FightProp.DEFENSE_PERCENT:
          computedFightProps = computedFightProps.add(
            FightProp.DEFENSE,
            fightProps[FightProp.BASE_DEFENSE]! * v,
          );
          break;
        default:
          switch (key) {
            case FightProp.BASE_ATTACK:
              computedFightProps = computedFightProps.add(FightProp.ATTACK, v);
              computedFightProps =
                  computedFightProps.add(FightProp.BASE_ATTACK, v);
              break;
            case FightProp.BASE_HP:
              computedFightProps = computedFightProps.add(FightProp.HP, v);
              computedFightProps = computedFightProps.add(FightProp.BASE_HP, v);
              break;
            case FightProp.BASE_DEFENSE:
              computedFightProps = computedFightProps.add(FightProp.DEFENSE, v);
              computedFightProps =
                  computedFightProps.add(FightProp.BASE_DEFENSE, v);
              break;
            default:
              computedFightProps = computedFightProps
                  .merge(computedFightProps.fightPropConvert(key, v));
          }
      }
    }

    return computedFightProps;
  }

  FightProps fightPropsConvert(FightProps fps) {
    FightProps converted = FightProps({});

    for (var k in fps.keys) {
      converted = converted.merge(fightPropConvert(k, fps.get(k)));
    }

    return converted;
  }

  FightProps fightPropConvert(FightProp k, double v) {
    switch (k) {
      case FightProp.ELEMENTAL_BURST_ADD_HURT_ON_CHARGE_EFFICIENCY:
        var add = v * (fightProps[FightProp.CHARGE_EFFICIENCY] ?? 0);
        if (add > 0.75) {
          add = 0.75;
        }
        return FightProps({
          FightProp.ELEMENTAL_BURST_ADD_HURT: add,
        });
      case FightProp.ATTACK_PERCENT_ON_CHARGE_EFFICIENCY:
        var add = (fightProps[FightProp.CHARGE_EFFICIENCY] ?? 0 - 1);
        return FightProps({
          FightProp.ATTACK_PERCENT: add,
        });
      case FightProp.ATTACK_PERCENT_ON_HP:
        var add = v * (fightProps[FightProp.HP_PERCENT] ?? 0 - 1);
        return FightProps({
          FightProp.ATTACK_PERCENT: add,
        });
      default:
        return FightProps({k: v});
    }
  }

  double attackHurt(List<FightProp> hurtAddFightTypes,
      [base = FightProp.ATTACK]) {
    var hurt = get(base);

    for (var hurtAddType in hurtAddFightTypes) {
      hurt = hurt * (1 + get(hurtAddType));
    }

    return hurt * defensiveRatio() * resistanceRatio();
  }

  double defensiveRatio() {
    var l = get(FightProp.LEVEL);
    var def = get(FightProp.ENEMY_LEVEL) + 100;
    var f = get(FightProp.ENEMY_SUB_DEFENSE);
    return (l + 100) / ((1 - f) * def + l + 100);
  }

  double resistanceRatio() {
    var r0 = get(FightProp.ENEMY_RESISTANCE);
    var r = get(FightProp.ENEMY_SUB_RESISTANCE);

    if (r == 0) {
      if (r0 > 0.75) {
        return 0.25 / (0.25 + r0);
      }
      if (r0 > 0) {
        return 1 - r0;
      }
      return 1 - r0 / 2;
    }

    if (r0 > 0.75) {
      if (r0 - r < 0) {
        return (0.25 + r0) * (1 - (r0 - r) / 2) / 0.25;
      }

      if (r - r0 < 0.75) {
        return (0.25 + r0) * (1 - (r0 - r)) / 0.25;
      }

      return (0.25 + r0) / (0.25 + (r0 - r));
    }

    if (r0 > 0) {
      if (0.75 > r && r > r0) {
        return (1 + (r - r0) / 2) / (1 - r0);
      }

      return 1 + r / (1 - r0);
    }

    return 1 + r / (2 - r0);
  }

  double criticalHurt(double v) {
    return v * (1 + get(FightProp.CRITICAL_HURT));
  }

  double meltHurt(double v, ElementType from) {
    var meltRatio = get(FightProp.MELT_ADD_HURT) +
        ElementalReaction.Melt.elementMasterAddHurt(
            get(FightProp.ELEMENT_MASTERY));

    return v * (1 + meltRatio) * (from == ElementType.Pyro ? 2 : 1.5);
  }

  double vaporizeHurt(double v, ElementType from) {
    var vaporize = get(FightProp.VAPORIZE_ADD_HURT) +
        ElementalReaction.Vaporize.elementMasterAddHurt(
            get(FightProp.ELEMENT_MASTERY));

    return v * (1 + vaporize) * (from == ElementType.Hydro ? 2 : 1.5);
  }

  double elementalReactionHurt(ElementalReaction elementalReaction) {
    var radio =
        elementalReaction.elementMasterAddHurt(get(FightProp.ELEMENT_MASTERY)) +
            get(elementalReactionAddHurtTypes[elementalReaction]!);

    return (1 + radio) *
        elementalReaction.characterHurtBase(get(FightProp.LEVEL).toInt()) *
        resistanceRatio();
  }
}

Map<ElementalReaction, FightProp> elementalReactionAddHurtTypes = {
  ElementalReaction.Vaporize: FightProp.VAPORIZE_ADD_HURT,
  ElementalReaction.Melt: FightProp.MELT_ADD_HURT,
  ElementalReaction.Swirl: FightProp.SWIRL_ADD_HURT,
  ElementalReaction.SuperConduct: FightProp.SUPER_CONDUCT_ADD_HURT,
  ElementalReaction.ElectroCharged: FightProp.ELECTRO_CHARGED_ADD_HURT,
  ElementalReaction.Overloaded: FightProp.OVERLOADED_ADD_HURT,
  ElementalReaction.Shattered: FightProp.SHATTERED_ADD_HURT,
  ElementalReaction.Crystallize: FightProp.SHIELD_COST_MINUS_RATIO,
};

Map<ElementalReaction, FightProp> elementHurtTypes = {
  ElementalReaction.SuperConduct: FightProp.ICE_ADD_HURT,
  ElementalReaction.ElectroCharged: FightProp.ELEC_ADD_HURT,
  ElementalReaction.Overloaded: FightProp.FIRE_ADD_HURT,
  ElementalReaction.Shattered: FightProp.PHYSICAL_ADD_HURT,
};
