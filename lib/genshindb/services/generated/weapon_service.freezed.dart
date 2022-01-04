// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../weapon_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WeaponService _$WeaponServiceFromJson(Map<String, dynamic> json) {
  return _WeaponService.fromJson(json);
}

/// @nodoc
class _$WeaponServiceTearOff {
  const _$WeaponServiceTearOff();

  _WeaponService call(
      {Map<int, GSWeapon>? weapons,
      List<List<int>>? weaponLevelupExps,
      GSPromoteSet? weaponPromotes,
      PropGrowCurveValueSet? weaponPropGrowCurveValues}) {
    return _WeaponService(
      weapons: weapons,
      weaponLevelupExps: weaponLevelupExps,
      weaponPromotes: weaponPromotes,
      weaponPropGrowCurveValues: weaponPropGrowCurveValues,
    );
  }

  WeaponService fromJson(Map<String, Object?> json) {
    return WeaponService.fromJson(json);
  }
}

/// @nodoc
const $WeaponService = _$WeaponServiceTearOff();

/// @nodoc
mixin _$WeaponService {
  Map<int, GSWeapon>? get weapons => throw _privateConstructorUsedError;
  List<List<int>>? get weaponLevelupExps => throw _privateConstructorUsedError;
  GSPromoteSet? get weaponPromotes => throw _privateConstructorUsedError;
  PropGrowCurveValueSet? get weaponPropGrowCurveValues =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeaponServiceCopyWith<WeaponService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeaponServiceCopyWith<$Res> {
  factory $WeaponServiceCopyWith(
          WeaponService value, $Res Function(WeaponService) then) =
      _$WeaponServiceCopyWithImpl<$Res>;
  $Res call(
      {Map<int, GSWeapon>? weapons,
      List<List<int>>? weaponLevelupExps,
      GSPromoteSet? weaponPromotes,
      PropGrowCurveValueSet? weaponPropGrowCurveValues});

  $GSPromoteSetCopyWith<$Res>? get weaponPromotes;
  $PropGrowCurveValueSetCopyWith<$Res>? get weaponPropGrowCurveValues;
}

/// @nodoc
class _$WeaponServiceCopyWithImpl<$Res>
    implements $WeaponServiceCopyWith<$Res> {
  _$WeaponServiceCopyWithImpl(this._value, this._then);

  final WeaponService _value;
  // ignore: unused_field
  final $Res Function(WeaponService) _then;

  @override
  $Res call({
    Object? weapons = freezed,
    Object? weaponLevelupExps = freezed,
    Object? weaponPromotes = freezed,
    Object? weaponPropGrowCurveValues = freezed,
  }) {
    return _then(_value.copyWith(
      weapons: weapons == freezed
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as Map<int, GSWeapon>?,
      weaponLevelupExps: weaponLevelupExps == freezed
          ? _value.weaponLevelupExps
          : weaponLevelupExps // ignore: cast_nullable_to_non_nullable
              as List<List<int>>?,
      weaponPromotes: weaponPromotes == freezed
          ? _value.weaponPromotes
          : weaponPromotes // ignore: cast_nullable_to_non_nullable
              as GSPromoteSet?,
      weaponPropGrowCurveValues: weaponPropGrowCurveValues == freezed
          ? _value.weaponPropGrowCurveValues
          : weaponPropGrowCurveValues // ignore: cast_nullable_to_non_nullable
              as PropGrowCurveValueSet?,
    ));
  }

  @override
  $GSPromoteSetCopyWith<$Res>? get weaponPromotes {
    if (_value.weaponPromotes == null) {
      return null;
    }

    return $GSPromoteSetCopyWith<$Res>(_value.weaponPromotes!, (value) {
      return _then(_value.copyWith(weaponPromotes: value));
    });
  }

  @override
  $PropGrowCurveValueSetCopyWith<$Res>? get weaponPropGrowCurveValues {
    if (_value.weaponPropGrowCurveValues == null) {
      return null;
    }

    return $PropGrowCurveValueSetCopyWith<$Res>(
        _value.weaponPropGrowCurveValues!, (value) {
      return _then(_value.copyWith(weaponPropGrowCurveValues: value));
    });
  }
}

/// @nodoc
abstract class _$WeaponServiceCopyWith<$Res>
    implements $WeaponServiceCopyWith<$Res> {
  factory _$WeaponServiceCopyWith(
          _WeaponService value, $Res Function(_WeaponService) then) =
      __$WeaponServiceCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<int, GSWeapon>? weapons,
      List<List<int>>? weaponLevelupExps,
      GSPromoteSet? weaponPromotes,
      PropGrowCurveValueSet? weaponPropGrowCurveValues});

  @override
  $GSPromoteSetCopyWith<$Res>? get weaponPromotes;
  @override
  $PropGrowCurveValueSetCopyWith<$Res>? get weaponPropGrowCurveValues;
}

/// @nodoc
class __$WeaponServiceCopyWithImpl<$Res>
    extends _$WeaponServiceCopyWithImpl<$Res>
    implements _$WeaponServiceCopyWith<$Res> {
  __$WeaponServiceCopyWithImpl(
      _WeaponService _value, $Res Function(_WeaponService) _then)
      : super(_value, (v) => _then(v as _WeaponService));

  @override
  _WeaponService get _value => super._value as _WeaponService;

  @override
  $Res call({
    Object? weapons = freezed,
    Object? weaponLevelupExps = freezed,
    Object? weaponPromotes = freezed,
    Object? weaponPropGrowCurveValues = freezed,
  }) {
    return _then(_WeaponService(
      weapons: weapons == freezed
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as Map<int, GSWeapon>?,
      weaponLevelupExps: weaponLevelupExps == freezed
          ? _value.weaponLevelupExps
          : weaponLevelupExps // ignore: cast_nullable_to_non_nullable
              as List<List<int>>?,
      weaponPromotes: weaponPromotes == freezed
          ? _value.weaponPromotes
          : weaponPromotes // ignore: cast_nullable_to_non_nullable
              as GSPromoteSet?,
      weaponPropGrowCurveValues: weaponPropGrowCurveValues == freezed
          ? _value.weaponPropGrowCurveValues
          : weaponPropGrowCurveValues // ignore: cast_nullable_to_non_nullable
              as PropGrowCurveValueSet?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_WeaponService extends _WeaponService {
  _$_WeaponService(
      {this.weapons,
      this.weaponLevelupExps,
      this.weaponPromotes,
      this.weaponPropGrowCurveValues})
      : super._();

  factory _$_WeaponService.fromJson(Map<String, dynamic> json) =>
      _$$_WeaponServiceFromJson(json);

  @override
  final Map<int, GSWeapon>? weapons;
  @override
  final List<List<int>>? weaponLevelupExps;
  @override
  final GSPromoteSet? weaponPromotes;
  @override
  final PropGrowCurveValueSet? weaponPropGrowCurveValues;

  @override
  String toString() {
    return 'WeaponService(weapons: $weapons, weaponLevelupExps: $weaponLevelupExps, weaponPromotes: $weaponPromotes, weaponPropGrowCurveValues: $weaponPropGrowCurveValues)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WeaponService &&
            const DeepCollectionEquality().equals(other.weapons, weapons) &&
            const DeepCollectionEquality()
                .equals(other.weaponLevelupExps, weaponLevelupExps) &&
            const DeepCollectionEquality()
                .equals(other.weaponPromotes, weaponPromotes) &&
            const DeepCollectionEquality().equals(
                other.weaponPropGrowCurveValues, weaponPropGrowCurveValues));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(weapons),
      const DeepCollectionEquality().hash(weaponLevelupExps),
      const DeepCollectionEquality().hash(weaponPromotes),
      const DeepCollectionEquality().hash(weaponPropGrowCurveValues));

  @JsonKey(ignore: true)
  @override
  _$WeaponServiceCopyWith<_WeaponService> get copyWith =>
      __$WeaponServiceCopyWithImpl<_WeaponService>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeaponServiceToJson(this);
  }
}

abstract class _WeaponService extends WeaponService {
  factory _WeaponService(
      {Map<int, GSWeapon>? weapons,
      List<List<int>>? weaponLevelupExps,
      GSPromoteSet? weaponPromotes,
      PropGrowCurveValueSet? weaponPropGrowCurveValues}) = _$_WeaponService;
  _WeaponService._() : super._();

  factory _WeaponService.fromJson(Map<String, dynamic> json) =
      _$_WeaponService.fromJson;

  @override
  Map<int, GSWeapon>? get weapons;
  @override
  List<List<int>>? get weaponLevelupExps;
  @override
  GSPromoteSet? get weaponPromotes;
  @override
  PropGrowCurveValueSet? get weaponPropGrowCurveValues;
  @override
  @JsonKey(ignore: true)
  _$WeaponServiceCopyWith<_WeaponService> get copyWith =>
      throw _privateConstructorUsedError;
}
