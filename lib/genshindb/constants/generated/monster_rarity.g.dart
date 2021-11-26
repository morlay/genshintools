// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../monster_rarity.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$GSMonsterRarityStringConverter
    implements JsonConverter<GSMonsterRarity, String> {
  const _$GSMonsterRarityStringConverter();

  @override
  GSMonsterRarity fromJson(String json) =>
      $enumDecode(_$GSMonsterRarityEnumMap, json);

  @override
  String toJson(GSMonsterRarity v) => _$GSMonsterRarityEnumMap[v] ?? "";
}

const _$GSMonsterRarityLabelMap = {
  GSMonsterRarity.OTHERS: "其他",
  GSMonsterRarity.SMALL_MONSTER: "普通怪物",
  GSMonsterRarity.SMALL_ENV_ANIMAL: "环境动物",
  GSMonsterRarity.ELITE_MONSTER: "精英怪物",
  GSMonsterRarity.BOSS_MONSTER: "野外BOSS",
  GSMonsterRarity.BIG_BOSS_MONSTER: "大BOSS"
};

const _$GSMonsterRarityFormatMap = {
  GSMonsterRarity.OTHERS: "P",
  GSMonsterRarity.SMALL_MONSTER: "P",
  GSMonsterRarity.SMALL_ENV_ANIMAL: "P",
  GSMonsterRarity.ELITE_MONSTER: "P",
  GSMonsterRarity.BOSS_MONSTER: "P",
  GSMonsterRarity.BIG_BOSS_MONSTER: "P"
};

extension GSMonsterRarityMeta on GSMonsterRarity {
  String label() {
    return _$GSMonsterRarityLabelMap[GSMonsterRarity.values[index]] ?? "";
  }

  String format() {
    return _$GSMonsterRarityFormatMap[GSMonsterRarity.values[index]] ?? "";
  }

  String string() {
    return _$GSMonsterRarityEnumMap[GSMonsterRarity.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$GSMonsterRarityEnumMap = {
  GSMonsterRarity.OTHERS: '',
  GSMonsterRarity.SMALL_MONSTER: 'MONSTER_RARITY_SMALL_MONSTER',
  GSMonsterRarity.SMALL_ENV_ANIMAL: 'MONSTER_RARITY_SMALL_ENV_ANIMAL',
  GSMonsterRarity.ELITE_MONSTER: 'MONSTER_RARITY_ELITE_MONSTER',
  GSMonsterRarity.BOSS_MONSTER: 'MONSTER_RARITY_BOSS_MONSTER',
  GSMonsterRarity.BIG_BOSS_MONSTER: 'MONSTER_RARITY_BIG_BOSS_MONSTER',
};
