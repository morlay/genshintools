// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../skill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Skill _$$_SkillFromJson(Map<String, dynamic> json) => _$_Skill(
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18n.fromJson(json['Desc'] as Map<String, dynamic>),
      skillType: $enumDecode(_$SkillTypeEnumMap, json['SkillType']),
      paramNames: (json['ParamNames'] as List<dynamic>?)
          ?.map((e) => I18n.fromJson(e as Map<String, dynamic>))
          .toList(),
      params: (json['Params'] as List<dynamic>?)
          ?.map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toDouble()).toList())
          .toList(),
      materialCosts: (json['MaterialCosts'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => GSMaterialCost.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$$_SkillToJson(_$_Skill instance) => <String, dynamic>{
      'Name': instance.name,
      'Desc': instance.desc,
      'SkillType': _$SkillTypeEnumMap[instance.skillType],
      'ParamNames': instance.paramNames,
      'Params': instance.params,
      'MaterialCosts': instance.materialCosts,
    };

const _$SkillTypeEnumMap = {
  SkillType.NORMAL_ATTACK: 'A',
  SkillType.ELEMENTAL_SKILL: 'E',
  SkillType.ELEMENTAL_BURST: 'Q',
  SkillType.OTHERS: '',
};

_$_InherentSkilll _$$_InherentSkilllFromJson(Map<String, dynamic> json) =>
    _$_InherentSkilll(
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18n.fromJson(json['Desc'] as Map<String, dynamic>),
      paramNames: (json['ParamNames'] as List<dynamic>?)
          ?.map((e) => I18n.fromJson(e as Map<String, dynamic>))
          .toList(),
      params: (json['Params'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      breakLevel: json['BreakLevel'] as int?,
    );

Map<String, dynamic> _$$_InherentSkilllToJson(_$_InherentSkilll instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Desc': instance.desc,
      'ParamNames': instance.paramNames,
      'Params': instance.params,
      'BreakLevel': instance.breakLevel,
    };
