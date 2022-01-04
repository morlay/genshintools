// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../weapon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSWeapon _$GSWeaponFromJson(Map<String, dynamic> json) {
  return _GSWeapon.fromJson(json);
}

/// @nodoc
class _$GSWeaponTearOff {
  const _$GSWeaponTearOff();

  _GSWeapon call(
      {required int id,
      required I18n name,
      required I18n desc,
      required int rarity,
      @WeaponTypeStringConverter()
          required WeaponType weaponType,
      required List<List<EquipAffix>> affixes,
      required int promoteId,
      @FightPropStringConverter()
          required Map<FightProp, PropGrowCurveAndInitial>
              propGrowCurveAndInitials}) {
    return _GSWeapon(
      id: id,
      name: name,
      desc: desc,
      rarity: rarity,
      weaponType: weaponType,
      affixes: affixes,
      promoteId: promoteId,
      propGrowCurveAndInitials: propGrowCurveAndInitials,
    );
  }

  GSWeapon fromJson(Map<String, Object?> json) {
    return GSWeapon.fromJson(json);
  }
}

/// @nodoc
const $GSWeapon = _$GSWeaponTearOff();

/// @nodoc
mixin _$GSWeapon {
  int get id => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  I18n get desc => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  @WeaponTypeStringConverter()
  WeaponType get weaponType => throw _privateConstructorUsedError;
  List<List<EquipAffix>> get affixes => throw _privateConstructorUsedError;
  int get promoteId => throw _privateConstructorUsedError;
  @FightPropStringConverter()
  Map<FightProp, PropGrowCurveAndInitial> get propGrowCurveAndInitials =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSWeaponCopyWith<GSWeapon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSWeaponCopyWith<$Res> {
  factory $GSWeaponCopyWith(GSWeapon value, $Res Function(GSWeapon) then) =
      _$GSWeaponCopyWithImpl<$Res>;
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      int rarity,
      @WeaponTypeStringConverter()
          WeaponType weaponType,
      List<List<EquipAffix>> affixes,
      int promoteId,
      @FightPropStringConverter()
          Map<FightProp, PropGrowCurveAndInitial> propGrowCurveAndInitials});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get desc;
}

/// @nodoc
class _$GSWeaponCopyWithImpl<$Res> implements $GSWeaponCopyWith<$Res> {
  _$GSWeaponCopyWithImpl(this._value, this._then);

  final GSWeapon _value;
  // ignore: unused_field
  final $Res Function(GSWeapon) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? rarity = freezed,
    Object? weaponType = freezed,
    Object? affixes = freezed,
    Object? promoteId = freezed,
    Object? propGrowCurveAndInitials = freezed,
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
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      weaponType: weaponType == freezed
          ? _value.weaponType
          : weaponType // ignore: cast_nullable_to_non_nullable
              as WeaponType,
      affixes: affixes == freezed
          ? _value.affixes
          : affixes // ignore: cast_nullable_to_non_nullable
              as List<List<EquipAffix>>,
      promoteId: promoteId == freezed
          ? _value.promoteId
          : promoteId // ignore: cast_nullable_to_non_nullable
              as int,
      propGrowCurveAndInitials: propGrowCurveAndInitials == freezed
          ? _value.propGrowCurveAndInitials
          : propGrowCurveAndInitials // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, PropGrowCurveAndInitial>,
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
}

/// @nodoc
abstract class _$GSWeaponCopyWith<$Res> implements $GSWeaponCopyWith<$Res> {
  factory _$GSWeaponCopyWith(_GSWeapon value, $Res Function(_GSWeapon) then) =
      __$GSWeaponCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      int rarity,
      @WeaponTypeStringConverter()
          WeaponType weaponType,
      List<List<EquipAffix>> affixes,
      int promoteId,
      @FightPropStringConverter()
          Map<FightProp, PropGrowCurveAndInitial> propGrowCurveAndInitials});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get desc;
}

/// @nodoc
class __$GSWeaponCopyWithImpl<$Res> extends _$GSWeaponCopyWithImpl<$Res>
    implements _$GSWeaponCopyWith<$Res> {
  __$GSWeaponCopyWithImpl(_GSWeapon _value, $Res Function(_GSWeapon) _then)
      : super(_value, (v) => _then(v as _GSWeapon));

  @override
  _GSWeapon get _value => super._value as _GSWeapon;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? rarity = freezed,
    Object? weaponType = freezed,
    Object? affixes = freezed,
    Object? promoteId = freezed,
    Object? propGrowCurveAndInitials = freezed,
  }) {
    return _then(_GSWeapon(
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
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      weaponType: weaponType == freezed
          ? _value.weaponType
          : weaponType // ignore: cast_nullable_to_non_nullable
              as WeaponType,
      affixes: affixes == freezed
          ? _value.affixes
          : affixes // ignore: cast_nullable_to_non_nullable
              as List<List<EquipAffix>>,
      promoteId: promoteId == freezed
          ? _value.promoteId
          : promoteId // ignore: cast_nullable_to_non_nullable
              as int,
      propGrowCurveAndInitials: propGrowCurveAndInitials == freezed
          ? _value.propGrowCurveAndInitials
          : propGrowCurveAndInitials // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, PropGrowCurveAndInitial>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_GSWeapon extends _GSWeapon {
  _$_GSWeapon(
      {required this.id,
      required this.name,
      required this.desc,
      required this.rarity,
      @WeaponTypeStringConverter() required this.weaponType,
      required this.affixes,
      required this.promoteId,
      @FightPropStringConverter() required this.propGrowCurveAndInitials})
      : super._();

  factory _$_GSWeapon.fromJson(Map<String, dynamic> json) =>
      _$$_GSWeaponFromJson(json);

  @override
  final int id;
  @override
  final I18n name;
  @override
  final I18n desc;
  @override
  final int rarity;
  @override
  @WeaponTypeStringConverter()
  final WeaponType weaponType;
  @override
  final List<List<EquipAffix>> affixes;
  @override
  final int promoteId;
  @override
  @FightPropStringConverter()
  final Map<FightProp, PropGrowCurveAndInitial> propGrowCurveAndInitials;

  @override
  String toString() {
    return 'GSWeapon(id: $id, name: $name, desc: $desc, rarity: $rarity, weaponType: $weaponType, affixes: $affixes, promoteId: $promoteId, propGrowCurveAndInitials: $propGrowCurveAndInitials)';
  }

  @JsonKey(ignore: true)
  @override
  _$GSWeaponCopyWith<_GSWeapon> get copyWith =>
      __$GSWeaponCopyWithImpl<_GSWeapon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GSWeaponToJson(this);
  }
}

abstract class _GSWeapon extends GSWeapon {
  factory _GSWeapon(
      {required int id,
      required I18n name,
      required I18n desc,
      required int rarity,
      @WeaponTypeStringConverter()
          required WeaponType weaponType,
      required List<List<EquipAffix>> affixes,
      required int promoteId,
      @FightPropStringConverter()
          required Map<FightProp, PropGrowCurveAndInitial>
              propGrowCurveAndInitials}) = _$_GSWeapon;
  _GSWeapon._() : super._();

  factory _GSWeapon.fromJson(Map<String, dynamic> json) = _$_GSWeapon.fromJson;

  @override
  int get id;
  @override
  I18n get name;
  @override
  I18n get desc;
  @override
  int get rarity;
  @override
  @WeaponTypeStringConverter()
  WeaponType get weaponType;
  @override
  List<List<EquipAffix>> get affixes;
  @override
  int get promoteId;
  @override
  @FightPropStringConverter()
  Map<FightProp, PropGrowCurveAndInitial> get propGrowCurveAndInitials;
  @override
  @JsonKey(ignore: true)
  _$GSWeaponCopyWith<_GSWeapon> get copyWith =>
      throw _privateConstructorUsedError;
}
