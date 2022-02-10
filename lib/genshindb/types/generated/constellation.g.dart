// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../constellation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GSConstellation _$$_GSConstellationFromJson(Map<String, dynamic> json) =>
    _$_GSConstellation(
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18n.fromJson(json['Desc'] as Map<String, dynamic>),
      addProps: FightProps.fromJson(json['AddProps'] as Map<String, dynamic>),
      additionalProps: (json['AdditionalProps'] as List<dynamic>)
          .map((e) => FightProps.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GSConstellationToJson(_$_GSConstellation instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Desc': instance.desc,
      'AddProps': instance.addProps,
      'AdditionalProps': instance.additionalProps,
    };
