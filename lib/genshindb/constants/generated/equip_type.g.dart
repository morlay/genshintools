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
  EquipType.FLOWER: "花",
  EquipType.FEATHER: "羽",
  EquipType.SANDS: "沙",
  EquipType.GOBLET: "杯",
  EquipType.CIRCLET: "头"
};

const _$EquipTypeFormatMap = {
  EquipType.FLOWER: "P",
  EquipType.FEATHER: "P",
  EquipType.SANDS: "P",
  EquipType.GOBLET: "P",
  EquipType.CIRCLET: "P"
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
  EquipType.FLOWER: 'EQUIP_BRACER',
  EquipType.FEATHER: 'EQUIP_NECKLACE',
  EquipType.SANDS: 'EQUIP_SHOES',
  EquipType.GOBLET: 'EQUIP_RING',
  EquipType.CIRCLET: 'EQUIP_DRESS',
};
