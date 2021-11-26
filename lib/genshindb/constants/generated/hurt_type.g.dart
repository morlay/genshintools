// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hurt_type.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$HurtTypeStringConverter implements JsonConverter<HurtType, String> {
  const _$HurtTypeStringConverter();

  @override
  HurtType fromJson(String json) => $enumDecode(_$HurtTypeEnumMap, json);

  @override
  String toJson(HurtType v) => _$HurtTypeEnumMap[v] ?? "";
}

const _$HurtTypeLabelMap = {
  HurtType.NormalAttack: "普攻",
  HurtType.ChangedAttack: "重击",
  HurtType.PlungingAttack: "下落攻击",
  HurtType.ElementalSkill: "元素技能伤害",
  HurtType.ElementalBurst: "元素爆发伤害"
};

const _$HurtTypeFormatMap = {
  HurtType.NormalAttack: "P",
  HurtType.ChangedAttack: "P",
  HurtType.PlungingAttack: "P",
  HurtType.ElementalSkill: "P",
  HurtType.ElementalBurst: "P"
};

extension HurtTypeMeta on HurtType {
  String label() {
    return _$HurtTypeLabelMap[HurtType.values[index]] ?? "";
  }

  String format() {
    return _$HurtTypeFormatMap[HurtType.values[index]] ?? "";
  }

  String string() {
    return _$HurtTypeEnumMap[HurtType.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$HurtTypeEnumMap = {
  HurtType.NormalAttack: 'NormalAttack',
  HurtType.ChangedAttack: 'ChangedAttack',
  HurtType.PlungingAttack: 'PlungingAttack',
  HurtType.ElementalSkill: 'ElementalSkill',
  HurtType.ElementalBurst: 'ElementalBurst',
};
