// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../enemy_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EnemyService _$$_EnemyServiceFromJson(Map<String, dynamic> json) =>
    _$_EnemyService(
      enemies: (json['Enemies'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(int.parse(k), GSEnemy.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_EnemyServiceToJson(_$_EnemyService instance) =>
    <String, dynamic>{
      'Enemies': instance.enemies?.map((k, e) => MapEntry(k.toString(), e)),
    };
