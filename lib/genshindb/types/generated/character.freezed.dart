// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../character.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSCharacter _$GSCharacterFromJson(Map<String, dynamic> json) {
  return _GSCharacter.fromJson(json);
}

/// @nodoc
class _$GSCharacterTearOff {
  const _$GSCharacterTearOff();

  _GSCharacter call(
      {required int id,
      required I18n name,
      required I18n desc,
      @ElementTypeStringConverter()
          required ElementType element,
      required int rarity,
      @WeaponTypeStringConverter()
          required WeaponType weaponType,
      required String initialWeaponKey,
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
      GSCharacterBuild? characterBuild}) {
    return _GSCharacter(
      id: id,
      name: name,
      desc: desc,
      element: element,
      rarity: rarity,
      weaponType: weaponType,
      initialWeaponKey: initialWeaponKey,
      critical: critical,
      criticalHurt: criticalHurt,
      staminaRecoverSpeed: staminaRecoverSpeed,
      chargeEfficiency: chargeEfficiency,
      constellations: constellations,
      inherentSkills: inherentSkills,
      skills: skills,
      skillLevelupMaterialCosts: skillLevelupMaterialCosts,
      promoteId: promoteId,
      propGrowCurveAndInitials: propGrowCurveAndInitials,
      characterBuild: characterBuild,
    );
  }

  GSCharacter fromJson(Map<String, Object?> json) {
    return GSCharacter.fromJson(json);
  }
}

/// @nodoc
const $GSCharacter = _$GSCharacterTearOff();

/// @nodoc
mixin _$GSCharacter {
  int get id => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  I18n get desc => throw _privateConstructorUsedError;
  @ElementTypeStringConverter()
  ElementType get element => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  @WeaponTypeStringConverter()
  WeaponType get weaponType => throw _privateConstructorUsedError;
  String get initialWeaponKey => throw _privateConstructorUsedError;
  double get critical => throw _privateConstructorUsedError;
  double get criticalHurt => throw _privateConstructorUsedError;
  double get staminaRecoverSpeed => throw _privateConstructorUsedError;
  double get chargeEfficiency => throw _privateConstructorUsedError;
  List<GSConstellation> get constellations =>
      throw _privateConstructorUsedError;
  List<InherentSkill> get inherentSkills => throw _privateConstructorUsedError;
  List<Skill> get skills => throw _privateConstructorUsedError;
  List<List<GSMaterialCost>> get skillLevelupMaterialCosts =>
      throw _privateConstructorUsedError;
  int get promoteId => throw _privateConstructorUsedError;
  @FightPropStringConverter()
  Map<FightProp, PropGrowCurveAndInitial> get propGrowCurveAndInitials =>
      throw _privateConstructorUsedError;
  GSCharacterBuild? get characterBuild => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSCharacterCopyWith<GSCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSCharacterCopyWith<$Res> {
  factory $GSCharacterCopyWith(
          GSCharacter value, $Res Function(GSCharacter) then) =
      _$GSCharacterCopyWithImpl<$Res>;
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      @ElementTypeStringConverter()
          ElementType element,
      int rarity,
      @WeaponTypeStringConverter()
          WeaponType weaponType,
      String initialWeaponKey,
      double critical,
      double criticalHurt,
      double staminaRecoverSpeed,
      double chargeEfficiency,
      List<GSConstellation> constellations,
      List<InherentSkill> inherentSkills,
      List<Skill> skills,
      List<List<GSMaterialCost>> skillLevelupMaterialCosts,
      int promoteId,
      @FightPropStringConverter()
          Map<FightProp, PropGrowCurveAndInitial> propGrowCurveAndInitials,
      GSCharacterBuild? characterBuild});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get desc;
  $GSCharacterBuildCopyWith<$Res>? get characterBuild;
}

/// @nodoc
class _$GSCharacterCopyWithImpl<$Res> implements $GSCharacterCopyWith<$Res> {
  _$GSCharacterCopyWithImpl(this._value, this._then);

  final GSCharacter _value;
  // ignore: unused_field
  final $Res Function(GSCharacter) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? element = freezed,
    Object? rarity = freezed,
    Object? weaponType = freezed,
    Object? initialWeaponKey = freezed,
    Object? critical = freezed,
    Object? criticalHurt = freezed,
    Object? staminaRecoverSpeed = freezed,
    Object? chargeEfficiency = freezed,
    Object? constellations = freezed,
    Object? inherentSkills = freezed,
    Object? skills = freezed,
    Object? skillLevelupMaterialCosts = freezed,
    Object? promoteId = freezed,
    Object? propGrowCurveAndInitials = freezed,
    Object? characterBuild = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as I18n,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as ElementType,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      weaponType: weaponType == freezed
          ? _value.weaponType
          : weaponType // ignore: cast_nullable_to_non_nullable
              as WeaponType,
      initialWeaponKey: initialWeaponKey == freezed
          ? _value.initialWeaponKey
          : initialWeaponKey // ignore: cast_nullable_to_non_nullable
              as String,
      critical: critical == freezed
          ? _value.critical
          : critical // ignore: cast_nullable_to_non_nullable
              as double,
      criticalHurt: criticalHurt == freezed
          ? _value.criticalHurt
          : criticalHurt // ignore: cast_nullable_to_non_nullable
              as double,
      staminaRecoverSpeed: staminaRecoverSpeed == freezed
          ? _value.staminaRecoverSpeed
          : staminaRecoverSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      chargeEfficiency: chargeEfficiency == freezed
          ? _value.chargeEfficiency
          : chargeEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      constellations: constellations == freezed
          ? _value.constellations
          : constellations // ignore: cast_nullable_to_non_nullable
              as List<GSConstellation>,
      inherentSkills: inherentSkills == freezed
          ? _value.inherentSkills
          : inherentSkills // ignore: cast_nullable_to_non_nullable
              as List<InherentSkill>,
      skills: skills == freezed
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      skillLevelupMaterialCosts: skillLevelupMaterialCosts == freezed
          ? _value.skillLevelupMaterialCosts
          : skillLevelupMaterialCosts // ignore: cast_nullable_to_non_nullable
              as List<List<GSMaterialCost>>,
      promoteId: promoteId == freezed
          ? _value.promoteId
          : promoteId // ignore: cast_nullable_to_non_nullable
              as int,
      propGrowCurveAndInitials: propGrowCurveAndInitials == freezed
          ? _value.propGrowCurveAndInitials
          : propGrowCurveAndInitials // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, PropGrowCurveAndInitial>,
      characterBuild: characterBuild == freezed
          ? _value.characterBuild
          : characterBuild // ignore: cast_nullable_to_non_nullable
              as GSCharacterBuild?,
    ));
  }

  @override
  $I18nCopyWith<$Res> get name {
    return $I18nCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value));
    });
  }

  @override
  $I18nCopyWith<$Res> get desc {
    return $I18nCopyWith<$Res>(_value.desc, (value) {
      return _then(_value.copyWith(desc: value));
    });
  }

  @override
  $GSCharacterBuildCopyWith<$Res>? get characterBuild {
    if (_value.characterBuild == null) {
      return null;
    }

    return $GSCharacterBuildCopyWith<$Res>(_value.characterBuild!, (value) {
      return _then(_value.copyWith(characterBuild: value));
    });
  }
}

/// @nodoc
abstract class _$GSCharacterCopyWith<$Res>
    implements $GSCharacterCopyWith<$Res> {
  factory _$GSCharacterCopyWith(
          _GSCharacter value, $Res Function(_GSCharacter) then) =
      __$GSCharacterCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      @ElementTypeStringConverter()
          ElementType element,
      int rarity,
      @WeaponTypeStringConverter()
          WeaponType weaponType,
      String initialWeaponKey,
      double critical,
      double criticalHurt,
      double staminaRecoverSpeed,
      double chargeEfficiency,
      List<GSConstellation> constellations,
      List<InherentSkill> inherentSkills,
      List<Skill> skills,
      List<List<GSMaterialCost>> skillLevelupMaterialCosts,
      int promoteId,
      @FightPropStringConverter()
          Map<FightProp, PropGrowCurveAndInitial> propGrowCurveAndInitials,
      GSCharacterBuild? characterBuild});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get desc;
  @override
  $GSCharacterBuildCopyWith<$Res>? get characterBuild;
}

/// @nodoc
class __$GSCharacterCopyWithImpl<$Res> extends _$GSCharacterCopyWithImpl<$Res>
    implements _$GSCharacterCopyWith<$Res> {
  __$GSCharacterCopyWithImpl(
      _GSCharacter _value, $Res Function(_GSCharacter) _then)
      : super(_value, (v) => _then(v as _GSCharacter));

  @override
  _GSCharacter get _value => super._value as _GSCharacter;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? element = freezed,
    Object? rarity = freezed,
    Object? weaponType = freezed,
    Object? initialWeaponKey = freezed,
    Object? critical = freezed,
    Object? criticalHurt = freezed,
    Object? staminaRecoverSpeed = freezed,
    Object? chargeEfficiency = freezed,
    Object? constellations = freezed,
    Object? inherentSkills = freezed,
    Object? skills = freezed,
    Object? skillLevelupMaterialCosts = freezed,
    Object? promoteId = freezed,
    Object? propGrowCurveAndInitials = freezed,
    Object? characterBuild = freezed,
  }) {
    return _then(_GSCharacter(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as I18n,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as ElementType,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      weaponType: weaponType == freezed
          ? _value.weaponType
          : weaponType // ignore: cast_nullable_to_non_nullable
              as WeaponType,
      initialWeaponKey: initialWeaponKey == freezed
          ? _value.initialWeaponKey
          : initialWeaponKey // ignore: cast_nullable_to_non_nullable
              as String,
      critical: critical == freezed
          ? _value.critical
          : critical // ignore: cast_nullable_to_non_nullable
              as double,
      criticalHurt: criticalHurt == freezed
          ? _value.criticalHurt
          : criticalHurt // ignore: cast_nullable_to_non_nullable
              as double,
      staminaRecoverSpeed: staminaRecoverSpeed == freezed
          ? _value.staminaRecoverSpeed
          : staminaRecoverSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      chargeEfficiency: chargeEfficiency == freezed
          ? _value.chargeEfficiency
          : chargeEfficiency // ignore: cast_nullable_to_non_nullable
              as double,
      constellations: constellations == freezed
          ? _value.constellations
          : constellations // ignore: cast_nullable_to_non_nullable
              as List<GSConstellation>,
      inherentSkills: inherentSkills == freezed
          ? _value.inherentSkills
          : inherentSkills // ignore: cast_nullable_to_non_nullable
              as List<InherentSkill>,
      skills: skills == freezed
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      skillLevelupMaterialCosts: skillLevelupMaterialCosts == freezed
          ? _value.skillLevelupMaterialCosts
          : skillLevelupMaterialCosts // ignore: cast_nullable_to_non_nullable
              as List<List<GSMaterialCost>>,
      promoteId: promoteId == freezed
          ? _value.promoteId
          : promoteId // ignore: cast_nullable_to_non_nullable
              as int,
      propGrowCurveAndInitials: propGrowCurveAndInitials == freezed
          ? _value.propGrowCurveAndInitials
          : propGrowCurveAndInitials // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, PropGrowCurveAndInitial>,
      characterBuild: characterBuild == freezed
          ? _value.characterBuild
          : characterBuild // ignore: cast_nullable_to_non_nullable
              as GSCharacterBuild?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_GSCharacter extends _GSCharacter {
  _$_GSCharacter(
      {required this.id,
      required this.name,
      required this.desc,
      @ElementTypeStringConverter() required this.element,
      required this.rarity,
      @WeaponTypeStringConverter() required this.weaponType,
      required this.initialWeaponKey,
      required this.critical,
      required this.criticalHurt,
      required this.staminaRecoverSpeed,
      required this.chargeEfficiency,
      required this.constellations,
      required this.inherentSkills,
      required this.skills,
      required this.skillLevelupMaterialCosts,
      required this.promoteId,
      @FightPropStringConverter() required this.propGrowCurveAndInitials,
      this.characterBuild})
      : super._();

  factory _$_GSCharacter.fromJson(Map<String, dynamic> json) =>
      _$$_GSCharacterFromJson(json);

  @override
  final int id;
  @override
  final I18n name;
  @override
  final I18n desc;
  @override
  @ElementTypeStringConverter()
  final ElementType element;
  @override
  final int rarity;
  @override
  @WeaponTypeStringConverter()
  final WeaponType weaponType;
  @override
  final String initialWeaponKey;
  @override
  final double critical;
  @override
  final double criticalHurt;
  @override
  final double staminaRecoverSpeed;
  @override
  final double chargeEfficiency;
  @override
  final List<GSConstellation> constellations;
  @override
  final List<InherentSkill> inherentSkills;
  @override
  final List<Skill> skills;
  @override
  final List<List<GSMaterialCost>> skillLevelupMaterialCosts;
  @override
  final int promoteId;
  @override
  @FightPropStringConverter()
  final Map<FightProp, PropGrowCurveAndInitial> propGrowCurveAndInitials;
  @override
  final GSCharacterBuild? characterBuild;

  @override
  String toString() {
    return 'GSCharacter(id: $id, name: $name, desc: $desc, element: $element, rarity: $rarity, weaponType: $weaponType, initialWeaponKey: $initialWeaponKey, critical: $critical, criticalHurt: $criticalHurt, staminaRecoverSpeed: $staminaRecoverSpeed, chargeEfficiency: $chargeEfficiency, constellations: $constellations, inherentSkills: $inherentSkills, skills: $skills, skillLevelupMaterialCosts: $skillLevelupMaterialCosts, promoteId: $promoteId, propGrowCurveAndInitials: $propGrowCurveAndInitials, characterBuild: $characterBuild)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GSCharacter &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.element, element) &&
            const DeepCollectionEquality().equals(other.rarity, rarity) &&
            const DeepCollectionEquality()
                .equals(other.weaponType, weaponType) &&
            const DeepCollectionEquality()
                .equals(other.initialWeaponKey, initialWeaponKey) &&
            const DeepCollectionEquality().equals(other.critical, critical) &&
            const DeepCollectionEquality()
                .equals(other.criticalHurt, criticalHurt) &&
            const DeepCollectionEquality()
                .equals(other.staminaRecoverSpeed, staminaRecoverSpeed) &&
            const DeepCollectionEquality()
                .equals(other.chargeEfficiency, chargeEfficiency) &&
            const DeepCollectionEquality()
                .equals(other.constellations, constellations) &&
            const DeepCollectionEquality()
                .equals(other.inherentSkills, inherentSkills) &&
            const DeepCollectionEquality().equals(other.skills, skills) &&
            const DeepCollectionEquality().equals(
                other.skillLevelupMaterialCosts, skillLevelupMaterialCosts) &&
            const DeepCollectionEquality().equals(other.promoteId, promoteId) &&
            const DeepCollectionEquality().equals(
                other.propGrowCurveAndInitials, propGrowCurveAndInitials) &&
            const DeepCollectionEquality()
                .equals(other.characterBuild, characterBuild));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(element),
      const DeepCollectionEquality().hash(rarity),
      const DeepCollectionEquality().hash(weaponType),
      const DeepCollectionEquality().hash(initialWeaponKey),
      const DeepCollectionEquality().hash(critical),
      const DeepCollectionEquality().hash(criticalHurt),
      const DeepCollectionEquality().hash(staminaRecoverSpeed),
      const DeepCollectionEquality().hash(chargeEfficiency),
      const DeepCollectionEquality().hash(constellations),
      const DeepCollectionEquality().hash(inherentSkills),
      const DeepCollectionEquality().hash(skills),
      const DeepCollectionEquality().hash(skillLevelupMaterialCosts),
      const DeepCollectionEquality().hash(promoteId),
      const DeepCollectionEquality().hash(propGrowCurveAndInitials),
      const DeepCollectionEquality().hash(characterBuild));

  @JsonKey(ignore: true)
  @override
  _$GSCharacterCopyWith<_GSCharacter> get copyWith =>
      __$GSCharacterCopyWithImpl<_GSCharacter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GSCharacterToJson(this);
  }
}

abstract class _GSCharacter extends GSCharacter {
  factory _GSCharacter(
      {required int id,
      required I18n name,
      required I18n desc,
      @ElementTypeStringConverter()
          required ElementType element,
      required int rarity,
      @WeaponTypeStringConverter()
          required WeaponType weaponType,
      required String initialWeaponKey,
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
      GSCharacterBuild? characterBuild}) = _$_GSCharacter;
  _GSCharacter._() : super._();

  factory _GSCharacter.fromJson(Map<String, dynamic> json) =
      _$_GSCharacter.fromJson;

  @override
  int get id;
  @override
  I18n get name;
  @override
  I18n get desc;
  @override
  @ElementTypeStringConverter()
  ElementType get element;
  @override
  int get rarity;
  @override
  @WeaponTypeStringConverter()
  WeaponType get weaponType;
  @override
  String get initialWeaponKey;
  @override
  double get critical;
  @override
  double get criticalHurt;
  @override
  double get staminaRecoverSpeed;
  @override
  double get chargeEfficiency;
  @override
  List<GSConstellation> get constellations;
  @override
  List<InherentSkill> get inherentSkills;
  @override
  List<Skill> get skills;
  @override
  List<List<GSMaterialCost>> get skillLevelupMaterialCosts;
  @override
  int get promoteId;
  @override
  @FightPropStringConverter()
  Map<FightProp, PropGrowCurveAndInitial> get propGrowCurveAndInitials;
  @override
  GSCharacterBuild? get characterBuild;
  @override
  @JsonKey(ignore: true)
  _$GSCharacterCopyWith<_GSCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

GSCharacterBuild _$GSCharacterBuildFromJson(Map<String, dynamic> json) {
  return _GSCharacterBuild.fromJson(json);
}

/// @nodoc
class _$GSCharacterBuildTearOff {
  const _$GSCharacterBuildTearOff();

  _GSCharacterBuild call(
      {List<String>? weapons,
      List<List<String>>? artifactSetPairs,
      @EquipTypeStringConverter()
          Map<EquipType, List<FightProp>>? artifactMainPropTypes,
      List<FightProp>? artifactAffixPropTypes,
      @SkillTypeStringConverter()
          List<List<SkillType>>? skillPriority}) {
    return _GSCharacterBuild(
      weapons: weapons,
      artifactSetPairs: artifactSetPairs,
      artifactMainPropTypes: artifactMainPropTypes,
      artifactAffixPropTypes: artifactAffixPropTypes,
      skillPriority: skillPriority,
    );
  }

  GSCharacterBuild fromJson(Map<String, Object?> json) {
    return GSCharacterBuild.fromJson(json);
  }
}

/// @nodoc
const $GSCharacterBuild = _$GSCharacterBuildTearOff();

/// @nodoc
mixin _$GSCharacterBuild {
  List<String>? get weapons => throw _privateConstructorUsedError;
  List<List<String>>? get artifactSetPairs =>
      throw _privateConstructorUsedError;
  @EquipTypeStringConverter()
  Map<EquipType, List<FightProp>>? get artifactMainPropTypes =>
      throw _privateConstructorUsedError;
  List<FightProp>? get artifactAffixPropTypes =>
      throw _privateConstructorUsedError;
  @SkillTypeStringConverter()
  List<List<SkillType>>? get skillPriority =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSCharacterBuildCopyWith<GSCharacterBuild> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSCharacterBuildCopyWith<$Res> {
  factory $GSCharacterBuildCopyWith(
          GSCharacterBuild value, $Res Function(GSCharacterBuild) then) =
      _$GSCharacterBuildCopyWithImpl<$Res>;
  $Res call(
      {List<String>? weapons,
      List<List<String>>? artifactSetPairs,
      @EquipTypeStringConverter()
          Map<EquipType, List<FightProp>>? artifactMainPropTypes,
      List<FightProp>? artifactAffixPropTypes,
      @SkillTypeStringConverter()
          List<List<SkillType>>? skillPriority});
}

/// @nodoc
class _$GSCharacterBuildCopyWithImpl<$Res>
    implements $GSCharacterBuildCopyWith<$Res> {
  _$GSCharacterBuildCopyWithImpl(this._value, this._then);

  final GSCharacterBuild _value;
  // ignore: unused_field
  final $Res Function(GSCharacterBuild) _then;

  @override
  $Res call({
    Object? weapons = freezed,
    Object? artifactSetPairs = freezed,
    Object? artifactMainPropTypes = freezed,
    Object? artifactAffixPropTypes = freezed,
    Object? skillPriority = freezed,
  }) {
    return _then(_value.copyWith(
      weapons: weapons == freezed
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      artifactSetPairs: artifactSetPairs == freezed
          ? _value.artifactSetPairs
          : artifactSetPairs // ignore: cast_nullable_to_non_nullable
              as List<List<String>>?,
      artifactMainPropTypes: artifactMainPropTypes == freezed
          ? _value.artifactMainPropTypes
          : artifactMainPropTypes // ignore: cast_nullable_to_non_nullable
              as Map<EquipType, List<FightProp>>?,
      artifactAffixPropTypes: artifactAffixPropTypes == freezed
          ? _value.artifactAffixPropTypes
          : artifactAffixPropTypes // ignore: cast_nullable_to_non_nullable
              as List<FightProp>?,
      skillPriority: skillPriority == freezed
          ? _value.skillPriority
          : skillPriority // ignore: cast_nullable_to_non_nullable
              as List<List<SkillType>>?,
    ));
  }
}

/// @nodoc
abstract class _$GSCharacterBuildCopyWith<$Res>
    implements $GSCharacterBuildCopyWith<$Res> {
  factory _$GSCharacterBuildCopyWith(
          _GSCharacterBuild value, $Res Function(_GSCharacterBuild) then) =
      __$GSCharacterBuildCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<String>? weapons,
      List<List<String>>? artifactSetPairs,
      @EquipTypeStringConverter()
          Map<EquipType, List<FightProp>>? artifactMainPropTypes,
      List<FightProp>? artifactAffixPropTypes,
      @SkillTypeStringConverter()
          List<List<SkillType>>? skillPriority});
}

/// @nodoc
class __$GSCharacterBuildCopyWithImpl<$Res>
    extends _$GSCharacterBuildCopyWithImpl<$Res>
    implements _$GSCharacterBuildCopyWith<$Res> {
  __$GSCharacterBuildCopyWithImpl(
      _GSCharacterBuild _value, $Res Function(_GSCharacterBuild) _then)
      : super(_value, (v) => _then(v as _GSCharacterBuild));

  @override
  _GSCharacterBuild get _value => super._value as _GSCharacterBuild;

  @override
  $Res call({
    Object? weapons = freezed,
    Object? artifactSetPairs = freezed,
    Object? artifactMainPropTypes = freezed,
    Object? artifactAffixPropTypes = freezed,
    Object? skillPriority = freezed,
  }) {
    return _then(_GSCharacterBuild(
      weapons: weapons == freezed
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      artifactSetPairs: artifactSetPairs == freezed
          ? _value.artifactSetPairs
          : artifactSetPairs // ignore: cast_nullable_to_non_nullable
              as List<List<String>>?,
      artifactMainPropTypes: artifactMainPropTypes == freezed
          ? _value.artifactMainPropTypes
          : artifactMainPropTypes // ignore: cast_nullable_to_non_nullable
              as Map<EquipType, List<FightProp>>?,
      artifactAffixPropTypes: artifactAffixPropTypes == freezed
          ? _value.artifactAffixPropTypes
          : artifactAffixPropTypes // ignore: cast_nullable_to_non_nullable
              as List<FightProp>?,
      skillPriority: skillPriority == freezed
          ? _value.skillPriority
          : skillPriority // ignore: cast_nullable_to_non_nullable
              as List<List<SkillType>>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_GSCharacterBuild extends _GSCharacterBuild {
  _$_GSCharacterBuild(
      {this.weapons,
      this.artifactSetPairs,
      @EquipTypeStringConverter() this.artifactMainPropTypes,
      this.artifactAffixPropTypes,
      @SkillTypeStringConverter() this.skillPriority})
      : super._();

  factory _$_GSCharacterBuild.fromJson(Map<String, dynamic> json) =>
      _$$_GSCharacterBuildFromJson(json);

  @override
  final List<String>? weapons;
  @override
  final List<List<String>>? artifactSetPairs;
  @override
  @EquipTypeStringConverter()
  final Map<EquipType, List<FightProp>>? artifactMainPropTypes;
  @override
  final List<FightProp>? artifactAffixPropTypes;
  @override
  @SkillTypeStringConverter()
  final List<List<SkillType>>? skillPriority;

  @override
  String toString() {
    return 'GSCharacterBuild(weapons: $weapons, artifactSetPairs: $artifactSetPairs, artifactMainPropTypes: $artifactMainPropTypes, artifactAffixPropTypes: $artifactAffixPropTypes, skillPriority: $skillPriority)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GSCharacterBuild &&
            const DeepCollectionEquality().equals(other.weapons, weapons) &&
            const DeepCollectionEquality()
                .equals(other.artifactSetPairs, artifactSetPairs) &&
            const DeepCollectionEquality()
                .equals(other.artifactMainPropTypes, artifactMainPropTypes) &&
            const DeepCollectionEquality()
                .equals(other.artifactAffixPropTypes, artifactAffixPropTypes) &&
            const DeepCollectionEquality()
                .equals(other.skillPriority, skillPriority));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(weapons),
      const DeepCollectionEquality().hash(artifactSetPairs),
      const DeepCollectionEquality().hash(artifactMainPropTypes),
      const DeepCollectionEquality().hash(artifactAffixPropTypes),
      const DeepCollectionEquality().hash(skillPriority));

  @JsonKey(ignore: true)
  @override
  _$GSCharacterBuildCopyWith<_GSCharacterBuild> get copyWith =>
      __$GSCharacterBuildCopyWithImpl<_GSCharacterBuild>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GSCharacterBuildToJson(this);
  }
}

abstract class _GSCharacterBuild extends GSCharacterBuild {
  factory _GSCharacterBuild(
      {List<String>? weapons,
      List<List<String>>? artifactSetPairs,
      @EquipTypeStringConverter()
          Map<EquipType, List<FightProp>>? artifactMainPropTypes,
      List<FightProp>? artifactAffixPropTypes,
      @SkillTypeStringConverter()
          List<List<SkillType>>? skillPriority}) = _$_GSCharacterBuild;
  _GSCharacterBuild._() : super._();

  factory _GSCharacterBuild.fromJson(Map<String, dynamic> json) =
      _$_GSCharacterBuild.fromJson;

  @override
  List<String>? get weapons;
  @override
  List<List<String>>? get artifactSetPairs;
  @override
  @EquipTypeStringConverter()
  Map<EquipType, List<FightProp>>? get artifactMainPropTypes;
  @override
  List<FightProp>? get artifactAffixPropTypes;
  @override
  @SkillTypeStringConverter()
  List<List<SkillType>>? get skillPriority;
  @override
  @JsonKey(ignore: true)
  _$GSCharacterBuildCopyWith<_GSCharacterBuild> get copyWith =>
      throw _privateConstructorUsedError;
}
