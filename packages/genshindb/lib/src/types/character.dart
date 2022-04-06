import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';
import 'package:genshindb/extension.dart';

import 'constellation.dart';
import 'i18n.dart';
import 'material.dart';
import 'prop_grow_curve.dart';
import 'skill.dart';

part '__generated__/character.freezed.dart';
part '__generated__/character.g.dart';

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
    return characterBuilds?.keys.last;
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

  bool emBuild() {
    return (role ?? "").toUpperCase().trim() == "EM BUILD";
  }

  Map<FightProp, double> appendPropRankRadios({
    bool chargeEfficiencyAsDPS = false,
    String? location,
  }) {
    var em = emBuild();

    var affixPropTypes = (artifactAffixPropTypes ?? []).where((fp) => ![
          FightProp.ATTACK_PERCENT,
          FightProp.HP_PERCENT,
          FightProp.DEFENSE_PERCENT,
          ...?em.ifTrueOrNull(() => [
                FightProp.CRITICAL_HURT,
                FightProp.CRITICAL,
              ])
        ].contains(fp));

    var nonCritValueProps = affixPropTypes.where((fp) => ![
          FightProp.CRITICAL_HURT,
          FightProp.CRITICAL,
          ...(chargeEfficiencyAsDPS) ? [] : [FightProp.CHARGE_EFFICIENCY]
        ].contains(fp));

    Map<FightProp, double> rankRadios = {};

    if (affixPropTypes.contains(FightProp.CRITICAL_HURT)) {
      rankRadios[FightProp.CRITICAL] = 9;
      rankRadios[FightProp.CRITICAL_HURT] = 9;

      var firstMainProp = nonCritValueProps.firstWhereOrNull((fp) => [
            FightProp.ATTACK,
            FightProp.HP,
            FightProp.DEFENSE,
          ].contains(fp));

      if (firstMainProp != null) {
        rankRadios[firstMainProp] = 6;
      }

      var others = nonCritValueProps
          .where((fp) => fp != firstMainProp)
          .map((fp) => MapEntry(
                fp,
                location == "HuTao" && fp == FightProp.ATTACK ? 0.4 : 1.0,
              ));

      var total = others.fold<double>(0, (v, fp) => v + fp.value);

      var all = (4 - (others.length - 1)) * others.length.toDouble();

      for (var fp in others) {
        rankRadios[fp.key] = (fp.value / total * all).roundToDouble();
      }
    } else {
      for (var fp in nonCritValueProps) {
        if (fp == FightProp.ELEMENT_MASTERY && em) {
          rankRadios[fp] = 8;
        } else {
          rankRadios[fp] = 14 / nonCritValueProps.length;
        }
      }
    }

    return rankRadios;
  }
}
