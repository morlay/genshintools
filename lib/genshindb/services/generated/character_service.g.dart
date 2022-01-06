// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../character_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CharacterService _$$_CharacterServiceFromJson(Map<String, dynamic> json) =>
    _$_CharacterService(
      characters: (json['Characters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, GSCharacter.fromJson(e as Map<String, dynamic>)),
      ),
      characterLevelupExps: (json['CharacterLevelupExps'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      characterPromotes: json['CharacterPromotes'] == null
          ? null
          : GSPromoteSet.fromJson(
              json['CharacterPromotes'] as Map<String, dynamic>),
      characterPropGrowCurveValues: json['CharacterPropGrowCurveValues'] == null
          ? null
          : PropGrowCurveValueSet.fromJson(
              json['CharacterPropGrowCurveValues'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CharacterServiceToJson(_$_CharacterService instance) =>
    <String, dynamic>{
      'Characters': instance.characters,
      'CharacterLevelupExps': instance.characterLevelupExps,
      'CharacterPromotes': instance.characterPromotes,
      'CharacterPropGrowCurveValues': instance.characterPropGrowCurveValues,
    };
