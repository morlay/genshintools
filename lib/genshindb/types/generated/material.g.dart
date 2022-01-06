// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Material _$$_MaterialFromJson(Map<String, dynamic> json) => _$_Material(
      id: json['Id'] as int,
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      desc: I18n.fromJson(json['Desc'] as Map<String, dynamic>),
      materialType: $enumDecode(_$GSMaterialTypeEnumMap, json['MaterialType']),
      rarity: json['Rarity'] as int,
      rank: json['Rank'] as int,
      sources: (json['Sources'] as List<dynamic>?)
          ?.map((e) => I18n.fromJson(e as Map<String, dynamic>))
          .toList(),
      dropFromTags: (json['DropFromTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      dropFromRarity:
          $enumDecodeNullable(_$GSMonsterRarityEnumMap, json['DropFromRarity']),
      dungeonId: json['DungeonId'] as int?,
      dungeon: json['Dungeon'] == null
          ? null
          : GSDungeon.fromJson(json['Dungeon'] as Map<String, dynamic>),
      count: json['Count'] as int?,
    );

Map<String, dynamic> _$$_MaterialToJson(_$_Material instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Desc': instance.desc,
      'MaterialType': _$GSMaterialTypeEnumMap[instance.materialType],
      'Rarity': instance.rarity,
      'Rank': instance.rank,
      'Sources': instance.sources,
      'DropFromTags': instance.dropFromTags,
      'DropFromRarity': _$GSMonsterRarityEnumMap[instance.dropFromRarity],
      'DungeonId': instance.dungeonId,
      'Dungeon': instance.dungeon,
      'Count': instance.count,
    };

const _$GSMaterialTypeEnumMap = {
  GSMaterialType.OTHERS: '',
  GSMaterialType.FAKE_ABSORBATE: 'MATERIAL_FAKE_ABSORBATE',
  GSMaterialType.BGM: 'MATERIAL_BGM',
  GSMaterialType.FIREWORKS: 'MATERIAL_FIREWORKS',
  GSMaterialType.ADSORBATE: 'MATERIAL_ADSORBATE',
  GSMaterialType.CONSUME: 'MATERIAL_CONSUME',
  GSMaterialType.TALENT: 'MATERIAL_TALENT',
  GSMaterialType.AVATAR: 'MATERIAL_AVATAR',
  GSMaterialType.NOTICE_ADD_HP: 'MATERIAL_NOTICE_ADD_HP',
  GSMaterialType.EXCHANGE: 'MATERIAL_EXCHANGE',
  GSMaterialType.WOOD: 'MATERIAL_WOOD',
  GSMaterialType.HOME_SEED: 'MATERIAL_HOME_SEED',
  GSMaterialType.QUEST: 'MATERIAL_QUEST',
  GSMaterialType.CRICKET: 'MATERIAL_CRICKET',
  GSMaterialType.FOOD: 'MATERIAL_FOOD',
  GSMaterialType.EXP_FRUIT: 'MATERIAL_EXP_FRUIT',
  GSMaterialType.WEAPON_EXP_STONE: 'MATERIAL_WEAPON_EXP_STONE',
  GSMaterialType.AVATAR_MATERIAL: 'MATERIAL_AVATAR_MATERIAL',
  GSMaterialType.RELIQUARY_MATERIAL: 'MATERIAL_RELIQUARY_MATERIAL',
  GSMaterialType.ELEM_CRYSTAL: 'MATERIAL_ELEM_CRYSTAL',
  GSMaterialType.CHEST: 'MATERIAL_CHEST',
  GSMaterialType.CONSUME_BATCH_USE: 'MATERIAL_CONSUME_BATCH_USE',
  GSMaterialType.FISH_BAIT: 'MATERIAL_FISH_BAIT',
  GSMaterialType.CHEST_BATCH_USE: 'MATERIAL_CHEST_BATCH_USE',
  GSMaterialType.SELECTABLE_CHEST: 'MATERIAL_SELECTABLE_CHEST',
  GSMaterialType.FLYCLOAK: 'MATERIAL_FLYCLOAK',
  GSMaterialType.SEA_LAMP: 'MATERIAL_SEA_LAMP',
  GSMaterialType.CHANNELLER_SLAB_BUFF: 'MATERIAL_CHANNELLER_SLAB_BUFF',
  GSMaterialType.FISH_ROD: 'MATERIAL_FISH_ROD',
  GSMaterialType.NAMECARD: 'MATERIAL_NAMECARD',
  GSMaterialType.WIDGET: 'MATERIAL_WIDGET',
  GSMaterialType.COSTUME: 'MATERIAL_COSTUME',
  GSMaterialType.FURNITURE_SUITE_FORMULA: 'MATERIAL_FURNITURE_SUITE_FORMULA',
  GSMaterialType.FURNITURE_FORMULA: 'MATERIAL_FURNITURE_FORMULA',
};

const _$GSMonsterRarityEnumMap = {
  GSMonsterRarity.OTHERS: '',
  GSMonsterRarity.SMALL_MONSTER: 'MONSTER_RARITY_SMALL_MONSTER',
  GSMonsterRarity.SMALL_ENV_ANIMAL: 'MONSTER_RARITY_SMALL_ENV_ANIMAL',
  GSMonsterRarity.ELITE_MONSTER: 'MONSTER_RARITY_ELITE_MONSTER',
  GSMonsterRarity.BOSS_MONSTER: 'MONSTER_RARITY_BOSS_MONSTER',
  GSMonsterRarity.BIG_BOSS_MONSTER: 'MONSTER_RARITY_BIG_BOSS_MONSTER',
};

_$_MaterialCost _$$_MaterialCostFromJson(Map<String, dynamic> json) =>
    _$_MaterialCost(
      materialKey: json['MaterialKey'] as String,
      count: json['Count'] as int,
    );

Map<String, dynamic> _$$_MaterialCostToJson(_$_MaterialCost instance) =>
    <String, dynamic>{
      'MaterialKey': instance.materialKey,
      'Count': instance.count,
    };

_$_Dungeon _$$_DungeonFromJson(Map<String, dynamic> json) => _$_Dungeon(
      id: json['Id'] as int,
      type: json['Type'] as String,
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      displayName: I18n.fromJson(json['DisplayName'] as Map<String, dynamic>),
      openWeekdays: (json['OpenWeekdays'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_DungeonToJson(_$_Dungeon instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Type': instance.type,
      'Name': instance.name,
      'DisplayName': instance.displayName,
      'OpenWeekdays': instance.openWeekdays,
    };
