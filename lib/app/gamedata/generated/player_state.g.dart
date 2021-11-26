// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../player_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlayerState _$$_PlayerStateFromJson(Map<String, dynamic> json) =>
    _$_PlayerState(
      characters: (json['characters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k), CharacterState.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_PlayerStateToJson(_$_PlayerState instance) =>
    <String, dynamic>{
      'characters':
          instance.characters.map((k, e) => MapEntry(k.toString(), e)),
    };

_$_CharacterState _$$_CharacterStateFromJson(Map<String, dynamic> json) =>
    _$_CharacterState(
      id: json['id'] as int,
      level: json['level'] as int,
      activeConstellationNum: json['activeConstellationNum'] as int,
      skillLevels: (json['skillLevels'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$SkillTypeEnumMap, k), e as int),
      ),
      own: json['own'] as bool,
      todo: json['todo'] as bool,
      build:
          CharacterBuildState.fromJson(json['build'] as Map<String, dynamic>),
      defaultBuild: json['defaultBuild'] == null
          ? null
          : CharacterBuildState.fromJson(
              json['defaultBuild'] as Map<String, dynamic>),
      skillLevelsLastSyncAt: json['skillLevelsLastSyncAt'] == null
          ? null
          : DateTime.parse(json['skillLevelsLastSyncAt'] as String),
    );

Map<String, dynamic> _$$_CharacterStateToJson(_$_CharacterState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'activeConstellationNum': instance.activeConstellationNum,
      'skillLevels': instance.skillLevels
          .map((k, e) => MapEntry(_$SkillTypeEnumMap[k], e)),
      'own': instance.own,
      'todo': instance.todo,
      'build': instance.build,
      'defaultBuild': instance.defaultBuild,
      'skillLevelsLastSyncAt':
          instance.skillLevelsLastSyncAt?.toIso8601String(),
    };

const _$SkillTypeEnumMap = {
  SkillType.NORMAL_ATTACK: 'A',
  SkillType.ELEMENTAL_SKILL: 'E',
  SkillType.ELEMENTAL_BURST: 'Q',
  SkillType.OTHERS: '',
};

_$_CharacterBuildState _$$_CharacterBuildStateFromJson(
        Map<String, dynamic> json) =>
    _$_CharacterBuildState(
      weaponID: json['weaponID'] as int,
      weaponLevel: json['weaponLevel'] as int,
      weaponAffixLevel: json['weaponAffixLevel'] as int,
      artifacts: (json['artifacts'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$EquipTypeEnumMap, k),
            PlayerArtifact.fromJson(e as String)),
      ),
    );

Map<String, dynamic> _$$_CharacterBuildStateToJson(
        _$_CharacterBuildState instance) =>
    <String, dynamic>{
      'weaponID': instance.weaponID,
      'weaponLevel': instance.weaponLevel,
      'weaponAffixLevel': instance.weaponAffixLevel,
      'artifacts':
          instance.artifacts.map((k, e) => MapEntry(_$EquipTypeEnumMap[k], e)),
    };

const _$EquipTypeEnumMap = {
  EquipType.FLOWER: 'EQUIP_BRACER',
  EquipType.FEATHER: 'EQUIP_NECKLACE',
  EquipType.SANDS: 'EQUIP_SHOES',
  EquipType.GOBLET: 'EQUIP_RING',
  EquipType.CIRCLET: 'EQUIP_DRESS',
};
