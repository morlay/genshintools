// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../elemental_reaction.dart';

// **************************************************************************
// EnumExtraGenerator
// **************************************************************************

class _$ElementalReactionStringConverter
    implements JsonConverter<ElementalReaction, String> {
  const _$ElementalReactionStringConverter();

  @override
  ElementalReaction fromJson(String json) =>
      $enumDecode(_$ElementalReactionEnumMap, json);

  @override
  String toJson(ElementalReaction v) => _$ElementalReactionEnumMap[v] ?? "";
}

const _$ElementalReactionLabelMap = {
  ElementalReaction.Melt: "融化",
  ElementalReaction.Vaporize: "蒸发",
  ElementalReaction.Swirl: "扩散",
  ElementalReaction.SuperConduct: "超导",
  ElementalReaction.ElectroCharged: "感电",
  ElementalReaction.Overloaded: "超载",
  ElementalReaction.Shattered: "碎冰",
  ElementalReaction.Crystallize: "结晶"
};

const _$ElementalReactionFormatMap = {
  ElementalReaction.Melt: "P",
  ElementalReaction.Vaporize: "P",
  ElementalReaction.Swirl: "P",
  ElementalReaction.SuperConduct: "P",
  ElementalReaction.ElectroCharged: "P",
  ElementalReaction.Overloaded: "P",
  ElementalReaction.Shattered: "P",
  ElementalReaction.Crystallize: "P"
};

extension ElementalReactionMeta on ElementalReaction {
  String label() {
    return _$ElementalReactionLabelMap[ElementalReaction.values[index]] ?? "";
  }

  String format() {
    return _$ElementalReactionFormatMap[ElementalReaction.values[index]] ?? "";
  }

  String string() {
    return _$ElementalReactionEnumMap[ElementalReaction.values[index]] ?? "";
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

const _$ElementalReactionEnumMap = {
  ElementalReaction.Melt: 'Melt',
  ElementalReaction.Vaporize: 'Vaporize',
  ElementalReaction.Swirl: 'Swirl',
  ElementalReaction.SuperConduct: 'SuperConduct',
  ElementalReaction.ElectroCharged: 'ElectroCharged',
  ElementalReaction.Overloaded: 'Overloaded',
  ElementalReaction.Shattered: 'Shattered',
  ElementalReaction.Crystallize: 'Crystallize',
};
