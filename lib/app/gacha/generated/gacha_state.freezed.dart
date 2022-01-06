// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../gacha_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GachaState _$GachaStateFromJson(Map<String, dynamic> json) {
  return _GachaState.fromJson(json);
}

/// @nodoc
class _$GachaStateTearOff {
  const _$GachaStateTearOff();

  _GachaState call({Map<String, List<GachaLog>> logs = const {}}) {
    return _GachaState(
      logs: logs,
    );
  }

  GachaState fromJson(Map<String, Object?> json) {
    return GachaState.fromJson(json);
  }
}

/// @nodoc
const $GachaState = _$GachaStateTearOff();

/// @nodoc
mixin _$GachaState {
  Map<String, List<GachaLog>> get logs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GachaStateCopyWith<GachaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GachaStateCopyWith<$Res> {
  factory $GachaStateCopyWith(
          GachaState value, $Res Function(GachaState) then) =
      _$GachaStateCopyWithImpl<$Res>;
  $Res call({Map<String, List<GachaLog>> logs});
}

/// @nodoc
class _$GachaStateCopyWithImpl<$Res> implements $GachaStateCopyWith<$Res> {
  _$GachaStateCopyWithImpl(this._value, this._then);

  final GachaState _value;
  // ignore: unused_field
  final $Res Function(GachaState) _then;

  @override
  $Res call({
    Object? logs = freezed,
  }) {
    return _then(_value.copyWith(
      logs: logs == freezed
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as Map<String, List<GachaLog>>,
    ));
  }
}

/// @nodoc
abstract class _$GachaStateCopyWith<$Res> implements $GachaStateCopyWith<$Res> {
  factory _$GachaStateCopyWith(
          _GachaState value, $Res Function(_GachaState) then) =
      __$GachaStateCopyWithImpl<$Res>;
  @override
  $Res call({Map<String, List<GachaLog>> logs});
}

/// @nodoc
class __$GachaStateCopyWithImpl<$Res> extends _$GachaStateCopyWithImpl<$Res>
    implements _$GachaStateCopyWith<$Res> {
  __$GachaStateCopyWithImpl(
      _GachaState _value, $Res Function(_GachaState) _then)
      : super(_value, (v) => _then(v as _GachaState));

  @override
  _GachaState get _value => super._value as _GachaState;

  @override
  $Res call({
    Object? logs = freezed,
  }) {
    return _then(_GachaState(
      logs: logs == freezed
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as Map<String, List<GachaLog>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GachaState extends _GachaState {
  _$_GachaState({this.logs = const {}}) : super._();

  factory _$_GachaState.fromJson(Map<String, dynamic> json) =>
      _$$_GachaStateFromJson(json);

  @JsonKey()
  @override
  final Map<String, List<GachaLog>> logs;

  @override
  String toString() {
    return 'GachaState(logs: $logs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GachaState &&
            const DeepCollectionEquality().equals(other.logs, logs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(logs));

  @JsonKey(ignore: true)
  @override
  _$GachaStateCopyWith<_GachaState> get copyWith =>
      __$GachaStateCopyWithImpl<_GachaState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GachaStateToJson(this);
  }
}

abstract class _GachaState extends GachaState {
  factory _GachaState({Map<String, List<GachaLog>> logs}) = _$_GachaState;
  _GachaState._() : super._();

  factory _GachaState.fromJson(Map<String, dynamic> json) =
      _$_GachaState.fromJson;

  @override
  Map<String, List<GachaLog>> get logs;
  @override
  @JsonKey(ignore: true)
  _$GachaStateCopyWith<_GachaState> get copyWith =>
      throw _privateConstructorUsedError;
}
