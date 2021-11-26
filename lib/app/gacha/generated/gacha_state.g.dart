// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../gacha_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GachaState _$$_GachaStateFromJson(Map<String, dynamic> json) =>
    _$_GachaState(
      logs: (json['logs'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) => GachaLog.fromJson(e as Map<String, dynamic>))
                    .toList()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$_GachaStateToJson(_$_GachaState instance) =>
    <String, dynamic>{
      'logs': instance.logs,
    };
