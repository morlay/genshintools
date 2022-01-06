// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../character_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CharacterService _$CharacterServiceFromJson(Map<String, dynamic> json) {
  return _CharacterService.fromJson(json);
}

/// @nodoc
class _$CharacterServiceTearOff {
  const _$CharacterServiceTearOff();

  _CharacterService call(
      {Map<String, GSCharacter>? characters,
      List<int>? characterLevelupExps,
      GSPromoteSet? characterPromotes,
      PropGrowCurveValueSet? characterPropGrowCurveValues}) {
    return _CharacterService(
      characters: characters,
      characterLevelupExps: characterLevelupExps,
      characterPromotes: characterPromotes,
      characterPropGrowCurveValues: characterPropGrowCurveValues,
    );
  }

  CharacterService fromJson(Map<String, Object?> json) {
    return CharacterService.fromJson(json);
  }
}

/// @nodoc
const $CharacterService = _$CharacterServiceTearOff();

/// @nodoc
mixin _$CharacterService {
  Map<String, GSCharacter>? get characters =>
      throw _privateConstructorUsedError;
  List<int>? get characterLevelupExps => throw _privateConstructorUsedError;
  GSPromoteSet? get characterPromotes => throw _privateConstructorUsedError;
  PropGrowCurveValueSet? get characterPropGrowCurveValues =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterServiceCopyWith<CharacterService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterServiceCopyWith<$Res> {
  factory $CharacterServiceCopyWith(
          CharacterService value, $Res Function(CharacterService) then) =
      _$CharacterServiceCopyWithImpl<$Res>;
  $Res call(
      {Map<String, GSCharacter>? characters,
      List<int>? characterLevelupExps,
      GSPromoteSet? characterPromotes,
      PropGrowCurveValueSet? characterPropGrowCurveValues});

  $GSPromoteSetCopyWith<$Res>? get characterPromotes;
  $PropGrowCurveValueSetCopyWith<$Res>? get characterPropGrowCurveValues;
}

/// @nodoc
class _$CharacterServiceCopyWithImpl<$Res>
    implements $CharacterServiceCopyWith<$Res> {
  _$CharacterServiceCopyWithImpl(this._value, this._then);

  final CharacterService _value;
  // ignore: unused_field
  final $Res Function(CharacterService) _then;

  @override
  $Res call({
    Object? characters = freezed,
    Object? characterLevelupExps = freezed,
    Object? characterPromotes = freezed,
    Object? characterPropGrowCurveValues = freezed,
  }) {
    return _then(_value.copyWith(
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as Map<String, GSCharacter>?,
      characterLevelupExps: characterLevelupExps == freezed
          ? _value.characterLevelupExps
          : characterLevelupExps // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      characterPromotes: characterPromotes == freezed
          ? _value.characterPromotes
          : characterPromotes // ignore: cast_nullable_to_non_nullable
              as GSPromoteSet?,
      characterPropGrowCurveValues: characterPropGrowCurveValues == freezed
          ? _value.characterPropGrowCurveValues
          : characterPropGrowCurveValues // ignore: cast_nullable_to_non_nullable
              as PropGrowCurveValueSet?,
    ));
  }

  @override
  $GSPromoteSetCopyWith<$Res>? get characterPromotes {
    if (_value.characterPromotes == null) {
      return null;
    }

    return $GSPromoteSetCopyWith<$Res>(_value.characterPromotes!, (value) {
      return _then(_value.copyWith(characterPromotes: value));
    });
  }

  @override
  $PropGrowCurveValueSetCopyWith<$Res>? get characterPropGrowCurveValues {
    if (_value.characterPropGrowCurveValues == null) {
      return null;
    }

    return $PropGrowCurveValueSetCopyWith<$Res>(
        _value.characterPropGrowCurveValues!, (value) {
      return _then(_value.copyWith(characterPropGrowCurveValues: value));
    });
  }
}

/// @nodoc
abstract class _$CharacterServiceCopyWith<$Res>
    implements $CharacterServiceCopyWith<$Res> {
  factory _$CharacterServiceCopyWith(
          _CharacterService value, $Res Function(_CharacterService) then) =
      __$CharacterServiceCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, GSCharacter>? characters,
      List<int>? characterLevelupExps,
      GSPromoteSet? characterPromotes,
      PropGrowCurveValueSet? characterPropGrowCurveValues});

  @override
  $GSPromoteSetCopyWith<$Res>? get characterPromotes;
  @override
  $PropGrowCurveValueSetCopyWith<$Res>? get characterPropGrowCurveValues;
}

/// @nodoc
class __$CharacterServiceCopyWithImpl<$Res>
    extends _$CharacterServiceCopyWithImpl<$Res>
    implements _$CharacterServiceCopyWith<$Res> {
  __$CharacterServiceCopyWithImpl(
      _CharacterService _value, $Res Function(_CharacterService) _then)
      : super(_value, (v) => _then(v as _CharacterService));

  @override
  _CharacterService get _value => super._value as _CharacterService;

  @override
  $Res call({
    Object? characters = freezed,
    Object? characterLevelupExps = freezed,
    Object? characterPromotes = freezed,
    Object? characterPropGrowCurveValues = freezed,
  }) {
    return _then(_CharacterService(
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as Map<String, GSCharacter>?,
      characterLevelupExps: characterLevelupExps == freezed
          ? _value.characterLevelupExps
          : characterLevelupExps // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      characterPromotes: characterPromotes == freezed
          ? _value.characterPromotes
          : characterPromotes // ignore: cast_nullable_to_non_nullable
              as GSPromoteSet?,
      characterPropGrowCurveValues: characterPropGrowCurveValues == freezed
          ? _value.characterPropGrowCurveValues
          : characterPropGrowCurveValues // ignore: cast_nullable_to_non_nullable
              as PropGrowCurveValueSet?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_CharacterService extends _CharacterService {
  _$_CharacterService(
      {this.characters,
      this.characterLevelupExps,
      this.characterPromotes,
      this.characterPropGrowCurveValues})
      : super._();

  factory _$_CharacterService.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterServiceFromJson(json);

  @override
  final Map<String, GSCharacter>? characters;
  @override
  final List<int>? characterLevelupExps;
  @override
  final GSPromoteSet? characterPromotes;
  @override
  final PropGrowCurveValueSet? characterPropGrowCurveValues;

  @override
  String toString() {
    return 'CharacterService(characters: $characters, characterLevelupExps: $characterLevelupExps, characterPromotes: $characterPromotes, characterPropGrowCurveValues: $characterPropGrowCurveValues)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterService &&
            const DeepCollectionEquality()
                .equals(other.characters, characters) &&
            const DeepCollectionEquality()
                .equals(other.characterLevelupExps, characterLevelupExps) &&
            const DeepCollectionEquality()
                .equals(other.characterPromotes, characterPromotes) &&
            const DeepCollectionEquality().equals(
                other.characterPropGrowCurveValues,
                characterPropGrowCurveValues));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(characters),
      const DeepCollectionEquality().hash(characterLevelupExps),
      const DeepCollectionEquality().hash(characterPromotes),
      const DeepCollectionEquality().hash(characterPropGrowCurveValues));

  @JsonKey(ignore: true)
  @override
  _$CharacterServiceCopyWith<_CharacterService> get copyWith =>
      __$CharacterServiceCopyWithImpl<_CharacterService>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterServiceToJson(this);
  }
}

abstract class _CharacterService extends CharacterService {
  factory _CharacterService(
          {Map<String, GSCharacter>? characters,
          List<int>? characterLevelupExps,
          GSPromoteSet? characterPromotes,
          PropGrowCurveValueSet? characterPropGrowCurveValues}) =
      _$_CharacterService;
  _CharacterService._() : super._();

  factory _CharacterService.fromJson(Map<String, dynamic> json) =
      _$_CharacterService.fromJson;

  @override
  Map<String, GSCharacter>? get characters;
  @override
  List<int>? get characterLevelupExps;
  @override
  GSPromoteSet? get characterPromotes;
  @override
  PropGrowCurveValueSet? get characterPropGrowCurveValues;
  @override
  @JsonKey(ignore: true)
  _$CharacterServiceCopyWith<_CharacterService> get copyWith =>
      throw _privateConstructorUsedError;
}
