// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../enemy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Enemy _$$_EnemyFromJson(Map<String, dynamic> json) => _$_Enemy(
      id: json['Id'] as int,
      name: I18n.fromJson(json['Name'] as Map<String, dynamic>),
      dropTag: json['DropTag'] as String,
      type: json['Type'] as String,
      monsterRarity:
          $enumDecode(_$GSMonsterRarityEnumMap, json['MonsterRarity']),
      title: json['Title'] == null
          ? null
          : I18n.fromJson(json['Title'] as Map<String, dynamic>),
      specialName: json['SpecialName'] == null
          ? null
          : I18n.fromJson(json['SpecialName'] as Map<String, dynamic>),
      addProps: json['AddProps'] == null
          ? null
          : FightProps.fromJson(json['AddProps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EnemyToJson(_$_Enemy instance) => <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'DropTag': instance.dropTag,
      'Type': instance.type,
      'MonsterRarity': _$GSMonsterRarityEnumMap[instance.monsterRarity],
      'Title': instance.title,
      'SpecialName': instance.specialName,
      'AddProps': instance.addProps,
    };

const _$GSMonsterRarityEnumMap = {
  GSMonsterRarity.OTHERS: '',
  GSMonsterRarity.SMALL_MONSTER: 'MONSTER_RARITY_SMALL_MONSTER',
  GSMonsterRarity.SMALL_ENV_ANIMAL: 'MONSTER_RARITY_SMALL_ENV_ANIMAL',
  GSMonsterRarity.ELITE_MONSTER: 'MONSTER_RARITY_ELITE_MONSTER',
  GSMonsterRarity.BOSS_MONSTER: 'MONSTER_RARITY_BOSS_MONSTER',
  GSMonsterRarity.BIG_BOSS_MONSTER: 'MONSTER_RARITY_BIG_BOSS_MONSTER',
};
