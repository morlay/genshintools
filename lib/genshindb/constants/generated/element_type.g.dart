// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../element_type.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$ElementTypeStringConverter
    implements JsonConverter<ElementType, String> {
  const _$ElementTypeStringConverter();

  @override
  ElementType fromJson(String json) => $enumDecode(_$ElementTypeEnumMap, json);

  @override
  String toJson(ElementType v) => _$ElementTypeEnumMap[v] ?? "";
}

const _$ElementTypeLabelMap = {
  ElementType.Pyro: "火",
  ElementType.Cryo: "冰",
  ElementType.Electro: "雷",
  ElementType.Hydro: "水",
  ElementType.Anemo: "风",
  ElementType.Geo: "岩",
  ElementType.Dendro: "草",
  ElementType.Physical: "物理"
};

const _$ElementTypeFormatMap = {
  ElementType.Pyro: "P",
  ElementType.Cryo: "P",
  ElementType.Electro: "P",
  ElementType.Hydro: "P",
  ElementType.Anemo: "P",
  ElementType.Geo: "P",
  ElementType.Dendro: "P",
  ElementType.Physical: "P"
};

extension ElementTypeMeta on ElementType {
  String label() {
    return _$ElementTypeLabelMap[ElementType.values[index]] ?? "";
  }

  String format() {
    return _$ElementTypeFormatMap[ElementType.values[index]] ?? "";
  }

  String string() {
    return _$ElementTypeEnumMap[ElementType.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$ElementTypeEnumMap = {
  ElementType.Pyro: 'Pyro',
  ElementType.Cryo: 'Cryo',
  ElementType.Electro: 'Electro',
  ElementType.Hydro: 'Hydro',
  ElementType.Anemo: 'Anemo',
  ElementType.Geo: 'Geo',
  ElementType.Dendro: 'Dendro',
  ElementType.Physical: 'Physical',
};
