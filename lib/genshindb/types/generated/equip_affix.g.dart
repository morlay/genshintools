// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../equip_affix.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EquipAffix _$$_EquipAffixFromJson(Map<String, dynamic> json) =>
    _$_EquipAffix(
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18n.fromJson(json['Desc'] as Map<String, dynamic>),
      addProps: FightProps.fromJson(json['AddProps'] as Map<String, dynamic>),
      additionalProps: (json['AdditionalProps'] as List<dynamic>)
          .map((e) => FightProps.fromJson(e as Map<String, dynamic>))
          .toList(),
      level: json['Level'] as int?,
      activeWhenNum: json['ActiveWhenNum'] as int?,
    );

Map<String, dynamic> _$$_EquipAffixToJson(_$_EquipAffix instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Desc': instance.desc,
      'AddProps': instance.addProps,
      'AdditionalProps': instance.additionalProps,
      'Level': instance.level,
      'ActiveWhenNum': instance.activeWhenNum,
    };
