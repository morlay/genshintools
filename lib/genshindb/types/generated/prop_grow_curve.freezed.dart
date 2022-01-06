// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../prop_grow_curve.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PropGrowCurveAndInitial _$PropGrowCurveAndInitialFromJson(
    Map<String, dynamic> json) {
  return _PropGrowCurveAndInitial.fromJson(json);
}

/// @nodoc
class _$PropGrowCurveAndInitialTearOff {
  const _$PropGrowCurveAndInitialTearOff();

  _PropGrowCurveAndInitial call(
      {required String growCurve, required double initial}) {
    return _PropGrowCurveAndInitial(
      growCurve: growCurve,
      initial: initial,
    );
  }

  PropGrowCurveAndInitial fromJson(Map<String, Object?> json) {
    return PropGrowCurveAndInitial.fromJson(json);
  }
}

/// @nodoc
const $PropGrowCurveAndInitial = _$PropGrowCurveAndInitialTearOff();

/// @nodoc
mixin _$PropGrowCurveAndInitial {
  String get growCurve => throw _privateConstructorUsedError;
  double get initial => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PropGrowCurveAndInitialCopyWith<PropGrowCurveAndInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropGrowCurveAndInitialCopyWith<$Res> {
  factory $PropGrowCurveAndInitialCopyWith(PropGrowCurveAndInitial value,
          $Res Function(PropGrowCurveAndInitial) then) =
      _$PropGrowCurveAndInitialCopyWithImpl<$Res>;
  $Res call({String growCurve, double initial});
}

/// @nodoc
class _$PropGrowCurveAndInitialCopyWithImpl<$Res>
    implements $PropGrowCurveAndInitialCopyWith<$Res> {
  _$PropGrowCurveAndInitialCopyWithImpl(this._value, this._then);

  final PropGrowCurveAndInitial _value;
  // ignore: unused_field
  final $Res Function(PropGrowCurveAndInitial) _then;

  @override
  $Res call({
    Object? growCurve = freezed,
    Object? initial = freezed,
  }) {
    return _then(_value.copyWith(
      growCurve: growCurve == freezed
          ? _value.growCurve
          : growCurve // ignore: cast_nullable_to_non_nullable
              as String,
      initial: initial == freezed
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$PropGrowCurveAndInitialCopyWith<$Res>
    implements $PropGrowCurveAndInitialCopyWith<$Res> {
  factory _$PropGrowCurveAndInitialCopyWith(_PropGrowCurveAndInitial value,
          $Res Function(_PropGrowCurveAndInitial) then) =
      __$PropGrowCurveAndInitialCopyWithImpl<$Res>;
  @override
  $Res call({String growCurve, double initial});
}

/// @nodoc
class __$PropGrowCurveAndInitialCopyWithImpl<$Res>
    extends _$PropGrowCurveAndInitialCopyWithImpl<$Res>
    implements _$PropGrowCurveAndInitialCopyWith<$Res> {
  __$PropGrowCurveAndInitialCopyWithImpl(_PropGrowCurveAndInitial _value,
      $Res Function(_PropGrowCurveAndInitial) _then)
      : super(_value, (v) => _then(v as _PropGrowCurveAndInitial));

  @override
  _PropGrowCurveAndInitial get _value =>
      super._value as _PropGrowCurveAndInitial;

  @override
  $Res call({
    Object? growCurve = freezed,
    Object? initial = freezed,
  }) {
    return _then(_PropGrowCurveAndInitial(
      growCurve: growCurve == freezed
          ? _value.growCurve
          : growCurve // ignore: cast_nullable_to_non_nullable
              as String,
      initial: initial == freezed
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_PropGrowCurveAndInitial implements _PropGrowCurveAndInitial {
  _$_PropGrowCurveAndInitial({required this.growCurve, required this.initial});

  factory _$_PropGrowCurveAndInitial.fromJson(Map<String, dynamic> json) =>
      _$$_PropGrowCurveAndInitialFromJson(json);

  @override
  final String growCurve;
  @override
  final double initial;

  @override
  String toString() {
    return 'PropGrowCurveAndInitial(growCurve: $growCurve, initial: $initial)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PropGrowCurveAndInitial &&
            const DeepCollectionEquality().equals(other.growCurve, growCurve) &&
            const DeepCollectionEquality().equals(other.initial, initial));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(growCurve),
      const DeepCollectionEquality().hash(initial));

  @JsonKey(ignore: true)
  @override
  _$PropGrowCurveAndInitialCopyWith<_PropGrowCurveAndInitial> get copyWith =>
      __$PropGrowCurveAndInitialCopyWithImpl<_PropGrowCurveAndInitial>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PropGrowCurveAndInitialToJson(this);
  }
}

abstract class _PropGrowCurveAndInitial implements PropGrowCurveAndInitial {
  factory _PropGrowCurveAndInitial(
      {required String growCurve,
      required double initial}) = _$_PropGrowCurveAndInitial;

  factory _PropGrowCurveAndInitial.fromJson(Map<String, dynamic> json) =
      _$_PropGrowCurveAndInitial.fromJson;

  @override
  String get growCurve;
  @override
  double get initial;
  @override
  @JsonKey(ignore: true)
  _$PropGrowCurveAndInitialCopyWith<_PropGrowCurveAndInitial> get copyWith =>
      throw _privateConstructorUsedError;
}

PropGrowCurveValueSet _$PropGrowCurveValueSetFromJson(
    Map<String, dynamic> json) {
  return _PropGrowCurveValueSet.fromJson(json);
}

/// @nodoc
class _$PropGrowCurveValueSetTearOff {
  const _$PropGrowCurveValueSetTearOff();

  _PropGrowCurveValueSet call(Map<String, List<double>> values) {
    return _PropGrowCurveValueSet(
      values,
    );
  }

  PropGrowCurveValueSet fromJson(Map<String, Object?> json) {
    return PropGrowCurveValueSet.fromJson(json);
  }
}

/// @nodoc
const $PropGrowCurveValueSet = _$PropGrowCurveValueSetTearOff();

/// @nodoc
mixin _$PropGrowCurveValueSet {
  Map<String, List<double>> get values => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PropGrowCurveValueSetCopyWith<PropGrowCurveValueSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PropGrowCurveValueSetCopyWith<$Res> {
  factory $PropGrowCurveValueSetCopyWith(PropGrowCurveValueSet value,
          $Res Function(PropGrowCurveValueSet) then) =
      _$PropGrowCurveValueSetCopyWithImpl<$Res>;
  $Res call({Map<String, List<double>> values});
}

/// @nodoc
class _$PropGrowCurveValueSetCopyWithImpl<$Res>
    implements $PropGrowCurveValueSetCopyWith<$Res> {
  _$PropGrowCurveValueSetCopyWithImpl(this._value, this._then);

  final PropGrowCurveValueSet _value;
  // ignore: unused_field
  final $Res Function(PropGrowCurveValueSet) _then;

  @override
  $Res call({
    Object? values = freezed,
  }) {
    return _then(_value.copyWith(
      values: values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<String, List<double>>,
    ));
  }
}

/// @nodoc
abstract class _$PropGrowCurveValueSetCopyWith<$Res>
    implements $PropGrowCurveValueSetCopyWith<$Res> {
  factory _$PropGrowCurveValueSetCopyWith(_PropGrowCurveValueSet value,
          $Res Function(_PropGrowCurveValueSet) then) =
      __$PropGrowCurveValueSetCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, List<double>> values});
}

/// @nodoc
class __$PropGrowCurveValueSetCopyWithImpl<$Res>
    extends _$PropGrowCurveValueSetCopyWithImpl<$Res>
    implements _$PropGrowCurveValueSetCopyWith<$Res> {
  __$PropGrowCurveValueSetCopyWithImpl(_PropGrowCurveValueSet _value,
      $Res Function(_PropGrowCurveValueSet) _then)
      : super(_value, (v) => _then(v as _PropGrowCurveValueSet));

  @override
  _PropGrowCurveValueSet get _value => super._value as _PropGrowCurveValueSet;

  @override
  $Res call({
    Object? values = freezed,
  }) {
    return _then(_PropGrowCurveValueSet(
      values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<String, List<double>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PropGrowCurveValueSet extends _PropGrowCurveValueSet {
  _$_PropGrowCurveValueSet(this.values) : super._();

  factory _$_PropGrowCurveValueSet.fromJson(Map<String, dynamic> json) =>
      _$$_PropGrowCurveValueSetFromJson(json);

  @override
  final Map<String, List<double>> values;

  @override
  String toString() {
    return 'PropGrowCurveValueSet(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PropGrowCurveValueSet &&
            const DeepCollectionEquality().equals(other.values, values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(values));

  @JsonKey(ignore: true)
  @override
  _$PropGrowCurveValueSetCopyWith<_PropGrowCurveValueSet> get copyWith =>
      __$PropGrowCurveValueSetCopyWithImpl<_PropGrowCurveValueSet>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PropGrowCurveValueSetToJson(this);
  }
}

abstract class _PropGrowCurveValueSet extends PropGrowCurveValueSet {
  factory _PropGrowCurveValueSet(Map<String, List<double>> values) =
      _$_PropGrowCurveValueSet;
  _PropGrowCurveValueSet._() : super._();

  factory _PropGrowCurveValueSet.fromJson(Map<String, dynamic> json) =
      _$_PropGrowCurveValueSet.fromJson;

  @override
  Map<String, List<double>> get values;
  @override
  @JsonKey(ignore: true)
  _$PropGrowCurveValueSetCopyWith<_PropGrowCurveValueSet> get copyWith =>
      throw _privateConstructorUsedError;
}
