// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../skill_type.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$SkillTypeStringConverter implements JsonConverter<SkillType, String> {
  const _$SkillTypeStringConverter();

  @override
  SkillType fromJson(String json) => $enumDecode(_$SkillTypeEnumMap, json);

  @override
  String toJson(SkillType v) => _$SkillTypeEnumMap[v] ?? "";
}

const _$SkillTypeLabelMap = {
  SkillType.NORMAL_ATTACK: "普通攻击",
  SkillType.ELEMENTAL_SKILL: "元素技能",
  SkillType.ELEMENTAL_BURST: "元素爆发",
  SkillType.OTHERS: "其他"
};

const _$SkillTypeFormatMap = {
  SkillType.NORMAL_ATTACK: "P",
  SkillType.ELEMENTAL_SKILL: "P",
  SkillType.ELEMENTAL_BURST: "P",
  SkillType.OTHERS: "P"
};

extension SkillTypeMeta on SkillType {
  String label() {
    return _$SkillTypeLabelMap[SkillType.values[index]] ?? "";
  }

  String format() {
    return _$SkillTypeFormatMap[SkillType.values[index]] ?? "";
  }

  String string() {
    return _$SkillTypeEnumMap[SkillType.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$SkillTypeEnumMap = {
  SkillType.NORMAL_ATTACK: 'A',
  SkillType.ELEMENTAL_SKILL: 'E',
  SkillType.ELEMENTAL_BURST: 'Q',
  SkillType.OTHERS: '',
};
