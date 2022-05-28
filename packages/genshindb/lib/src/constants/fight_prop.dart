import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/annotations.dart';

part '__generated__/fight_prop.g.dart';

class FightPropStringConverter extends _$FightPropStringConverter {
  const FightPropStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum FightProp {
  @EnumMeta(label: '角色等级', format: 'I')
  @JsonValue('FIGHT_PROP_LEVEL')
  LEVEL,

  @EnumMeta(label: '提高怪物等级', format: 'I')
  @JsonValue('FIGHT_PROP_ENEMY_ADD_LEVEL')
  ENEMY_ADD_LEVEL,

  @EnumMeta(label: '提高角色等级', format: 'I')
  @JsonValue('FIGHT_PROP_ADD_LEVEL')
  ADD_LEVEL,

  @EnumMeta(label: '提高元素战技等级', format: 'I')
  @JsonValue('FIGHT_PROP_ADD_ELEMENTAL_SKILL_LEVEL')
  ADD_ELEMENTAL_SKILL_LEVEL,

  @EnumMeta(label: '提高元素爆发等级', format: 'I')
  @JsonValue('FIGHT_PROP_ADD_ELEMENTAL_BURST_LEVEL')
  ADD_ELEMENTAL_BURST_LEVEL,

  @EnumMeta(label: '基础生命值', format: 'I')
  @JsonValue('FIGHT_PROP_BASE_HP')
  BASE_HP,

  @EnumMeta(label: '基础攻击力', format: 'I')
  @JsonValue('FIGHT_PROP_BASE_ATTACK')
  BASE_ATTACK,

  @EnumMeta(label: '基础防御力', format: 'I')
  @JsonValue('FIGHT_PROP_BASE_DEFENSE')
  BASE_DEFENSE,

  @EnumMeta(label: '生命值', format: 'I')
  @JsonValue('FIGHT_PROP_HP')
  HP,

  @EnumMeta(label: '生命值百分比', format: 'P')
  @JsonValue('FIGHT_PROP_HP_PERCENT')
  HP_PERCENT,

  @EnumMeta(label: '攻击力', format: 'I')
  @JsonValue('FIGHT_PROP_ATTACK')
  ATTACK,

  @EnumMeta(label: '攻击力百分比', format: 'P')
  @JsonValue('FIGHT_PROP_ATTACK_PERCENT')
  ATTACK_PERCENT,

  @EnumMeta(label: '防御力', format: 'I')
  @JsonValue('FIGHT_PROP_DEFENSE')
  DEFENSE,

  @EnumMeta(label: '防御力百分比', format: 'P')
  @JsonValue('FIGHT_PROP_DEFENSE_PERCENT')
  DEFENSE_PERCENT,

  @EnumMeta(label: '暴击率', format: 'P')
  @JsonValue('FIGHT_PROP_CRITICAL')
  CRITICAL,

  @EnumMeta(label: '暴击伤害', format: 'P')
  @JsonValue('FIGHT_PROP_CRITICAL_HURT')
  CRITICAL_HURT,

  @EnumMeta(label: '元素充能效率', format: 'P')
  @JsonValue('FIGHT_PROP_CHARGE_EFFICIENCY')
  CHARGE_EFFICIENCY,

  @EnumMeta(label: '治疗加成', format: 'P')
  @JsonValue('FIGHT_PROP_HEAL_ADD')
  HEAL_ADD,

  @EnumMeta(label: '被治疗加成', format: 'P')
  @JsonValue('FIGHT_PROP_HEALED_ADD')
  HEALED_ADD,

  @EnumMeta(label: '元素精通', format: 'I')
  @JsonValue('FIGHT_PROP_ELEMENT_MASTERY')
  ELEMENT_MASTERY,

  @EnumMeta(label: '火伤加成')
  @JsonValue('FIGHT_PROP_FIRE_ADD_HURT')
  FIRE_ADD_HURT,

  @EnumMeta(label: '雷伤加成')
  @JsonValue('FIGHT_PROP_ELEC_ADD_HURT')
  ELEC_ADD_HURT,

  @EnumMeta(label: '水伤加成')
  @JsonValue('FIGHT_PROP_WATER_ADD_HURT')
  WATER_ADD_HURT,

  @EnumMeta(label: '风伤加成')
  @JsonValue('FIGHT_PROP_WIND_ADD_HURT')
  WIND_ADD_HURT,

  @EnumMeta(label: '岩伤加成')
  @JsonValue('FIGHT_PROP_ROCK_ADD_HURT')
  ROCK_ADD_HURT,

  @EnumMeta(label: '草伤加成')
  @JsonValue('FIGHT_PROP_GRASS_ADD_HURT')
  GRASS_ADD_HURT,

  @EnumMeta(label: '冰伤加成')
  @JsonValue('FIGHT_PROP_ICE_ADD_HURT')
  ICE_ADD_HURT,

  @EnumMeta(label: '物伤加成')
  @JsonValue('FIGHT_PROP_PHYSICAL_ADD_HURT')
  PHYSICAL_ADD_HURT,

  @EnumMeta(label: '火抗')
  @JsonValue('FIGHT_PROP_FIRE_SUB_HURT')
  FIRE_SUB_HURT,

  @EnumMeta(label: '雷抗')
  @JsonValue('FIGHT_PROP_ELEC_SUB_HURT')
  ELEC_SUB_HURT,

  @EnumMeta(label: '水抗')
  @JsonValue('FIGHT_PROP_WATER_SUB_HURT')
  WATER_SUB_HURT,

  @EnumMeta(label: '风抗')
  @JsonValue('FIGHT_PROP_WIND_SUB_HURT')
  WIND_SUB_HURT,

  @EnumMeta(label: '岩抗')
  @JsonValue('FIGHT_PROP_ROCK_SUB_HURT')
  ROCK_SUB_HURT,

  @EnumMeta(label: '草抗')
  @JsonValue('FIGHT_PROP_GRASS_SUB_HURT')
  GRASS_SUB_HURT,

  @EnumMeta(label: '冰抗')
  @JsonValue('FIGHT_PROP_ICE_SUB_HURT')
  ICE_SUB_HURT,

  @EnumMeta(label: '物抗')
  @JsonValue('FIGHT_PROP_PHYSICAL_SUB_HURT')
  PHYSICAL_SUB_HURT,

  @Deprecated('')
  @EnumMeta(label: '伤害增加')
  @JsonValue('FIGHT_PROP_ADD_HURT')
  ADD_HURT,

  @Deprecated('')
  @EnumMeta(label: '伤害减少')
  @JsonValue('FIGHT_PROP_SUB_HURT')
  SUB_HURT,

  @EnumMeta(label: '普攻加伤')
  @JsonValue('FIGHT_PROP_NORMAL_ATTACK_ADD_HURT')
  NORMAL_ATTACK_ADD_HURT,

  @EnumMeta(label: '普攻附伤', format: 'I')
  @JsonValue('FIGHT_PROP_NORMAL_ATTACK_EXTRA_HURT')
  NORMAL_ATTACK_EXTRA_HURT,

  @EnumMeta(label: '普攻倍率')
  @JsonValue('FIGHT_PROP_NORMAL_ATTACK_RADIO')
  NORMAL_ATTACK_RADIO,

  @EnumMeta(label: '普攻加暴')
  @JsonValue('FIGHT_PROP_NORMAL_ATTACK_ADD_CRITICAL')
  NORMAL_ATTACK_ADD_CRITICAL,

  @EnumMeta(label: '重击加伤')
  @JsonValue('FIGHT_PROP_CHARGED_ATTACK_ADD_HURT')
  CHARGED_ATTACK_ADD_HURT,

  @EnumMeta(label: '重击倍率')
  @JsonValue('FIGHT_PROP_CHARGED_ATTACK_RADIO')
  CHARGED_ATTACK_RADIO,

  @EnumMeta(label: '重击附伤', format: 'I')
  @JsonValue('FIGHT_PROP_CHARGED_ATTACK_EXTRA_HURT')
  CHARGED_ATTACK_EXTRA_HURT,

  @EnumMeta(label: '重击加暴')
  @JsonValue('FIGHT_PROP_CHARGED_ATTACK_ADD_CRITICAL')
  CHARGED_ATTACK_ADD_CRITICAL,

  @EnumMeta(label: '下落攻击加伤')
  @JsonValue('FIGHT_PROP_PLUNGING_ATTACK_ADD_HURT')
  PLUNGING_ATTACK_ADD_HURT,

  @EnumMeta(label: '下落攻击倍率')
  @JsonValue('FIGHT_PROP_PLUNGING_ATTACK_RADIO')
  PLUNGING_ATTACK_RADIO,

  @EnumMeta(label: '下落攻击附伤', format: 'I')
  @JsonValue('FIGHT_PROP_PLUNGING_ATTACK_EXTRA_HURT')
  PLUNGING_ATTACK_EXTRA_HURT,

  @EnumMeta(label: '下落攻击加暴')
  @JsonValue('FIGHT_PROP_PLUNGING_ATTACK_ADD_CRITICAL')
  PLUNGING_ATTACK_ADD_CRITICAL,

  @EnumMeta(label: '元素战技加伤')
  @JsonValue('FIGHT_PROP_ELEMENTAL_SKILL_ADD_HURT')
  ELEMENTAL_SKILL_ADD_HURT,

  @EnumMeta(label: '元素战技倍率')
  @JsonValue('FIGHT_PROP_ELEMENTAL_SKILL_RADIO')
  ELEMENTAL_SKILL_RADIO,

  @EnumMeta(label: '元素战技附伤', format: 'I')
  @JsonValue('FIGHT_PROP_ELEMENTAL_SKILL_EXTRA_HURT')
  ELEMENTAL_SKILL_EXTRA_HURT,

  @EnumMeta(label: '元素战技加暴')
  @JsonValue('FIGHT_PROP_ELEMENTAL_SKILL_ADD_CRITICAL')
  ELEMENTAL_SKILL_ADD_CRITICAL,

  @EnumMeta(label: '元素爆发加伤')
  @JsonValue('FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT')
  ELEMENTAL_BURST_ADD_HURT,

  @EnumMeta(label: '元素爆发倍率')
  @JsonValue('FIGHT_PROP_ELEMENTAL_BURST_RADIO')
  ELEMENTAL_BURST_RADIO,

  @EnumMeta(label: '元素爆发附伤', format: 'I')
  @JsonValue('FIGHT_PROP_ELEMENTAL_BURST_EXTRA_HURT')
  ELEMENTAL_BURST_EXTRA_HURT,

  @EnumMeta(label: '元素爆发加暴')
  @JsonValue('FIGHT_PROP_ELEMENTAL_BURST_ADD_CRITICAL')
  ELEMENTAL_BURST_ADD_CRITICAL,

  @EnumMeta(label: '融化加伤')
  @JsonValue('FIGHT_PROP_MELT_ADD_HURT')
  MELT_ADD_HURT,

  @EnumMeta(label: '蒸发加伤')
  @JsonValue('FIGHT_PROP_VAPORIZE_ADD_HURT')
  VAPORIZE_ADD_HURT,

  @EnumMeta(label: '超导加伤')
  @JsonValue('FIGHT_PROP_SUPER_CONDUCT_ADD_HURT')
  SUPER_CONDUCT_ADD_HURT,

  @EnumMeta(label: '扩散加伤')
  @JsonValue('FIGHT_PROP_SWIRL_ADD_HURT')
  SWIRL_ADD_HURT,

  @EnumMeta(label: '感电加伤')
  @JsonValue('FIGHT_PROP_ELECTRO_CHARGED_ADD_HURT')
  ELECTRO_CHARGED_ADD_HURT,

  @EnumMeta(label: '超载加伤')
  @JsonValue('FIGHT_PROP_OVERLOADED_ADD_HURT')
  OVERLOADED_ADD_HURT,

  @EnumMeta(label: '碎冰加伤')
  @JsonValue('FIGHT_PROP_SHATTERED_ADD_HURT')
  SHATTERED_ADD_HURT,

  @EnumMeta(label: '护盾强效')
  @JsonValue('FIGHT_PROP_SHIELD_COST_MINUS_RATIO')
  SHIELD_COST_MINUS_RATIO,

  @EnumMeta(label: '怪物等级', format: 'I')
  @JsonValue('FIGHT_PROP_ENEMY_LEVEL')
  ENEMY_LEVEL,

  @EnumMeta(label: '怪物减防')
  @JsonValue('FIGHT_PROP_ENEMY_SUB_DEFENSE')
  ENEMY_SUB_DEFENSE,

  @EnumMeta(label: '怪物火抗')
  @JsonValue('FIGHT_PROP_ENEMY_FIRE_SUB_HURT')
  ENEMY_FIRE_SUB_HURT,

  @EnumMeta(label: '怪物雷抗')
  @JsonValue('FIGHT_PROP_ENEMY_ELEC_SUB_HURT')
  ENEMY_ELEC_SUB_HURT,

  @EnumMeta(label: '怪物水抗')
  @JsonValue('FIGHT_PROP_ENEMY_WATER_SUB_HURT')
  ENEMY_WATER_SUB_HURT,

  @EnumMeta(label: '怪物风抗')
  @JsonValue('FIGHT_PROP_ENEMY_WIND_SUB_HURT')
  ENEMY_WIND_SUB_HURT,

  @EnumMeta(label: '怪物岩抗')
  @JsonValue('FIGHT_PROP_ENEMY_ROCK_SUB_HURT')
  ENEMY_ROCK_SUB_HURT,

  @EnumMeta(label: '怪物草抗')
  @JsonValue('FIGHT_PROP_ENEMY_GRASS_SUB_HURT')
  ENEMY_GRASS_SUB_HURT,

  @EnumMeta(label: '怪物冰抗')
  @JsonValue('FIGHT_PROP_ENEMY_ICE_SUB_HURT')
  ENEMY_ICE_SUB_HURT,

  @EnumMeta(label: '怪物物抗')
  @JsonValue('FIGHT_PROP_ENEMY_PHYSICAL_SUB_HURT')
  ENEMY_PHYSICAL_SUB_HURT,

  @EnumMeta(label: '速度提升')
  @JsonValue('FIGHT_PROP_SPEED_PERCENT')
  SPEED_PERCENT,

  @EnumMeta(label: '技能冷却缩短')
  @JsonValue('FIGHT_PROP_SKILL_CD_MINUS_RATIO')
  SKILL_CD_MINUS_RATIO,

  @EnumMeta(label: '攻击力加成比例')
  @JsonValue('FIGHT_PROP_ATTACK_ADD_RADIO')
  ATTACK_ADD_RADIO,

  /// 衍生数值
  /// <TO_FIGHT_PROP>__ON__<FROM_FIGHT_PROP>[__OVER$<N>][__MAX$<N>]
  /// _75 == .75
  @EnumMeta(label: '元素爆发加伤（基于元素充能效率）')
  ELEMENTAL_BURST_ADD_HURT__ON__CHARGE_EFFICIENCY__MAX$_75,

  @EnumMeta(label: '攻击力加成（基于最大生命值）')
  ATTACK__ON__HP,

  @EnumMeta(label: '普攻附伤(基于最大生命值)')
  NORMAL_ATTACK_EXTRA_HURT__ON__HP,

  @EnumMeta(label: '重击附伤(基于最大生命值)')
  CHARGED_ATTACK_EXTRA_HURT__ON__HP,

  @EnumMeta(label: '下落攻击附伤(基于最大生命值)')
  PLUNGING_ATTACK_EXTRA_HURT__ON__HP,

  @EnumMeta(label: '元素战技附伤(基于最大生命值)')
  ELEMENTAL_SKILL_EXTRA_HURT__ON__HP,

  @EnumMeta(label: '元素爆发附伤(基于最大生命值)')
  ELEMENTAL_BURST_EXTRA_HURT__ON__HP
}
