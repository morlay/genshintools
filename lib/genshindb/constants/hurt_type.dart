import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/annotations.dart';

part 'generated/hurt_type.g.dart';

class HurtTypeStringConverter extends _$HurtTypeStringConverter {
  const HurtTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum HurtType {
  @EnumMeta(label: "普攻")
  NormalAttack,

  @EnumMeta(label: "重击")
  ChangedAttack,

  @EnumMeta(label: "下落攻击")
  PlungingAttack,

  @EnumMeta(label: "元素技能伤害")
  ElementalSkill,

  @EnumMeta(label: "元素爆发伤害")
  ElementalBurst,
}
