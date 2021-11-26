// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../material_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MaterialService _$$_MaterialServiceFromJson(Map<String, dynamic> json) =>
    _$_MaterialService(
      materials: (json['Materials'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            int.parse(k), GSMaterial.fromJson(e as Map<String, dynamic>)),
      ),
      dungeons: (json['Dungeons'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            int.parse(k), GSDungeon.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_MaterialServiceToJson(_$_MaterialService instance) =>
    <String, dynamic>{
      'Materials': instance.materials?.map((k, e) => MapEntry(k.toString(), e)),
      'Dungeons': instance.dungeons?.map((k, e) => MapEntry(k.toString(), e)),
    };
