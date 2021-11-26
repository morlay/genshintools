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
  WeaponType.SWORD_ONE_HAND: "单手剑",
  WeaponType.WEAPON_CLAYMORE: "大剑",
  WeaponType.WEAPON_POLE: "长枪",
  WeaponType.POLE: "弓箭",
  WeaponType.CATALYST: "法器"
};

const _$WeaponTypeFormatMap = {
  WeaponType.SWORD_ONE_HAND: "P",
  WeaponType.WEAPON_CLAYMORE: "P",
  WeaponType.WEAPON_POLE: "P",
  WeaponType.POLE: "P",
  WeaponType.CATALYST: "P"
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
  WeaponType.SWORD_ONE_HAND: 'WEAPON_SWORD_ONE_HAND',
  WeaponType.WEAPON_CLAYMORE: 'WEAPON_CLAYMORE',
  WeaponType.WEAPON_POLE: 'WEAPON_POLE',
  WeaponType.POLE: 'WEAPON_BOW',
  WeaponType.CATALYST: 'WEAPON_CATALYST',
};
