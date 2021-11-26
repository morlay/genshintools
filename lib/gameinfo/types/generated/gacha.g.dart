// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gacha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GachaType _$$_GachaTypeFromJson(Map<String, dynamic> json) => _$_GachaType(
      key: json['key'] as String,
      name: json['name'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_GachaTypeToJson(_$_GachaType instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'id': instance.id,
    };

_$_GachaLog _$$_GachaLogFromJson(Map<String, dynamic> json) => _$_GachaLog(
      uid: json['uid'] as String,
      gachaType: json['gacha_type'] as String,
      name: json['name'] as String,
      lang: json['lang'] as String,
      itemType: json['item_type'] as String,
      rankType: json['rank_type'] as String,
      id: json['id'] as String,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$$_GachaLogToJson(_$_GachaLog instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'gacha_type': instance.gachaType,
      'name': instance.name,
      'lang': instance.lang,
      'item_type': instance.itemType,
      'rank_type': instance.rankType,
      'id': instance.id,
      'time': instance.time.toIso8601String(),
    };
