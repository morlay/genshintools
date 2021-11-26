import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/annotations.dart';

part 'generated/monster_rarity.g.dart';

class GSMonsterRarityStringConverter extends _$GSMonsterRarityStringConverter {
  const GSMonsterRarityStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum GSMonsterRarity {
  @EnumMeta(label: "其他")
  @JsonValue("")
  OTHERS,

  @EnumMeta(label: "普通怪物")
  @JsonValue("MONSTER_RARITY_SMALL_MONSTER")
  SMALL_MONSTER,

  @EnumMeta(label: "环境动物")
  @JsonValue("MONSTER_RARITY_SMALL_ENV_ANIMAL")
  SMALL_ENV_ANIMAL,

  @EnumMeta(label: "精英怪物")
  @JsonValue("MONSTER_RARITY_ELITE_MONSTER")
  ELITE_MONSTER,

  @EnumMeta(label: "野外BOSS")
  @JsonValue("MONSTER_RARITY_BOSS_MONSTER")
  BOSS_MONSTER,

  @EnumMeta(label: "大BOSS")
  @JsonValue("MONSTER_RARITY_BIG_BOSS_MONSTER")
  BIG_BOSS_MONSTER,
}
