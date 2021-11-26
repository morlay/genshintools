import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/annotations.dart';

part 'generated/weapon_type.g.dart';

class WeaponTypeStringConverter extends _$WeaponTypeStringConverter {
  const WeaponTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum WeaponType {
  @EnumMeta(label: "单手剑")
  @JsonValue("WEAPON_SWORD_ONE_HAND")
  SWORD_ONE_HAND,

  @EnumMeta(label: "大剑")
  @JsonValue("WEAPON_CLAYMORE")
  WEAPON_CLAYMORE,

  @EnumMeta(label: "长枪")
  @JsonValue("WEAPON_POLE")
  WEAPON_POLE,

  @EnumMeta(label: "弓箭")
  @JsonValue("WEAPON_BOW")
  POLE,

  @EnumMeta(label: "法器")
  @JsonValue("WEAPON_CATALYST")
  CATALYST,
}
