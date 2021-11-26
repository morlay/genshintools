// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../artifact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Artifact _$$_ArtifactFromJson(Map<String, dynamic> json) => _$_Artifact(
      id: json['Id'] as int,
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18n.fromJson(json['Desc'] as Map<String, dynamic>),
      rarity: json['Rarity'] as int,
      equipType: $enumDecode(_$EquipTypeEnumMap, json['EquipType']),
      setId: json['SetId'] as int,
      appendPropDepotId: json['AppendPropDepotId'] as int,
      mainPropDepotId: json['MainPropDepotId'] as int,
      maxLevel: json['MaxLevel'] as int?,
      appendPropNum: json['AppendPropNum'] as int?,
    );

Map<String, dynamic> _$$_ArtifactToJson(_$_Artifact instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Desc': instance.desc,
      'Rarity': instance.rarity,
      'EquipType': _$EquipTypeEnumMap[instance.equipType],
      'SetId': instance.setId,
      'AppendPropDepotId': instance.appendPropDepotId,
      'MainPropDepotId': instance.mainPropDepotId,
      'MaxLevel': instance.maxLevel,
      'AppendPropNum': instance.appendPropNum,
    };

const _$EquipTypeEnumMap = {
  EquipType.FLOWER: 'EQUIP_BRACER',
  EquipType.FEATHER: 'EQUIP_NECKLACE',
  EquipType.SANDS: 'EQUIP_SHOES',
  EquipType.GOBLET: 'EQUIP_RING',
  EquipType.CIRCLET: 'EQUIP_DRESS',
};

_$_ArtifactSet _$$_ArtifactSetFromJson(Map<String, dynamic> json) =>
    _$_ArtifactSet(
      id: json['Id'] as int,
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      equipAffixes: (json['EquipAffixes'] as List<dynamic>)
          .map((e) => EquipAffix.fromJson(e as Map<String, dynamic>))
          .toList(),
      activeNum: json['ActiveNum'] as int?,
      artifacts: (json['Artifacts'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry($enumDecode(_$EquipTypeEnumMap, k),
            GSArtifact.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_ArtifactSetToJson(_$_ArtifactSet instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'EquipAffixes': instance.equipAffixes,
      'ActiveNum': instance.activeNum,
      'Artifacts':
          instance.artifacts?.map((k, e) => MapEntry(_$EquipTypeEnumMap[k], e)),
    };

_$_GSArtifactAppendDepot _$$_GSArtifactAppendDepotFromJson(
        Map<String, dynamic> json) =>
    _$_GSArtifactAppendDepot(
      (json['values'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$FightPropEnumMap, k),
            (e as List<dynamic>).map((e) => (e as num).toDouble()).toList()),
      ),
    );

Map<String, dynamic> _$$_GSArtifactAppendDepotToJson(
        _$_GSArtifactAppendDepot instance) =>
    <String, dynamic>{
      'values':
          instance.values.map((k, e) => MapEntry(_$FightPropEnumMap[k], e)),
    };

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
