// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../fight_props.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FightProps _$FightPropsFromJson(Map<String, dynamic> json) {
  return _FightProps.fromJson(json);
}

/// @nodoc
class _$FightPropsTearOff {
  const _$FightPropsTearOff();

  _FightProps call(
      @FightPropStringConverter() Map<FightProp, double> fightProps) {
    return _FightProps(
      fightProps,
    );
  }

  FightProps fromJson(Map<String, Object?> json) {
    return FightProps.fromJson(json);
  }
}

/// @nodoc
const $FightProps = _$FightPropsTearOff();

/// @nodoc
mixin _$FightProps {
  @FightPropStringConverter()
  Map<FightProp, double> get fightProps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FightPropsCopyWith<FightProps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FightPropsCopyWith<$Res> {
  factory $FightPropsCopyWith(
          FightProps value, $Res Function(FightProps) then) =
      _$FightPropsCopyWithImpl<$Res>;
  $Res call({@FightPropStringConverter() Map<FightProp, double> fightProps});
}

/// @nodoc
class _$FightPropsCopyWithImpl<$Res> implements $FightPropsCopyWith<$Res> {
  _$FightPropsCopyWithImpl(this._value, this._then);

  final FightProps _value;
  // ignore: unused_field
  final $Res Function(FightProps) _then;

  @override
  $Res call({
    Object? fightProps = freezed,
  }) {
    return _then(_value.copyWith(
      fightProps: fightProps == freezed
          ? _value.fightProps
          : fightProps // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, double>,
    ));
  }
}

/// @nodoc
abstract class _$FightPropsCopyWith<$Res> implements $FightPropsCopyWith<$Res> {
  factory _$FightPropsCopyWith(
          _FightProps value, $Res Function(_FightProps) then) =
      __$FightPropsCopyWithImpl<$Res>;
  @override
  $Res call({@FightPropStringConverter() Map<FightProp, double> fightProps});
}

/// @nodoc
class __$FightPropsCopyWithImpl<$Res> extends _$FightPropsCopyWithImpl<$Res>
    implements _$FightPropsCopyWith<$Res> {
  __$FightPropsCopyWithImpl(
      _FightProps _value, $Res Function(_FightProps) _then)
      : super(_value, (v) => _then(v as _FightProps));

  @override
  _FightProps get _value => super._value as _FightProps;

  @override
  $Res call({
    Object? fightProps = freezed,
  }) {
    return _then(_FightProps(
      fightProps == freezed
          ? _value.fightProps
          : fightProps // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FightProps extends _FightProps {
  _$_FightProps(@FightPropStringConverter() this.fightProps) : super._();

  factory _$_FightProps.fromJson(Map<String, dynamic> json) =>
      _$$_FightPropsFromJson(json);

  @override
  @FightPropStringConverter()
  final Map<FightProp, double> fightProps;

  @override
  String toString() {
    return 'FightProps(fightProps: $fightProps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FightProps &&
            const DeepCollectionEquality()
                .equals(other.fightProps, fightProps));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(fightProps));

  @JsonKey(ignore: true)
  @override
  _$FightPropsCopyWith<_FightProps> get copyWith =>
      __$FightPropsCopyWithImpl<_FightProps>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FightPropsToJson(this);
  }
}

abstract class _FightProps extends FightProps {
  factory _FightProps(
          @FightPropStringConverter() Map<FightProp, double> fightProps) =
      _$_FightProps;
  _FightProps._() : super._();

  factory _FightProps.fromJson(Map<String, dynamic> json) =
      _$_FightProps.fromJson;

  @override
  @FightPropStringConverter()
  Map<FightProp, double> get fightProps;
  @override
  @JsonKey(ignore: true)
  _$FightPropsCopyWith<_FightProps> get copyWith =>
      throw _privateConstructorUsedError;
}
