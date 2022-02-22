import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/annotations.dart';

part '__generated__/material_type.g.dart';

class GSMaterialTypeStringConverter extends _$GSMaterialTypeStringConverter {
  const GSMaterialTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum GSMaterialType {
  @EnumMeta(label: "其他")
  @JsonValue("")
  OTHERS,

  @EnumMeta(label: "代币")
  @JsonValue("MATERIAL_FAKE_ABSORBATE")
  FAKE_ABSORBATE,

  @EnumMeta(label: "BGM")
  @JsonValue("MATERIAL_BGM")
  BGM,

  @EnumMeta(label: "FIREWORKS")
  @JsonValue("MATERIAL_FIREWORKS")
  FIREWORKS,

  @EnumMeta(label: "能量/钱币")
  @JsonValue("MATERIAL_ADSORBATE")
  ADSORBATE,

  @EnumMeta(label: "消耗品")
  @JsonValue("MATERIAL_CONSUME")
  CONSUME,

  @EnumMeta(label: "命座")
  @JsonValue("MATERIAL_TALENT")
  TALENT,

  @EnumMeta(label: "角色")
  @JsonValue("MATERIAL_AVATAR")
  AVATAR,

  @EnumMeta(label: "加血食物")
  @JsonValue("MATERIAL_NOTICE_ADD_HP")
  NOTICE_ADD_HP,

  @EnumMeta(label: "采集物品")
  @JsonValue("MATERIAL_EXCHANGE")
  EXCHANGE,

  @EnumMeta(label: "木材")
  @JsonValue("MATERIAL_WOOD")
  WOOD,

  @EnumMeta(label: "种子")
  @JsonValue("MATERIAL_HOME_SEED")
  HOME_SEED,

  @EnumMeta(label: "任务物品")
  @JsonValue("MATERIAL_QUEST")
  QUEST,

  @EnumMeta(label: "蛐蛐")
  @JsonValue("MATERIAL_CRICKET")
  CRICKET,

  @EnumMeta(label: "食物")
  @JsonValue("MATERIAL_FOOD")
  FOOD,

  @EnumMeta(label: "角色经验材料")
  @JsonValue("MATERIAL_EXP_FRUIT")
  EXP_FRUIT,

  @EnumMeta(label: "武器经验材料")
  @JsonValue("MATERIAL_WEAPON_EXP_STONE")
  WEAPON_EXP_STONE,

  @EnumMeta(label: "角色升级材料")
  @JsonValue("MATERIAL_AVATAR_MATERIAL")
  AVATAR_MATERIAL,

  @EnumMeta(label: "圣遗物经验材料")
  @JsonValue("MATERIAL_RELIQUARY_MATERIAL")
  RELIQUARY_MATERIAL,

  @EnumMeta(label: "神瞳")
  @JsonValue("MATERIAL_ELEM_CRYSTAL")
  ELEM_CRYSTAL,

  @EnumMeta(label: "礼包")
  @JsonValue("MATERIAL_CHEST")
  CHEST,

  @EnumMeta(label: "批量消耗品")
  @JsonValue("MATERIAL_CONSUME_BATCH_USE")
  CONSUME_BATCH_USE,

  @EnumMeta(label: "鱼饵")
  @JsonValue("MATERIAL_FISH_BAIT")
  FISH_BAIT,

  @EnumMeta(label: "批量自选礼包")
  @JsonValue("MATERIAL_CHEST_BATCH_USE")
  CHEST_BATCH_USE,

  @EnumMeta(label: "自选礼包")
  @JsonValue("MATERIAL_SELECTABLE_CHEST")
  SELECTABLE_CHEST,

  @EnumMeta(label: "翅膀")
  @JsonValue("MATERIAL_FLYCLOAK")
  FLYCLOAK,

  @EnumMeta(label: "海灯节道具")
  @JsonValue("MATERIAL_SEA_LAMP")
  SEA_LAMP,

  @EnumMeta(label: "buff")
  @JsonValue("MATERIAL_CHANNELLER_SLAB_BUFF")
  CHANNELLER_SLAB_BUFF,

  @EnumMeta(label: "鱼竿")
  @JsonValue("MATERIAL_FISH_ROD")
  FISH_ROD,

  @EnumMeta(label: "名片")
  @JsonValue("MATERIAL_NAMECARD")
  NAMECARD,

  @EnumMeta(label: "小道具")
  @JsonValue("MATERIAL_WIDGET")
  WIDGET,

  @EnumMeta(label: "服装")
  @JsonValue("MATERIAL_COSTUME")
  COSTUME,

  @EnumMeta(label: "家具套装图纸")
  @JsonValue("MATERIAL_FURNITURE_SUITE_FORMULA")
  FURNITURE_SUITE_FORMULA,

  @EnumMeta(label: "家具图纸")
  @JsonValue("MATERIAL_FURNITURE_FORMULA")
  FURNITURE_FORMULA,
}
