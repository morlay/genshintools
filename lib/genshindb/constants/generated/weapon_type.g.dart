// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../weapon_type.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$WeaponTypeStringConverter implements JsonConverter<WeaponType, String> {
  const _$WeaponTypeStringConverter();

  @override
  WeaponType fromJson(String json) => $enumDecode(_$WeaponTypeEnumMap, json);

  @override
  String toJson(WeaponType v) => _$WeaponTypeEnumMap[v] ?? "";
}

const _$WeaponTypeLabelMap = {
  WeaponType.Sword: "单手剑",
  WeaponType.Claymore: "大剑",
  WeaponType.Polearm: "长枪",
  WeaponType.Bow: "弓箭",
  WeaponType.Catalyst: "法器"
};

const _$WeaponTypeFormatMap = {
  WeaponType.Sword: "P",
  WeaponType.Claymore: "P",
  WeaponType.Polearm: "P",
  WeaponType.Bow: "P",
  WeaponType.Catalyst: "P"
};

extension WeaponTypeMeta on WeaponType {
  String label() {
    return _$WeaponTypeLabelMap[WeaponType.values[index]] ?? "";
  }

  String format() {
    return _$WeaponTypeFormatMap[WeaponType.values[index]] ?? "";
  }

  String string() {
    return _$WeaponTypeEnumMap[WeaponType.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$WeaponTypeEnumMap = {
  WeaponType.Sword: 'WEAPON_SWORD_ONE_HAND',
  WeaponType.Claymore: 'WEAPON_CLAYMORE',
  WeaponType.Polearm: 'WEAPON_POLE',
  WeaponType.Bow: 'WEAPON_BOW',
  WeaponType.Catalyst: 'WEAPON_CATALYST',
};
