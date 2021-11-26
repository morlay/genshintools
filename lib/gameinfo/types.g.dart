// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo()
  ..avatars = (json['avatars'] as List<dynamic>?)
      ?.map((e) => Avatar.fromJson(e as Map<String, dynamic>))
      .toList()
  ..homes = (json['homes'] as List<dynamic>?)
      ?.map((e) => Home.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'avatars': instance.avatars,
      'homes': instance.homes,
    };

Avatar _$AvatarFromJson(Map<String, dynamic> json) => Avatar()
  ..id = json['id'] as int?
  ..level = json['level'] as int?
  ..name = json['name'] as String?
  ..rarity = json['rarity'] as int?
  ..fetter = json['fetter'] as int?
  ..activeConstellationNum = json['actived_constellation_num'] as int?
  ..element = json['element'] as String?
  ..weapon = json['weapon'] == null
      ? null
      : Weapon.fromJson(json['weapon'] as Map<String, dynamic>)
  ..reliquaries = (json['reliquaries'] as List<dynamic>?)
      ?.map((e) => Reliquary.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$AvatarToJson(Avatar instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'rarity': instance.rarity,
      'fetter': instance.fetter,
      'actived_constellation_num': instance.activeConstellationNum,
      'element': instance.element,
      'weapon': instance.weapon,
      'reliquaries': instance.reliquaries,
    };

Reliquary _$ReliquaryFromJson(Map<String, dynamic> json) => Reliquary()
  ..id = json['id'] as int?
  ..level = json['level'] as int?
  ..name = json['name'] as String?
  ..rarity = json['rarity'] as int?;

Map<String, dynamic> _$ReliquaryToJson(Reliquary instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'rarity': instance.rarity,
    };

Weapon _$WeaponFromJson(Map<String, dynamic> json) => Weapon()
  ..id = json['id'] as int?
  ..level = json['level'] as int?
  ..name = json['name'] as String?
  ..rarity = json['rarity'] as int?
  ..affixLevel = json['affix_level'] as int?;

Map<String, dynamic> _$WeaponToJson(Weapon instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'name': instance.name,
      'rarity': instance.rarity,
      'affix_level': instance.affixLevel,
    };

Home _$HomeFromJson(Map<String, dynamic> json) => Home()
  ..id = json['id'] as int?
  ..level = json['level'] as int?
  ..comfortNum = json['comfort_num'] as int?
  ..visitNum = json['visit_num'] as int?
  ..name = json['name'] as String?
  ..type = json['type'] as String?;

Map<String, dynamic> _$HomeToJson(Home instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'comfort_num': instance.comfortNum,
      'visit_num': instance.visitNum,
      'name': instance.name,
      'type': instance.type,
    };
