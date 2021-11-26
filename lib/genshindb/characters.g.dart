// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      id: json['Id'] as int,
      name: I18N.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18N.fromJson(json['Desc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Desc': instance.desc,
    };
