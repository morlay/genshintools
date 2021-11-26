// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../game_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GameRole _$$_GameRoleFromJson(Map<String, dynamic> json) => _$_GameRole(
      gameBiz: json['game_biz'] as String,
      gameUid: json['game_uid'] as String,
      regionName: json['region_name'] as String,
      isChosen: json['is_chosen'] as bool,
      region: json['region'] as String,
      nickname: json['nickname'] as String,
      level: json['level'] as int,
    );

Map<String, dynamic> _$$_GameRoleToJson(_$_GameRole instance) =>
    <String, dynamic>{
      'game_biz': instance.gameBiz,
      'game_uid': instance.gameUid,
      'region_name': instance.regionName,
      'is_chosen': instance.isChosen,
      'region': instance.region,
      'nickname': instance.nickname,
      'level': instance.level,
    };
