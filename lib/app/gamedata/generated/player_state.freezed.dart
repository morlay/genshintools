// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CharacterWithStateTearOff {
  const _$CharacterWithStateTearOff();

  _CharacterWithState call(
      {required GSCharacter character,
      required GOODCharacter c,
      required GOODWeapon w,
      required List<GOODArtifact> artifacts}) {
    return _CharacterWithState(
      character: character,
      c: c,
      w: w,
      artifacts: artifacts,
    );
  }
}

/// @nodoc
const $CharacterWithState = _$CharacterWithStateTearOff();

/// @nodoc
mixin _$CharacterWithState {
  GSCharacter get character => throw _privateConstructorUsedError;
  GOODCharacter get c => throw _privateConstructorUsedError;
  GOODWeapon get w => throw _privateConstructorUsedError;
  List<GOODArtifact> get artifacts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CharacterWithStateCopyWith<CharacterWithState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterWithStateCopyWith<$Res> {
  factory $CharacterWithStateCopyWith(
          CharacterWithState value, $Res Function(CharacterWithState) then) =
      _$CharacterWithStateCopyWithImpl<$Res>;
  $Res call(
      {GSCharacter character,
      GOODCharacter c,
      GOODWeapon w,
      List<GOODArtifact> artifacts});

  $GSCharacterCopyWith<$Res> get character;
  $GOODCharacterCopyWith<$Res> get c;
  $GOODWeaponCopyWith<$Res> get w;
}

/// @nodoc
class _$CharacterWithStateCopyWithImpl<$Res>
    implements $CharacterWithStateCopyWith<$Res> {
  _$CharacterWithStateCopyWithImpl(this._value, this._then);

  final CharacterWithState _value;
  // ignore: unused_field
  final $Res Function(CharacterWithState) _then;

  @override
  $Res call({
    Object? character = freezed,
    Object? c = freezed,
    Object? w = freezed,
    Object? artifacts = freezed,
  }) {
    return _then(_value.copyWith(
      character: character == freezed
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as GSCharacter,
      c: c == freezed
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as GOODCharacter,
      w: w == freezed
          ? _value.w
          : w // ignore: cast_nullable_to_non_nullable
              as GOODWeapon,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as List<GOODArtifact>,
    ));
  }

  @override
  $GSCharacterCopyWith<$Res> get character {
    return $GSCharacterCopyWith<$Res>(_value.character, (value) {
      return _then(_value.copyWith(character: value));
    });
  }

  @override
  $GOODCharacterCopyWith<$Res> get c {
    return $GOODCharacterCopyWith<$Res>(_value.c, (value) {
      return _then(_value.copyWith(c: value));
    });
  }

  @override
  $GOODWeaponCopyWith<$Res> get w {
    return $GOODWeaponCopyWith<$Res>(_value.w, (value) {
      return _then(_value.copyWith(w: value));
    });
  }
}

/// @nodoc
abstract class _$CharacterWithStateCopyWith<$Res>
    implements $CharacterWithStateCopyWith<$Res> {
  factory _$CharacterWithStateCopyWith(
          _CharacterWithState value, $Res Function(_CharacterWithState) then) =
      __$CharacterWithStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {GSCharacter character,
      GOODCharacter c,
      GOODWeapon w,
      List<GOODArtifact> artifacts});

  @override
  $GSCharacterCopyWith<$Res> get character;
  @override
  $GOODCharacterCopyWith<$Res> get c;
  @override
  $GOODWeaponCopyWith<$Res> get w;
}

/// @nodoc
class __$CharacterWithStateCopyWithImpl<$Res>
    extends _$CharacterWithStateCopyWithImpl<$Res>
    implements _$CharacterWithStateCopyWith<$Res> {
  __$CharacterWithStateCopyWithImpl(
      _CharacterWithState _value, $Res Function(_CharacterWithState) _then)
      : super(_value, (v) => _then(v as _CharacterWithState));

  @override
  _CharacterWithState get _value => super._value as _CharacterWithState;

  @override
  $Res call({
    Object? character = freezed,
    Object? c = freezed,
    Object? w = freezed,
    Object? artifacts = freezed,
  }) {
    return _then(_CharacterWithState(
      character: character == freezed
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as GSCharacter,
      c: c == freezed
          ? _value.c
          : c // ignore: cast_nullable_to_non_nullable
              as GOODCharacter,
      w: w == freezed
          ? _value.w
          : w // ignore: cast_nullable_to_non_nullable
              as GOODWeapon,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as List<GOODArtifact>,
    ));
  }
}

/// @nodoc

class _$_CharacterWithState extends _CharacterWithState {
  _$_CharacterWithState(
      {required this.character,
      required this.c,
      required this.w,
      required this.artifacts})
      : super._();

  @override
  final GSCharacter character;
  @override
  final GOODCharacter c;
  @override
  final GOODWeapon w;
  @override
  final List<GOODArtifact> artifacts;

  @override
  String toString() {
    return 'CharacterWithState(character: $character, c: $c, w: $w, artifacts: $artifacts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterWithState &&
            const DeepCollectionEquality().equals(other.character, character) &&
            const DeepCollectionEquality().equals(other.c, c) &&
            const DeepCollectionEquality().equals(other.w, w) &&
            const DeepCollectionEquality().equals(other.artifacts, artifacts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(character),
      const DeepCollectionEquality().hash(c),
      const DeepCollectionEquality().hash(w),
      const DeepCollectionEquality().hash(artifacts));

  @JsonKey(ignore: true)
  @override
  _$CharacterWithStateCopyWith<_CharacterWithState> get copyWith =>
      __$CharacterWithStateCopyWithImpl<_CharacterWithState>(this, _$identity);
}

abstract class _CharacterWithState extends CharacterWithState {
  factory _CharacterWithState(
      {required GSCharacter character,
      required GOODCharacter c,
      required GOODWeapon w,
      required List<GOODArtifact> artifacts}) = _$_CharacterWithState;
  _CharacterWithState._() : super._();

  @override
  GSCharacter get character;
  @override
  GOODCharacter get c;
  @override
  GOODWeapon get w;
  @override
  List<GOODArtifact> get artifacts;
  @override
  @JsonKey(ignore: true)
  _$CharacterWithStateCopyWith<_CharacterWithState> get copyWith =>
      throw _privateConstructorUsedError;
}
