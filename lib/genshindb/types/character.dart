import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
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
    required String initialWeaponKey,
    required double critical,
    required double criticalHurt,
    required double staminaRecoverSpeed,
    required double chargeEfficiency,
    required List<GSConstellation> constellations,
    required List<InherentSkill> inherentSkills,
    required List<Skill> skills,
    required int promoteId,
    @FightPropStringConverter()
        required Map<FightProp, PropGrowCurveAndInitial>
            propGrowCurveAndInitials,
    Map<String, GSCharacterBuild>? characterBuilds,
  }) = _GSCharacter;

  factory GSCharacter.fromJson(Map<String, dynamic> json) =>
      _GSCharacter.fromJson(json);

  String get key => name.text(Lang.KEY);

  List<List<GSMaterialCost>> materialCosts(SkillType st) {
    return skills.firstWhere((s) => s.skillType == st).materialCosts!;
  }

  String? defaultCharacterBuildRole([String? role]) {
    if (role != null && (characterBuilds?.keys.contains(role) ?? false)) {
      return role;
    }
    return characterBuilds?.keys
        .where((r) => characterBuilds?[r]?.recommended ?? false)
        .last;
  }

  GSCharacterBuild characterBuildFor(String? role) {
    role ??= defaultCharacterBuildRole();

    return characterBuilds?[role]?.let(
          (b) => b.copyWith(
            role: role,
            artifactMainPropTypes: {
              EquipType.BRACER: [FightProp.HP],
              EquipType.NECKLACE: [FightProp.ATTACK],
              ...?b.artifactMainPropTypes,
            },
          ),
        ) ??
        GSCharacterBuild();
  }
}

@freezed
class GSCharacterBuild with _$GSCharacterBuild {
  GSCharacterBuild._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSCharacterBuild({
    bool? recommended,
    String? role,
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
          EquipType.BRACER: FightProp.HP,
          EquipType.NECKLACE: FightProp.ATTACK,
          EquipType.SHOES: FightProp.ATTACK_PERCENT,
          EquipType.DRESS: FightProp.ATTACK_PERCENT,
          EquipType.RING: FightProp.CRITICAL,
        }[et]!;
  }

  Iterable<FightProp> artifactAppendProps(FightProp mainProp) {
    return artifactAffixPropTypes?.where((fp) => fp != mainProp) ?? [];
  }

  bool shouldSkillLevelup(SkillType st) {
    return skillPriority?.expand((e) => e).contains(st) ?? false;
  }
}
