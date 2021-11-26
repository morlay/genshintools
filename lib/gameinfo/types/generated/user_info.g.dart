// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfo _$$_UserInfoFromJson(Map<String, dynamic> json) => _$_UserInfo(
      avatars: (json['avatars'] as List<dynamic>?)
          ?.map((e) => Avatar.fromJson(e as Map<String, dynamic>))
          .toList(),
      homes: (json['homes'] as List<dynamic>?)
          ?.map((e) => Home.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserInfoToJson(_$_UserInfo instance) =>
    <String, dynamic>{
      'avatars': instance.avatars,
      'homes': instance.homes,
    };

_$_Avatar _$$_AvatarFromJson(Map<String, dynamic> json) => _$_Avatar(
      id: json['id'] as int,
      level: json['level'] as int,
      name: json['name'] as String,
      rarity: json['rarity'] as int,
      fetter: json['fetter'] as int,
      activedConstellationNum: json['actived_constellation_num'] as int,
      element: json['element'] as String,
      weapon: json['weapon'] == null
          ? null
          : Weapon.fromJson(json['weapon'] as Map<String, dynamic>),
      reliquaries: (json['reliquaries'] as List<dynamic>?)
          ?.map((e) => Reliquary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_AvatarToJson(_$_Avatar instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'rarity': instance.rarity,
      'fetter': instance.fetter,
      'actived_constellation_num': instance.activedConstellationNum,
      'element': instance.element,
      'weapon': instance.weapon,
      'reliquaries': instance.reliquaries,
    };

_$_Reliquary _$$_ReliquaryFromJson(Map<String, dynamic> json) => _$_Reliquary(
      id: json['id'] as int,
      level: json['level'] as int,
      name: json['name'] as String,
      rarity: json['rarity'] as int,
      pos: json['pos'] as int,
    );

Map<String, dynamic> _$$_ReliquaryToJson(_$_Reliquary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'rarity': instance.rarity,
      'pos': instance.pos,
    };

_$_Weapon _$$_WeaponFromJson(Map<String, dynamic> json) => _$_Weapon(
      id: json['id'] as int,
      level: json['level'] as int,
      name: json['name'] as String,
      rarity: json['rarity'] as int,
      affixLevel: json['affix_level'] as int,
    );

Map<String, dynamic> _$$_WeaponToJson(_$_Weapon instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'rarity': instance.rarity,
      'affix_level': instance.affixLevel,
    };

_$_Home _$$_HomeFromJson(Map<String, dynamic> json) => _$_Home(
      level: json['level'] as int,
      visitNum: json['visit_num'] as int,
      comfortNum: json['comfort_num'] as int,
      itemNum: json['item_num'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$$_HomeToJson(_$_Home instance) => <String, dynamic>{
      'level': instance.level,
      'visit_num': instance.visitNum,
      'comfort_num': instance.comfortNum,
      'item_num': instance.itemNum,
      'name': instance.name,
    };
