import 'package:genshindb/genshindb.dart';

List<FightProps> buffs = [
  FightProps({
    FightProp.ATTACK_PERCENT: 0.25,
  }, name: "双火"),
  FightProps({
    FightProp.CRITICAL: 0.15,
  }, name: "双冰"),
  FightProps({
    FightProp.SHIELD_COST_MINUS_RATIO: 0.15,
    FightProp.NORMAL_ATTACK_ADD_HURT: 0.15,
    FightProp.CHARGED_ATTACK_ADD_HURT: 0.15,
    FightProp.PLUNGING_ATTACK_ADD_HURT: 0.15,
    FightProp.ELEMENTAL_SKILL_ADD_HURT: 0.15,
    FightProp.ELEMENTAL_BURST_ADD_HURT: 0.15,
    FightProp.ENEMY_ROCK_SUB_HURT: -0.2,
  }, name: "双岩且护盾"),
  FightProps({
    FightProp.ENEMY_FIRE_SUB_HURT: -0.4,
    FightProp.ENEMY_WATER_SUB_HURT: -0.4,
    FightProp.ENEMY_ICE_SUB_HURT: -0.4,
    FightProp.ENEMY_ELEC_SUB_HURT: -0.4,
  }, name: "翠绿4减抗"),
  FightProps({
    FightProp.ENEMY_WIND_SUB_HURT: -0.2,
    FightProp.ENEMY_FIRE_SUB_HURT: -0.2,
    FightProp.ENEMY_WATER_SUB_HURT: -0.2,
    FightProp.ENEMY_ICE_SUB_HURT: -0.2,
    FightProp.ENEMY_ELEC_SUB_HURT: -0.2,
    FightProp.ENEMY_ROCK_SUB_HURT: -0.2,
    FightProp.ENEMY_GRASS_SUB_HURT: -0.2,
    FightProp.ENEMY_PHYSICAL_SUB_HURT: -0.2,
  }, name: "钟离护盾"),
  FightProps({
    FightProp.ENEMY_PHYSICAL_SUB_HURT: -0.4,
  }, name: "超导"),
];
