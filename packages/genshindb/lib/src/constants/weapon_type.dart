import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/annotations.dart';

part '__generated__/weapon_type.g.dart';

class WeaponTypeStringConverter extends _$WeaponTypeStringConverter {
  const WeaponTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum WeaponType {
  @EnumMeta(label: '单手剑')
  @JsonValue('WEAPON_SWORD_ONE_HAND')
  Sword,

  @EnumMeta(label: '大剑')
  @JsonValue('WEAPON_CLAYMORE')
  Claymore,

  @EnumMeta(label: '长枪')
  @JsonValue('WEAPON_POLE')
  Polearm,

  @EnumMeta(label: '弓箭')
  @JsonValue('WEAPON_BOW')
  Bow,

  @EnumMeta(label: '法器')
  @JsonValue('WEAPON_CATALYST')
  Catalyst,
}
