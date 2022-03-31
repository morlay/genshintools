import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/annotations.dart';

part '__generated__/skill_type.g.dart';

class SkillTypeStringConverter extends _$SkillTypeStringConverter {
  const SkillTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum SkillType {
  @EnumMeta(label: "普通攻击")
  @JsonValue("A")
  NORMAL_ATTACK,

  @EnumMeta(label: "元素战技")
  @JsonValue("E")
  ELEMENTAL_SKILL,

  @EnumMeta(label: "元素爆发")
  @JsonValue("Q")
  ELEMENTAL_BURST,

  @EnumMeta(label: "其他")
  @JsonValue("")
  OTHERS,
}
