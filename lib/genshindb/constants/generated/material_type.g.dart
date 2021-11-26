// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../material_type.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$GSMaterialTypeStringConverter
    implements JsonConverter<GSMaterialType, String> {
  const _$GSMaterialTypeStringConverter();

  @override
  GSMaterialType fromJson(String json) =>
      $enumDecode(_$GSMaterialTypeEnumMap, json);

  @override
  String toJson(GSMaterialType v) => _$GSMaterialTypeEnumMap[v] ?? "";
}

const _$GSMaterialTypeLabelMap = {
  GSMaterialType.OTHERS: "其他",
  GSMaterialType.FAKE_ABSORBATE: "代币",
  GSMaterialType.BGM: "BGM",
  GSMaterialType.FIREWORKS: "FIREWORKS",
  GSMaterialType.ADSORBATE: "能量/钱币",
  GSMaterialType.CONSUME: "消耗品",
  GSMaterialType.TALENT: "命座",
  GSMaterialType.AVATAR: "角色",
  GSMaterialType.NOTICE_ADD_HP: "加血食物",
  GSMaterialType.EXCHANGE: "采集物品",
  GSMaterialType.WOOD: "木材",
  GSMaterialType.HOME_SEED: "种子",
  GSMaterialType.QUEST: "任务物品",
  GSMaterialType.CRICKET: "蛐蛐",
  GSMaterialType.FOOD: "食物",
  GSMaterialType.EXP_FRUIT: "角色经验材料",
  GSMaterialType.WEAPON_EXP_STONE: "武器经验材料",
  GSMaterialType.AVATAR_MATERIAL: "角色升级材料",
  GSMaterialType.RELIQUARY_MATERIAL: "圣遗物经验材料",
  GSMaterialType.ELEM_CRYSTAL: "神瞳",
  GSMaterialType.CHEST: "礼包",
  GSMaterialType.CONSUME_BATCH_USE: "批量消耗品",
  GSMaterialType.FISH_BAIT: "鱼饵",
  GSMaterialType.CHEST_BATCH_USE: "批量自选礼包",
  GSMaterialType.SELECTABLE_CHEST: "自选礼包",
  GSMaterialType.FLYCLOAK: "翅膀",
  GSMaterialType.SEA_LAMP: "海灯节道具",
  GSMaterialType.CHANNELLER_SLAB_BUFF: "buff",
  GSMaterialType.FISH_ROD: "鱼竿",
  GSMaterialType.NAMECARD: "名片",
  GSMaterialType.WIDGET: "小道具",
  GSMaterialType.COSTUME: "服装",
  GSMaterialType.FURNITURE_SUITE_FORMULA: "家具套装图纸",
  GSMaterialType.FURNITURE_FORMULA: "家具图纸"
};

const _$GSMaterialTypeFormatMap = {
  GSMaterialType.OTHERS: "P",
  GSMaterialType.FAKE_ABSORBATE: "P",
  GSMaterialType.BGM: "P",
  GSMaterialType.FIREWORKS: "P",
  GSMaterialType.ADSORBATE: "P",
  GSMaterialType.CONSUME: "P",
  GSMaterialType.TALENT: "P",
  GSMaterialType.AVATAR: "P",
  GSMaterialType.NOTICE_ADD_HP: "P",
  GSMaterialType.EXCHANGE: "P",
  GSMaterialType.WOOD: "P",
  GSMaterialType.HOME_SEED: "P",
  GSMaterialType.QUEST: "P",
  GSMaterialType.CRICKET: "P",
  GSMaterialType.FOOD: "P",
  GSMaterialType.EXP_FRUIT: "P",
  GSMaterialType.WEAPON_EXP_STONE: "P",
  GSMaterialType.AVATAR_MATERIAL: "P",
  GSMaterialType.RELIQUARY_MATERIAL: "P",
  GSMaterialType.ELEM_CRYSTAL: "P",
  GSMaterialType.CHEST: "P",
  GSMaterialType.CONSUME_BATCH_USE: "P",
  GSMaterialType.FISH_BAIT: "P",
  GSMaterialType.CHEST_BATCH_USE: "P",
  GSMaterialType.SELECTABLE_CHEST: "P",
  GSMaterialType.FLYCLOAK: "P",
  GSMaterialType.SEA_LAMP: "P",
  GSMaterialType.CHANNELLER_SLAB_BUFF: "P",
  GSMaterialType.FISH_ROD: "P",
  GSMaterialType.NAMECARD: "P",
  GSMaterialType.WIDGET: "P",
  GSMaterialType.COSTUME: "P",
  GSMaterialType.FURNITURE_SUITE_FORMULA: "P",
  GSMaterialType.FURNITURE_FORMULA: "P"
};

extension GSMaterialTypeMeta on GSMaterialType {
  String label() {
    return _$GSMaterialTypeLabelMap[GSMaterialType.values[index]] ?? "";
  }

  String format() {
    return _$GSMaterialTypeFormatMap[GSMaterialType.values[index]] ?? "";
  }

  String string() {
    return _$GSMaterialTypeEnumMap[GSMaterialType.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
