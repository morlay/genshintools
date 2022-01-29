import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/types/fight_props.dart';
import 'package:genshintools/genshindb/utils.dart';

import 'i18n.dart';
import 'material.dart';

part 'generated/skill.freezed.dart';
part 'generated/skill.g.dart';

@freezed
class Skill with _$Skill {
  Skill._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory Skill({
    required I18n name,
    required I18n desc,
    @SkillTypeStringConverter() required SkillType skillType,
    List<I18n>? paramNames,
    List<List<double>>? params,
    List<List<GSMaterialCost>>? materialCosts,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

  List<double> paramsForLevel(int level) {
    return params?[rangeLimit(level, 1, 13) - 1] ?? [];
  }

  int priority(List<List<SkillType>> priorities) {
    var p = -1;

    priorities.forEachIndexed((index, element) {
      if (element.contains(skillType)) {
        p = 3 - index;
      }
    });

    return p;
  }
}

@freezed
class InherentSkill with _$InherentSkill {
  InherentSkill._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory InherentSkill({
    required I18n name,
    required I18n desc,
    List<I18n>? paramNames,
    List<double>? params,
    int? breakLevel,
  }) = _InherentSkilll;

  factory InherentSkill.fromJson(Map<String, dynamic> json) =>
      _$InherentSkillFromJson(json);

  FightProps patchedFightProps() {
    switch (name.text(Lang.CHS)) {
      case "储之千日，用之一刻":
        return FightProps({
          FightProp.ROCK_ADD_HURT: params![1],
        });
      case "炊金馔玉":
        return FightProps({
          FightProp.NORMAL_ATTACK_EXTRA_HURT__ON__HP: params![0],
          FightProp.CHARGED_ATTACK_EXTRA_HURT__ON__HP: params![0],
          FightProp.PLUNGING_ATTACK_EXTRA_HURT__ON__HP: params![0],
          FightProp.ELEMENTAL_SKILL_EXTRA_HURT__ON__HP: params![1],
          FightProp.ELEMENTAL_BURST_EXTRA_HURT__ON__HP: params![2],
        });
      case "悬岩宸断":
        return FightProps({
          FightProp.SHIELD_COST_MINUS_RATIO: params![0] * 5,
        });
      case "袖火百景图":
        return FightProps({
          FightProp.FIRE_ADD_HURT: params![0] * 5,
        });
      case "玉衡之贵":
        return FightProps({
          FightProp.ELEMENTAL_BURST_ADD_CRITICAL: params![0],
          FightProp.CHARGE_EFFICIENCY: params![1],
        });
      case "虚实工笔":
        return FightProps({
          FightProp.WATER_ADD_HURT: 0.2,
        });
      default:
        return FightProps({});
    }
  }
}

minLevelFromBreakLevel(int level) {
  switch (level) {
    case 5:
      return 81;
    case 4:
      return 61;
    case 3:
      return 51;
    case 2:
      return 51;
    case 1:
      return 1;
  }
}
