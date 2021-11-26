// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthStateV1 _$$_AuthStateV1FromJson(Map<String, dynamic> json) =>
    _$_AuthStateV1(
      encodedCookie: json['encodedCookie'] as String,
      gameRoles: (json['gameRoles'] as List<dynamic>?)
              ?.map((e) => GameRole.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AuthStateV1ToJson(_$_AuthStateV1 instance) =>
    <String, dynamic>{
      'encodedCookie': instance.encodedCookie,
      'gameRoles': instance.gameRoles,
    };

_$_AuthState _$$_AuthStateFromJson(Map<String, dynamic> json) => _$_AuthState(
      currentUID: json['currentUID'] as String,
      cookies: (json['cookies'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      roles: (json['roles'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, GameRole.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$$_AuthStateToJson(_$_AuthState instance) =>
    <String, dynamic>{
      'currentUID': instance.currentUID,
      'cookies': instance.cookies,
      'roles': instance.roles,
      'channel': instance.channel,
    };
