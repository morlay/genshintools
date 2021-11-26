// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Release _$$_ReleaseFromJson(Map<String, dynamic> json) => _$_Release(
      packageName: json['packageName'] as String,
      version: json['version'] as String,
      buildNumber: json['buildNumber'] as String,
      downloadURL: json['downloadURL'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_ReleaseToJson(_$_Release instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'version': instance.version,
      'buildNumber': instance.buildNumber,
      'downloadURL': instance.downloadURL,
      'description': instance.description,
    };
