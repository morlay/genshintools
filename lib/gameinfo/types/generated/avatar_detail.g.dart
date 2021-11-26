// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../avatar_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AvatarDetail _$$_AvatarDetailFromJson(Map<String, dynamic> json) =>
    _$_AvatarDetail(
      weapon:
          AvatarDetailWeapon.fromJson(json['weapon'] as Map<String, dynamic>),
      skillList: (json['skill_list'] as List<dynamic>)
          .map((e) => AvatarDetailSkill.fromJson(e as Map<String, dynamic>))
          .toList(),
      reliquaryList: (json['reliquary_list'] as List<dynamic>)
          .map((e) => AvatarDetailReliquary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AvatarDetailToJson(_$_AvatarDetail instance) =>
    <String, dynamic>{
      'weapon': instance.weapon,
      'skill_list': instance.skillList,
      'reliquary_list': instance.reliquaryList,
    };

_$_AvatarDetailSkill _$$_AvatarDetailSkillFromJson(Map<String, dynamic> json) =>
    _$_AvatarDetailSkill(
      id: json['id'] as int,
      groupId: json['group_id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      maxLevel: json['max_level'] as int,
      levelCurrent: json['level_current'] as int,
    );

Map<String, dynamic> _$$_AvatarDetailSkillToJson(
        _$_AvatarDetailSkill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'group_id': instance.groupId,
      'name': instance.name,
      'icon': instance.icon,
      'max_level': instance.maxLevel,
      'level_current': instance.levelCurrent,
    };

_$_AvatarDetailWeapon _$$_AvatarDetailWeaponFromJson(
        Map<String, dynamic> json) =>
    _$_AvatarDetailWeapon(
      id: json['id'] as int,
      weaponCatId: json['weapon_cat_id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      weaponLevel: json['weapon_level'] as int,
      levelCurrent: json['level_current'] as int,
      maxLevel: json['max_level'] as int,
    );

Map<String, dynamic> _$$_AvatarDetailWeaponToJson(
        _$_AvatarDetailWeapon instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weapon_cat_id': instance.weaponCatId,
      'name': instance.name,
      'icon': instance.icon,
      'weapon_level': instance.weaponLevel,
      'level_current': instance.levelCurrent,
      'max_level': instance.maxLevel,
    };

_$_AvatarDetailReliquary _$$_AvatarDetailReliquaryFromJson(
        Map<String, dynamic> json) =>
    _$_AvatarDetailReliquary(
      id: json['id'] as int,
      reliquaryCatId: json['reliquary_cat_id'] as int,
      name: json['name'] as String,
      icon: json['icon'] as String,
      reliquaryLevel: json['reliquary_level'] as int,
      levelCurrent: json['level_current'] as int,
      maxLevel: json['max_level'] as int,
    );

Map<String, dynamic> _$$_AvatarDetailReliquaryToJson(
        _$_AvatarDetailReliquary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reliquary_cat_id': instance.reliquaryCatId,
      'name': instance.name,
      'icon': instance.icon,
      'reliquary_level': instance.reliquaryLevel,
      'level_current': instance.levelCurrent,
      'max_level': instance.maxLevel,
    };
