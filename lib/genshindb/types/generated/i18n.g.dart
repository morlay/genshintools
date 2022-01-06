// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../i18n.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_I18n _$$_I18nFromJson(Map<String, dynamic> json) => _$_I18n(
      (json['values'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$LangEnumMap, k), e as String),
      ),
    );

Map<String, dynamic> _$$_I18nToJson(_$_I18n instance) => <String, dynamic>{
      'values': instance.values.map((k, e) => MapEntry(_$LangEnumMap[k], e)),
    };

const _$LangEnumMap = {
  Lang.KEY: 'KEY',
  Lang.CHS: 'CHS',
  Lang.EN: 'EN',
};
