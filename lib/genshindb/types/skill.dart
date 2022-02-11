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
    required FightProps addProps,
    required List<FightProps> additionalProps,
    List<I18n>? paramNames,
    int? breakLevel,
  }) = _InherentSkilll;

  factory InherentSkill.fromJson(Map<String, dynamic> json) =>
      _$InherentSkillFromJson(json);

  FightProps patchedFightProps() {
    return addProps;
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
