// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../webdav.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WebDAV _$$_WebDAVFromJson(Map<String, dynamic> json) => _$_WebDAV(
      address: json['address'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      syncAt: json['syncAt'] == null
          ? null
          : DateTime.parse(json['syncAt'] as String),
      fromServer: json['fromServer'] as bool?,
      valid: json['valid'] as bool?,
    );

Map<String, dynamic> _$$_WebDAVToJson(_$_WebDAV instance) => <String, dynamic>{
      'address': instance.address,
      'username': instance.username,
      'password': instance.password,
      'syncAt': instance.syncAt?.toIso8601String(),
      'fromServer': instance.fromServer,
      'valid': instance.valid,
    };