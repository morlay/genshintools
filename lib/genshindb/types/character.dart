import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/genshindb.dart';

part 'generated/character.freezed.dart';
part 'generated/character.g.dart';

@freezed
class GSCharacter with _$GSCharacter {
  GSCharacter._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSCharacter({
    required int id,
    required I18n name,
    required I18n desc,
    @ElementTypeStringConverter() required ElementType element,
    required int rarity,
    @WeaponTypeStringConverter() required WeaponType weaponType,
    required int initialWeaponId,
    required double critical,
    required double criticalHurt,
    required double staminaRecoverSpeed,
    required double chargeEfficiency,
    required List<GSConstellation> constellations,
    required List<InherentSkill> inherentSkills,
    required List<Skill> skills,
    required List<List<GSMaterialCost>> skillLevelupMaterialCosts,
    required int promoteId,
    @FightPropStringConverter()
        required Map<FightProp, PropGrowCurveAndInitial>
            propGrowCurveAndInitials,
    GSCharacterBuild? characterBuild,
    GSCharacterBuild? internalCharacterBuild,
  }) = _GSCharacter;

  factory GSCharacter.fromJson(Map<String, dynamic> json) =>
      _GSCharacter.fromJson(json);

  get nameID => name.text(Lang.ID);

  GSCharacterBuild characterAllBuilds() {
    return characterBuild?.copyWith(
          weapons: <String>{
            ...?characterBuild?.weapons,
            ...?internalCharacterBuild?.weapons
          }.toList(),
          artifactSetPairs: [
            ...?characterBuild?.artifactSetPairs,
            ...?internalCharacterBuild?.artifactSetPairs
          ].asMap().map((i, v) => MapEntry(v.join("|"), v)).values.toList(),
          artifactMainPropTypes: {
            EquipType.FLOWER: [FightProp.HP],
            EquipType.FEATHER: [FightProp.ATTACK],
            EquipType.SANDS: [
              ...?characterBuild?.artifactMainPropTypes?[EquipType.SANDS],
            ],
            EquipType.GOBLET: [
              ...?characterBuild?.artifactMainPropTypes?[EquipType.GOBLET],
            ],
            EquipType.CIRCLET: [
              ...?characterBuild?.artifactMainPropTypes?[EquipType.CIRCLET],
            ],
          },
        ) ??
        internalCharacterBuild?.copyWith(
          artifactMainPropTypes: {
            ...?internalCharacterBuild?.artifactMainPropTypes,
            EquipType.FLOWER: [FightProp.HP],
            EquipType.FEATHER: [FightProp.ATTACK],
          },
        ) ??
        GSCharacterBuild();
  }
}

@freezed
class GSCharacterBuild with _$GSCharacterBuild {
  GSCharacterBuild._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSCharacterBuild({
    List<String>? weapons,
    List<List<String>>? artifactSetPairs,
    @EquipTypeStringConverter()
        Map<EquipType, List<FightProp>>? artifactMainPropTypes,
    List<FightProp>? artifactAffixPropTypes,
    @SkillTypeStringConverter() List<List<SkillType>>? skillPriority,
  }) = _GSCharacterBuild;

  factory GSCharacterBuild.fromJson(Map<String, dynamic> json) =>
      _GSCharacterBuild.fromJson(json);

  FightProp defaultMainProp(EquipType et) {
    return artifactMainPropTypes?[et]?[0] ??
        {
          EquipType.FLOWER: FightProp.HP,
          EquipType.FEATHER: FightProp.ATTACK,
          EquipType.SANDS: FightProp.ATTACK_PERCENT,
          EquipType.CIRCLET: FightProp.ATTACK_PERCENT,
          EquipType.GOBLET: FightProp.CRITICAL,
        }[et]!;
  }

  Iterable<FightProp> artifactAppendProps(FightProp mainProp) {
    return artifactAffixPropTypes?.where((fp) => fp != mainProp) ?? [];
  }
}