import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';
import 'package:genshindb/utils.dart';
import 'package:collection/collection.dart';

part '__generated__/fight_props.freezed.dart';

part '__generated__/fight_props.g.dart';

@freezed
class FightProps with _$FightProps {
  FightProps._();

  factory FightProps(
    @FightPropStringConverter() Map<FightProp, double> fightProps, {
    String? name,
    List<FightProps>? from,
  }) = _FightProps;

  factory FightProps.fromJson(Map<String, dynamic> json) =>
      _FightProps.fromJson(
        {
          'name': json[r'$when'],
          'fightProps': json..remove(r'$when'),
        },
      );

  Iterable<FightProp> get keys => fightProps.keys;

  List<FightProps> get allFrom => [
        ...?from?.expand((e) => [e, ...e.allFrom]),
      ];

  double? calcValue(FightProp fp, double value) {
    if (fp == FightProp.ATTACK_PERCENT) {
      return get(FightProp.BASE_ATTACK) * value;
    }
    if (fp == FightProp.HP_PERCENT) {
      return get(FightProp.BASE_HP) * value;
    }
    if (fp == FightProp.DEFENSE_PERCENT) {
      return get(FightProp.BASE_DEFENSE) * value;
    }
    return null;
  }

  double? operator [](FightProp? key) {
    return fightProps[key];
  }

  double get(FightProp fp) {
    return fightProps[fp] ?? 0;
  }

  double calcAttackAdd(String t, List<double> params) {
    return calc('$t基础攻击力', params) +
        calc(
          '{param1:F2P}基础攻击力',
          [get(FightProp.ATTACK_ADD_RADIO)],
        );
  }

  double calc(String label, List<double> params) {
    Map<String, FightProp> bases = {
      '基础攻击力': FightProp.BASE_ATTACK,
      '攻击力': FightProp.ATTACK,
      '防御力': FightProp.DEFENSE,
      '生命值上限': FightProp.HP,
      '最大生命值': FightProp.HP,
    };

    return label.split('+').fold<double>(0, (previousValue, l) {
      var base = 0.0;
      l = l.trim();

      for (final n in bases.keys) {
        if (l.contains(n)) {
          l = l.replaceAll(n, '');
          base = get(bases[n]!);
          break;
        }
      }

      l = l.replaceAll('每秒', '');

      return previousValue +
          double.parse(
            exec(l, params, (v, fmt) {
              if (fmt == 'I') {
                return '$v';
              }
              return '${base * v}';
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
    return copyWith(
      fightProps: {
        ...fightProps,
        fp: get(fp) + v,
      },
    );
  }

  FightProps merge(FightProps fps) {
    return fps.fightProps.isEmpty
        ? this
        : copyWith(
            fightProps: {
              ...fightProps,
              ...fps.fightProps
                  .map((fp, v) => MapEntry(fp, (fightProps[fp] ?? 0) + v))
            },
            from: [
              this,
              fps,
            ],
          );
  }

  FightProps mergeAll(List<FightProps> list) {
    return list.fold(this, (previousValue, fps) => previousValue.merge(fps));
  }

  FightProps compute() {
    var computedFightProps = FightProps(
      {
        FightProp.LEVEL: rangeLimit(fightProps[FightProp.LEVEL] ?? 1, 1, 90),
      },
      name: name,
      from: from,
    );

    for (final key in FightProp.values) {
      var v = get(key);

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
    FightProps converted = fps.copyWith(fightProps: {});

    for (final k in fps.keys) {
      converted = converted.merge(fightPropConvert(k, fps.get(k)));
    }

    return converted;
  }

  FightProps fightPropConvert(FightProp k, double v) {
    if (k.name.contains('__ON__')) {
      var parts = k.name.split('__ON__');
      var parts2 = parts.last.split('__');

      var toFp = FightProp.values.firstWhere((fp) => fp.name == parts.first);
      var fromFp = FightProp.values.firstWhere((fp) => fp.name == parts2.first);
      var props =
          parts2.slice(1).fold<Map<String, double>>({}, (props, element) {
        var parts = element.split(r'$');
        var prop = parts.first.toUpperCase();
        var value = double.parse(parts.last.replaceAll('_', '.'));

        return {
          ...props,
          prop: value,
        };
      });
      var ret = v * (get(fromFp) - (props['OVER'] ?? 0));
      if (props['MAX'] != null && ret > props['MAX']!) {
        ret = props['MAX']!;
      }
      return FightProps({toFp: ret});
    }
    return FightProps({k: v});
  }

  /// https://bbs.nga.cn/read.php?tid=25564438
  double attackHurt(
    ElementType e,
    double r,
    List<FightProp> hurtAddFightTypes, [
    base = FightProp.ATTACK,
  ]) {
    var hurt = get(base) * r;

    var hurtAdd = get(elementFightProps[e]!);

    for (final hurtAddType in hurtAddFightTypes) {
      var extra = 0.0;
      var radio = 0.0;

      switch (hurtAddType) {
        case FightProp.NORMAL_ATTACK_ADD_HURT:
          extra = get(FightProp.NORMAL_ATTACK_EXTRA_HURT);
          radio = get(FightProp.NORMAL_ATTACK_RADIO);
          break;
        case FightProp.PLUNGING_ATTACK_ADD_HURT:
          extra = get(FightProp.PLUNGING_ATTACK_EXTRA_HURT);
          radio = get(FightProp.PLUNGING_ATTACK_RADIO);
          break;
        case FightProp.CHARGED_ATTACK_ADD_HURT:
          extra = get(FightProp.CHARGED_ATTACK_EXTRA_HURT);
          radio = get(FightProp.CHARGED_ATTACK_RADIO);
          break;
        case FightProp.ELEMENTAL_SKILL_ADD_HURT:
          extra = get(FightProp.ELEMENTAL_SKILL_EXTRA_HURT);
          radio = get(FightProp.ELEMENTAL_SKILL_RADIO);
          break;
        case FightProp.ELEMENTAL_BURST_ADD_HURT:
          extra = get(FightProp.ELEMENTAL_BURST_EXTRA_HURT);
          radio = get(FightProp.ELEMENTAL_BURST_RADIO);
          break;
        default:
      }

      hurt = hurt * (radio > 0 ? radio : 1) + extra;

      hurtAdd += get(hurtAddType);
    }

    return hurt * (1 + hurtAdd) * defensiveRatio() * resistanceRatio(e);
  }

  double defensiveRatio() {
    var lvl = get(FightProp.LEVEL) + 100;
    var elvl = get(FightProp.ENEMY_LEVEL) + 100;
    var subDef = get(FightProp.ENEMY_SUB_DEFENSE);
    var subAdd = 0;
    var ignoreDef = 0;

    return lvl / (lvl + (1 - ignoreDef) * (1 - subDef + subAdd) * elvl);
  }

  double resistanceRatio(ElementType et) {
    var x = get(
      {
        ElementType.Physical: FightProp.ENEMY_PHYSICAL_SUB_HURT,
        ElementType.Pyro: FightProp.ENEMY_FIRE_SUB_HURT,
        ElementType.Hydro: FightProp.ENEMY_WATER_SUB_HURT,
        ElementType.Cryo: FightProp.ENEMY_ICE_SUB_HURT,
        ElementType.Anemo: FightProp.ENEMY_WIND_SUB_HURT,
        ElementType.Electro: FightProp.ENEMY_ELEC_SUB_HURT,
        ElementType.Geo: FightProp.ENEMY_ROCK_SUB_HURT,
        ElementType.Dendro: FightProp.ENEMY_GRASS_SUB_HURT,
      }[et]!,
    );

    if (x >= 0.75) {
      return 1 / (1 + 4 * x);
    }

    if (x >= 0) {
      return 1 - x;
    }

    return 1 - (x / 2);
  }

  double criticalHurt(double v) {
    return v * (1 + get(FightProp.CRITICAL_HURT));
  }

  double meltHurt(double v, ElementType from) {
    var meltRatio = get(FightProp.MELT_ADD_HURT) +
        ElementalReaction.Melt.elementMasterAddHurt(
          get(FightProp.ELEMENT_MASTERY),
        );

    return v * (1 + meltRatio) * (from == ElementType.Pyro ? 2 : 1.5);
  }

  double vaporizeHurt(double v, ElementType from) {
    var vaporize = get(FightProp.VAPORIZE_ADD_HURT) +
        ElementalReaction.Vaporize.elementMasterAddHurt(
          get(FightProp.ELEMENT_MASTERY),
        );

    return v * (1 + vaporize) * (from == ElementType.Hydro ? 2 : 1.5);
  }

  double elementalReactionHurt(
    ElementType e,
    ElementalReaction elementalReaction,
  ) {
    var base =
        elementalReaction.characterHurtBase(get(FightProp.LEVEL).toInt()) *
            (1 +
                elementalReaction
                    .elementMasterAddHurt(get(FightProp.ELEMENT_MASTERY))) *
            resistanceRatio(e);

    return base * (1 + get(elementalReactionAddHurtTypes[elementalReaction]!));
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

Map<ElementType, FightProp> elementFightProps = {
  ElementType.Pyro: FightProp.FIRE_ADD_HURT,
  ElementType.Electro: FightProp.ELEC_ADD_HURT,
  ElementType.Hydro: FightProp.WATER_ADD_HURT,
  ElementType.Cryo: FightProp.ICE_ADD_HURT,
  ElementType.Anemo: FightProp.WIND_ADD_HURT,
  ElementType.Geo: FightProp.ROCK_ADD_HURT,
  ElementType.Dendro: FightProp.GRASS_ADD_HURT,
  ElementType.Physical: FightProp.PHYSICAL_ADD_HURT,
};
