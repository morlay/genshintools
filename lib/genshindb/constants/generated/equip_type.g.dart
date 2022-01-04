// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../equip_type.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$EquipTypeStringConverter implements JsonConverter<EquipType, String> {
  const _$EquipTypeStringConverter();

  @override
  EquipType fromJson(String json) => $enumDecode(_$EquipTypeEnumMap, json);

  @override
  String toJson(EquipType v) => _$EquipTypeEnumMap[v] ?? "";
}

const _$EquipTypeLabelMap = {
  EquipType.BRACER: "花",
  EquipType.NECKLACE: "羽",
  EquipType.SHOES: "沙",
  EquipType.RING: "杯",
  EquipType.DRESS: "头"
};

const _$EquipTypeFormatMap = {
  EquipType.BRACER: "P",
  EquipType.NECKLACE: "P",
  EquipType.SHOES: "P",
  EquipType.RING: "P",
  EquipType.DRESS: "P"
};

extension EquipTypeMeta on EquipType {
  String label() {
    return _$EquipTypeLabelMap[EquipType.values[index]] ?? "";
  }

  String format() {
    return _$EquipTypeFormatMap[EquipType.values[index]] ?? "";
  }

  String string() {
    return _$EquipTypeEnumMap[EquipType.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$EquipTypeEnumMap = {
  EquipType.BRACER: 'EQUIP_BRACER',
  EquipType.NECKLACE: 'EQUIP_NECKLACE',
  EquipType.SHOES: 'EQUIP_SHOES',
  EquipType.RING: 'EQUIP_RING',
  EquipType.DRESS: 'EQUIP_DRESS',
};
