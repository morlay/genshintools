// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../fight_prop.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$FightPropStringConverter implements JsonConverter<FightProp, String> {
  const _$FightPropStringConverter();

  @override
  FightProp fromJson(String json) => $enumDecode(_$FightPropEnumMap, json);

  @override
  String toJson(FightProp v) => _$FightPropEnumMap[v] ?? "";
}

const _$FightPropLabelMap = {
  FightProp.LEVEL: "角色等级",
  FightProp.ENEMY_ADD_LEVEL: "提高怪物等级",
  FightProp.ADD_LEVEL: "提高角色等级",
  FightProp.ADD_ELEMENTAL_SKILL_LEVEL: "提高元素战技等级",
  FightProp.ADD_ELEMENTAL_BURST_LEVEL: "提高元素爆发等级",
  FightProp.BASE_HP: "基础生命值",
  FightProp.BASE_ATTACK: "基础攻击力",
  FightProp.BASE_DEFENSE: "基础防御力",
  FightProp.HP: "生命值",
  FightProp.HP_PERCENT: "生命值百分比",
  FightProp.ATTACK: "攻击力",
  FightProp.ATTACK_PERCENT: "攻击力百分比",
  FightProp.DEFENSE: "防御力",
  FightProp.DEFENSE_PERCENT: "防御力百分比",
  FightProp.CRITICAL: "暴击率",
  FightProp.CRITICAL_HURT: "暴击伤害",
  FightProp.CHARGE_EFFICIENCY: "元素充能效率",
  FightProp.HEAL_ADD: "治疗加成",
  FightProp.HEALED_ADD: "被治疗加成",
  FightProp.ELEMENT_MASTERY: "元素精通",
  FightProp.FIRE_ADD_HURT: "火伤加成",
  FightProp.ELEC_ADD_HURT: "雷伤加成",
  FightProp.WATER_ADD_HURT: "水伤加成",
  FightProp.WIND_ADD_HURT: "风伤加成",
  FightProp.ROCK_ADD_HURT: "岩伤加成",
  FightProp.GRASS_ADD_HURT: "草伤加成",
  FightProp.ICE_ADD_HURT: "冰伤加成",
  FightProp.PHYSICAL_ADD_HURT: "物伤加成",
  FightProp.FIRE_SUB_HURT: "火抗加成",
  FightProp.ELEC_SUB_HURT: "雷抗加成",
  FightProp.WATER_SUB_HURT: "水抗加成",
  FightProp.WIND_SUB_HURT: "风抗加成",
  FightProp.ROCK_SUB_HURT: "岩抗加成",
  FightProp.GRASS_SUB_HURT: "草抗加成",
  FightProp.ICE_SUB_HURT: "冰抗加成",
  FightProp.PHYSICAL_SUB_HURT: "物抗加成",
  FightProp.ADD_HURT: "伤害增加",
  FightProp.SUB_HURT: "伤害减少",
  FightProp.NORMAL_ATTACK_ADD_HURT: "普攻加伤",
  FightProp.NORMAL_ATTACK_ADD_CRITICAL: "普攻加暴",
  FightProp.CHARGED_ATTACK_ADD_HURT: "重击加伤",
  FightProp.CHARGED_ATTACK_ADD_CRITICAL: "重击加暴",
  FightProp.PLUNGING_ATTACK_ADD_HURT: "下落攻击加伤",
  FightProp.PLUNGING_ATTACK_ADD_CRITICAL: "下落攻击加暴",
  FightProp.ELEMENTAL_SKILL_ADD_HURT: "元素战技加伤",
  FightProp.ELEMENTAL_SKILL_ADD_CRITICAL: "元素战技加暴",
  FightProp.ELEMENTAL_BURST_ADD_HURT: "元素爆发加伤",
  FightProp.ELEMENTAL_BURST_ADD_CRITICAL: "元素爆发加暴",
  FightProp.MELT_ADD_HURT: "融化加伤",
  FightProp.VAPORIZE_ADD_HURT: "蒸发加伤",
  FightProp.SUPER_CONDUCT_ADD_HURT: "超导加伤",
  FightProp.SWIRL_ADD_HURT: "扩散加伤",
  FightProp.ELECTRO_CHARGED_ADD_HURT: "感电加伤",
  FightProp.OVERLOADED_ADD_HURT: "超载加伤",
  FightProp.SHATTERED_ADD_HURT: "碎冰加伤",
  FightProp.SHIELD_COST_MINUS_RATIO: "护盾强效",
  FightProp.ENEMY_LEVEL: "怪物等级",
  FightProp.ENEMY_RESISTANCE: "怪物抗性",
  FightProp.ENEMY_SUB_RESISTANCE: "怪物减抗",
  FightProp.ENEMY_SUB_DEFENSE: "怪物减防",
  FightProp.SPEED_PERCENT: "速度提升",
  FightProp.SKILL_CD_MINUS_RATIO: "技能冷却缩短",
  FightProp.ATTACK_ADD_RADIO: "攻击力加成比例",
  FightProp.ELEMENTAL_BURST_ADD_HURT_ON_CHARGE_EFFICIENCY: "元素爆发加伤（基于元素充能效率）",
  FightProp.ATTACK_PERCENT_ON_CHARGE_EFFICIENCY: "攻击力加成（基于元素充能效率超出部分）",
  FightProp.ATTACK_PERCENT_ON_HP: "攻击力加成（基于最大生命值）"
};

const _$FightPropFormatMap = {
  FightProp.LEVEL: "I",
  FightProp.ENEMY_ADD_LEVEL: "I",
  FightProp.ADD_LEVEL: "I",
  FightProp.ADD_ELEMENTAL_SKILL_LEVEL: "I",
  FightProp.ADD_ELEMENTAL_BURST_LEVEL: "I",
  FightProp.BASE_HP: "I",
  FightProp.BASE_ATTACK: "I",
  FightProp.BASE_DEFENSE: "I",
  FightProp.HP: "I",
  FightProp.HP_PERCENT: "P",
  FightProp.ATTACK: "I",
  FightProp.ATTACK_PERCENT: "P",
  FightProp.DEFENSE: "I",
  FightProp.DEFENSE_PERCENT: "P",
  FightProp.CRITICAL: "P",
  FightProp.CRITICAL_HURT: "P",
  FightProp.CHARGE_EFFICIENCY: "P",
  FightProp.HEAL_ADD: "P",
  FightProp.HEALED_ADD: "P",
  FightProp.ELEMENT_MASTERY: "I",
  FightProp.FIRE_ADD_HURT: "P",
  FightProp.ELEC_ADD_HURT: "P",
  FightProp.WATER_ADD_HURT: "P",
  FightProp.WIND_ADD_HURT: "P",
  FightProp.ROCK_ADD_HURT: "P",
  FightProp.GRASS_ADD_HURT: "P",
  FightProp.ICE_ADD_HURT: "P",
  FightProp.PHYSICAL_ADD_HURT: "P",
  FightProp.FIRE_SUB_HURT: "P",
  FightProp.ELEC_SUB_HURT: "P",
  FightProp.WATER_SUB_HURT: "P",
  FightProp.WIND_SUB_HURT: "P",
  FightProp.ROCK_SUB_HURT: "P",
  FightProp.GRASS_SUB_HURT: "P",
  FightProp.ICE_SUB_HURT: "P",
  FightProp.PHYSICAL_SUB_HURT: "P",
  FightProp.ADD_HURT: "P",
  FightProp.SUB_HURT: "P",
  FightProp.NORMAL_ATTACK_ADD_HURT: "P",
  FightProp.NORMAL_ATTACK_ADD_CRITICAL: "P",
  FightProp.CHARGED_ATTACK_ADD_HURT: "P",
  FightProp.CHARGED_ATTACK_ADD_CRITICAL: "P",
  FightProp.PLUNGING_ATTACK_ADD_HURT: "P",
  FightProp.PLUNGING_ATTACK_ADD_CRITICAL: "P",
  FightProp.ELEMENTAL_SKILL_ADD_HURT: "P",
  FightProp.ELEMENTAL_SKILL_ADD_CRITICAL: "P",
  FightProp.ELEMENTAL_BURST_ADD_HURT: "P",
  FightProp.ELEMENTAL_BURST_ADD_CRITICAL: "P",
  FightProp.MELT_ADD_HURT: "P",
  FightProp.VAPORIZE_ADD_HURT: "P",
  FightProp.SUPER_CONDUCT_ADD_HURT: "P",
  FightProp.SWIRL_ADD_HURT: "P",
  FightProp.ELECTRO_CHARGED_ADD_HURT: "P",
  FightProp.OVERLOADED_ADD_HURT: "P",
  FightProp.SHATTERED_ADD_HURT: "P",
  FightProp.SHIELD_COST_MINUS_RATIO: "P",
  FightProp.ENEMY_LEVEL: "I",
  FightProp.ENEMY_RESISTANCE: "P",
  FightProp.ENEMY_SUB_RESISTANCE: "P",
  FightProp.ENEMY_SUB_DEFENSE: "P",
  FightProp.SPEED_PERCENT: "P",
  FightProp.SKILL_CD_MINUS_RATIO: "P",
  FightProp.ATTACK_ADD_RADIO: "P",
  FightProp.ELEMENTAL_BURST_ADD_HURT_ON_CHARGE_EFFICIENCY: "P",
  FightProp.ATTACK_PERCENT_ON_CHARGE_EFFICIENCY: "P",
  FightProp.ATTACK_PERCENT_ON_HP: "P"
};

extension FightPropMeta on FightProp {
  String label() {
    return _$FightPropLabelMap[FightProp.values[index]] ?? "";
  }

  String format() {
    return _$FightPropFormatMap[FightProp.values[index]] ?? "";
  }

  String string() {
    return _$FightPropEnumMap[FightProp.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$FightPropEnumMap = {
  FightProp.LEVEL: 'FIGHT_PROP_LEVEL',
  FightProp.ENEMY_ADD_LEVEL: 'FIGHT_PROP_ENEMY_ADD_LEVEL',
  FightProp.ADD_LEVEL: 'FIGHT_PROP_ADD_LEVEL',
  FightProp.ADD_ELEMENTAL_SKILL_LEVEL: 'FIGHT_PROP_ADD_ELEMENTAL_SKILL_LEVEL',
  FightProp.ADD_ELEMENTAL_BURST_LEVEL: 'FIGHT_PROP_ADD_ELEMENTAL_BURST_LEVEL',
  FightProp.BASE_HP: 'FIGHT_PROP_BASE_HP',
  FightProp.BASE_ATTACK: 'FIGHT_PROP_BASE_ATTACK',
  FightProp.BASE_DEFENSE: 'FIGHT_PROP_BASE_DEFENSE',
  FightProp.HP: 'FIGHT_PROP_HP',
  FightProp.HP_PERCENT: 'FIGHT_PROP_HP_PERCENT',
  FightProp.ATTACK: 'FIGHT_PROP_ATTACK',
  FightProp.ATTACK_PERCENT: 'FIGHT_PROP_ATTACK_PERCENT',
  FightProp.DEFENSE: 'FIGHT_PROP_DEFENSE',
  FightProp.DEFENSE_PERCENT: 'FIGHT_PROP_DEFENSE_PERCENT',
  FightProp.CRITICAL: 'FIGHT_PROP_CRITICAL',
  FightProp.CRITICAL_HURT: 'FIGHT_PROP_CRITICAL_HURT',
  FightProp.CHARGE_EFFICIENCY: 'FIGHT_PROP_CHARGE_EFFICIENCY',
  FightProp.HEAL_ADD: 'FIGHT_PROP_HEAL_ADD',
  FightProp.HEALED_ADD: 'FIGHT_PROP_HEALED_ADD',
  FightProp.ELEMENT_MASTERY: 'FIGHT_PROP_ELEMENT_MASTERY',
  FightProp.FIRE_ADD_HURT: 'FIGHT_PROP_FIRE_ADD_HURT',
  FightProp.ELEC_ADD_HURT: 'FIGHT_PROP_ELEC_ADD_HURT',
  FightProp.WATER_ADD_HURT: 'FIGHT_PROP_WATER_ADD_HURT',
  FightProp.WIND_ADD_HURT: 'FIGHT_PROP_WIND_ADD_HURT',
  FightProp.ROCK_ADD_HURT: 'FIGHT_PROP_ROCK_ADD_HURT',
  FightProp.GRASS_ADD_HURT: 'FIGHT_PROP_GRASS_ADD_HURT',
  FightProp.ICE_ADD_HURT: 'FIGHT_PROP_ICE_ADD_HURT',
  FightProp.PHYSICAL_ADD_HURT: 'FIGHT_PROP_PHYSICAL_ADD_HURT',
  FightProp.FIRE_SUB_HURT: 'FIGHT_PROP_FIRE_SUB_HURT',
  FightProp.ELEC_SUB_HURT: 'FIGHT_PROP_ELEC_SUB_HURT',
  FightProp.WATER_SUB_HURT: 'FIGHT_PROP_WATER_SUB_HURT',
  FightProp.WIND_SUB_HURT: 'FIGHT_PROP_WIND_SUB_HURT',
  FightProp.ROCK_SUB_HURT: 'FIGHT_PROP_ROCK_SUB_HURT',
  FightProp.GRASS_SUB_HURT: 'FIGHT_PROP_GRASS_SUB_HURT',
  FightProp.ICE_SUB_HURT: 'FIGHT_PROP_ICE_SUB_HURT',
  FightProp.PHYSICAL_SUB_HURT: 'FIGHT_PROP_PHYSICAL_SUB_HURT',
  FightProp.ADD_HURT: 'FIGHT_PROP_ADD_HURT',
  FightProp.SUB_HURT: 'FIGHT_PROP_SUB_HURT',
  FightProp.NORMAL_ATTACK_ADD_HURT: 'FIGHT_PROP_NORMAL_ATTACK_ADD_HURT',
  FightProp.NORMAL_ATTACK_ADD_CRITICAL: 'FIGHT_PROP_NORMAL_ATTACK_ADD_CRITICAL',
  FightProp.CHARGED_ATTACK_ADD_HURT: 'FIGHT_PROP_CHARGED_ATTACK_ADD_HURT',
  FightProp.CHARGED_ATTACK_ADD_CRITICAL:
      'FIGHT_PROP_CHARGED_ATTACK_ADD_CRITICAL',
  FightProp.PLUNGING_ATTACK_ADD_HURT: 'FIGHT_PROP_PLUNGING_ATTACK_ADD_HURT',
  FightProp.PLUNGING_ATTACK_ADD_CRITICAL:
      'FIGHT_PROP_PLUNGING_ATTACK_ADD_CRITICAL',
  FightProp.ELEMENTAL_SKILL_ADD_HURT: 'FIGHT_PROP_ELEMENTAL_SKILL_ADD_HURT',
  FightProp.ELEMENTAL_SKILL_ADD_CRITICAL:
      'FIGHT_PROP_ELEMENTAL_SKILL_ADD_CRITICAL',
  FightProp.ELEMENTAL_BURST_ADD_HURT: 'FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT',
  FightProp.ELEMENTAL_BURST_ADD_CRITICAL:
      'FIGHT_PROP_ELEMENTAL_BURST_ADD_CRITICAL',
  FightProp.MELT_ADD_HURT: 'FIGHT_PROP_MELT_ADD_HURT',
  FightProp.VAPORIZE_ADD_HURT: 'FIGHT_PROP_VAPORIZE_ADD_HURT',
  FightProp.SUPER_CONDUCT_ADD_HURT: 'FIGHT_PROP_SUPER_CONDUCT_ADD_HURT',
  FightProp.SWIRL_ADD_HURT: 'FIGHT_PROP_SWIRL_ADD_HURT',
  FightProp.ELECTRO_CHARGED_ADD_HURT: 'FIGHT_PROP_ELECTRO_CHARGED_ADD_HURT',
  FightProp.OVERLOADED_ADD_HURT: 'FIGHT_PROP_OVERLOADED_ADD_HURT',
  FightProp.SHATTERED_ADD_HURT: 'FIGHT_PROP_SHATTERED_ADD_HURT',
  FightProp.SHIELD_COST_MINUS_RATIO: 'FIGHT_PROP_SHIELD_COST_MINUS_RATIO',
  FightProp.ENEMY_LEVEL: 'FIGHT_PROP_ENEMY_LEVEL',
  FightProp.ENEMY_RESISTANCE: 'FIGHT_PROP_ENEMY_RESISTANCE',
  FightProp.ENEMY_SUB_RESISTANCE: 'FIGHT_PROP_ENEMY_SUB_RESISTANCE',
  FightProp.ENEMY_SUB_DEFENSE: 'FIGHT_PROP_ENEMY_SUB_DEFENSE',
  FightProp.SPEED_PERCENT: 'FIGHT_PROP_SPEED_PERCENT',
  FightProp.SKILL_CD_MINUS_RATIO: 'FIGHT_PROP_SKILL_CD_MINUS_RATIO',
  FightProp.ATTACK_ADD_RADIO: 'FIGHT_PROP_ATTACK_ADD_RADIO',
  FightProp.ELEMENTAL_BURST_ADD_HURT_ON_CHARGE_EFFICIENCY:
      'FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT_ON_CHARGE_EFFICIENCY',
  FightProp.ATTACK_PERCENT_ON_CHARGE_EFFICIENCY:
      'FIGHT_PROP_ATTACK_PERCENT_ON_CHARGE_EFFICIENCY',
  FightProp.ATTACK_PERCENT_ON_HP: 'FIGHT_PROP_ATTACK_PERCENT_ON_HP',
};
