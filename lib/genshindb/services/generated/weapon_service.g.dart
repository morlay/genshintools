// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../weapon_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WeaponService _$$_WeaponServiceFromJson(Map<String, dynamic> json) =>
    _$_WeaponService(
      weapons: (json['Weapons'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(int.parse(k), Weapon.fromJson(e as Map<String, dynamic>)),
      ),
      weaponLevelupExps: (json['WeaponLevelupExps'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
      weaponPromotes: json['WeaponPromotes'] == null
          ? null
          : GSPromoteSet.fromJson(
              json['WeaponPromotes'] as Map<String, dynamic>),
      weaponPropGrowCurveValues: json['WeaponPropGrowCurveValues'] == null
          ? null
          : PropGrowCurveValueSet.fromJson(
              json['WeaponPropGrowCurveValues'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WeaponServiceToJson(_$_WeaponService instance) =>
    <String, dynamic>{
      'Weapons': instance.weapons?.map((k, e) => MapEntry(k.toString(), e)),
      'WeaponLevelupExps': instance.weaponLevelupExps,
      'WeaponPromotes': instance.weaponPromotes,
      'WeaponPropGrowCurveValues': instance.weaponPropGrowCurveValues,
    };
