// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gacha_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UigfInfo _$$_UigfInfoFromJson(Map<String, dynamic> json) => _$_UigfInfo(
      uid: json['uid'] as String,
      lang: json['lang'] as String,
      uigfVersion: json['uigf_version'] as String? ?? "v2.2",
    );

Map<String, dynamic> _$$_UigfInfoToJson(_$_UigfInfo instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'lang': instance.lang,
      'uigf_version': instance.uigfVersion,
    };

_$_GachaState _$$_GachaStateFromJson(Map<String, dynamic> json) =>
    _$_GachaState(
      list: (json['list'] as List<dynamic>)
          .map((e) => GachaLog.fromJson(e as Map<String, dynamic>))
          .toList(),
      info: json['info'] == null
          ? null
          : UigfInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GachaStateToJson(_$_GachaState instance) =>
    <String, dynamic>{
      'list': instance.list,
      'info': instance.info,
    };
