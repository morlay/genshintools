// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../enemy_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EnemyService _$EnemyServiceFromJson(Map<String, dynamic> json) {
  return _EnemyService.fromJson(json);
}

/// @nodoc
class _$EnemyServiceTearOff {
  const _$EnemyServiceTearOff();

  _EnemyService call({Map<int, GSEnemy>? enemies}) {
    return _EnemyService(
      enemies: enemies,
    );
  }

  EnemyService fromJson(Map<String, Object?> json) {
    return EnemyService.fromJson(json);
  }
}

/// @nodoc
const $EnemyService = _$EnemyServiceTearOff();

/// @nodoc
mixin _$EnemyService {
  Map<int, GSEnemy>? get enemies => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnemyServiceCopyWith<EnemyService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnemyServiceCopyWith<$Res> {
  factory $EnemyServiceCopyWith(
          EnemyService value, $Res Function(EnemyService) then) =
      _$EnemyServiceCopyWithImpl<$Res>;
  $Res call({Map<int, GSEnemy>? enemies});
}

/// @nodoc
class _$EnemyServiceCopyWithImpl<$Res> implements $EnemyServiceCopyWith<$Res> {
  _$EnemyServiceCopyWithImpl(this._value, this._then);

  final EnemyService _value;
  // ignore: unused_field
  final $Res Function(EnemyService) _then;

  @override
  $Res call({
    Object? enemies = freezed,
  }) {
    return _then(_value.copyWith(
      enemies: enemies == freezed
          ? _value.enemies
          : enemies // ignore: cast_nullable_to_non_nullable
              as Map<int, GSEnemy>?,
    ));
  }
}

/// @nodoc
abstract class _$EnemyServiceCopyWith<$Res>
    implements $EnemyServiceCopyWith<$Res> {
  factory _$EnemyServiceCopyWith(
          _EnemyService value, $Res Function(_EnemyService) then) =
      __$EnemyServiceCopyWithImpl<$Res>;
  @override
  $Res call({Map<int, GSEnemy>? enemies});
}

/// @nodoc
class __$EnemyServiceCopyWithImpl<$Res> extends _$EnemyServiceCopyWithImpl<$Res>
    implements _$EnemyServiceCopyWith<$Res> {
  __$EnemyServiceCopyWithImpl(
      _EnemyService _value, $Res Function(_EnemyService) _then)
      : super(_value, (v) => _then(v as _EnemyService));

  @override
  _EnemyService get _value => super._value as _EnemyService;

  @override
  $Res call({
    Object? enemies = freezed,
  }) {
    return _then(_EnemyService(
      enemies: enemies == freezed
          ? _value.enemies
          : enemies // ignore: cast_nullable_to_non_nullable
              as Map<int, GSEnemy>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_EnemyService extends _EnemyService {
  _$_EnemyService({this.enemies}) : super._();

  factory _$_EnemyService.fromJson(Map<String, dynamic> json) =>
      _$$_EnemyServiceFromJson(json);

  @override
  final Map<int, GSEnemy>? enemies;

  @override
  String toString() {
    return 'EnemyService(enemies: $enemies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EnemyService &&
            const DeepCollectionEquality().equals(other.enemies, enemies));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(enemies));

  @JsonKey(ignore: true)
  @override
  _$EnemyServiceCopyWith<_EnemyService> get copyWith =>
      __$EnemyServiceCopyWithImpl<_EnemyService>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnemyServiceToJson(this);
  }
}

abstract class _EnemyService extends EnemyService {
  factory _EnemyService({Map<int, GSEnemy>? enemies}) = _$_EnemyService;
  _EnemyService._() : super._();

  factory _EnemyService.fromJson(Map<String, dynamic> json) =
      _$_EnemyService.fromJson;

  @override
  Map<int, GSEnemy>? get enemies;
  @override
  @JsonKey(ignore: true)
  _$EnemyServiceCopyWith<_EnemyService> get copyWith =>
      throw _privateConstructorUsedError;
}
