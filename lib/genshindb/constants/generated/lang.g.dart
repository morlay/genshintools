// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../lang.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$LangStringConverter implements JsonConverter<Lang, String> {
  const _$LangStringConverter();

  @override
  Lang fromJson(String json) => $enumDecode(_$LangEnumMap, json);

  @override
  String toJson(Lang v) => _$LangEnumMap[v] ?? "";
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$LangEnumMap = {
  Lang.KEY: 'KEY',
  Lang.CHS: 'CHS',
  Lang.EN: 'EN',
};
