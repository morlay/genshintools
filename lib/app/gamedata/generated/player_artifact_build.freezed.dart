// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../player_artifact_build.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PlayerArtifactBuildTearOff {
  const _$PlayerArtifactBuildTearOff();

  _PlayerArtifactBuild call({required HashMap<PlayerArtifact, int> builds}) {
    return _PlayerArtifactBuild(
      builds: builds,
    );
  }
}

/// @nodoc
const $PlayerArtifactBuild = _$PlayerArtifactBuildTearOff();

/// @nodoc
mixin _$PlayerArtifactBuild {
  HashMap<PlayerArtifact, int> get builds => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayerArtifactBuildCopyWith<PlayerArtifactBuild> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerArtifactBuildCopyWith<$Res> {
  factory $PlayerArtifactBuildCopyWith(
          PlayerArtifactBuild value, $Res Function(PlayerArtifactBuild) then) =
      _$PlayerArtifactBuildCopyWithImpl<$Res>;
  $Res call({HashMap<PlayerArtifact, int> builds});
}

/// @nodoc
class _$PlayerArtifactBuildCopyWithImpl<$Res>
    implements $PlayerArtifactBuildCopyWith<$Res> {
  _$PlayerArtifactBuildCopyWithImpl(this._value, this._then);

  final PlayerArtifactBuild _value;
  // ignore: unused_field
  final $Res Function(PlayerArtifactBuild) _then;

  @override
  $Res call({
    Object? builds = freezed,
  }) {
    return _then(_value.copyWith(
      builds: builds == freezed
          ? _value.builds
          : builds // ignore: cast_nullable_to_non_nullable
              as HashMap<PlayerArtifact, int>,
    ));
  }
}

/// @nodoc
abstract class _$PlayerArtifactBuildCopyWith<$Res>
    implements $PlayerArtifactBuildCopyWith<$Res> {
  factory _$PlayerArtifactBuildCopyWith(_PlayerArtifactBuild value,
          $Res Function(_PlayerArtifactBuild) then) =
      __$PlayerArtifactBuildCopyWithImpl<$Res>;
  @override
  $Res call({HashMap<PlayerArtifact, int> builds});
}

/// @nodoc
class __$PlayerArtifactBuildCopyWithImpl<$Res>
    extends _$PlayerArtifactBuildCopyWithImpl<$Res>
    implements _$PlayerArtifactBuildCopyWith<$Res> {
  __$PlayerArtifactBuildCopyWithImpl(
      _PlayerArtifactBuild _value, $Res Function(_PlayerArtifactBuild) _then)
      : super(_value, (v) => _then(v as _PlayerArtifactBuild));

  @override
  _PlayerArtifactBuild get _value => super._value as _PlayerArtifactBuild;

  @override
  $Res call({
    Object? builds = freezed,
  }) {
    return _then(_PlayerArtifactBuild(
      builds: builds == freezed
          ? _value.builds
          : builds // ignore: cast_nullable_to_non_nullable
              as HashMap<PlayerArtifact, int>,
    ));
  }
}

/// @nodoc

class _$_PlayerArtifactBuild extends _PlayerArtifactBuild {
  _$_PlayerArtifactBuild({required this.builds}) : super._();

  @override
  final HashMap<PlayerArtifact, int> builds;

  @override
  String toString() {
    return 'PlayerArtifactBuild(builds: $builds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlayerArtifactBuild &&
            const DeepCollectionEquality().equals(other.builds, builds));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(builds));

  @JsonKey(ignore: true)
  @override
  _$PlayerArtifactBuildCopyWith<_PlayerArtifactBuild> get copyWith =>
      __$PlayerArtifactBuildCopyWithImpl<_PlayerArtifactBuild>(
          this, _$identity);
}

abstract class _PlayerArtifactBuild extends PlayerArtifactBuild {
  factory _PlayerArtifactBuild({required HashMap<PlayerArtifact, int> builds}) =
      _$_PlayerArtifactBuild;
  _PlayerArtifactBuild._() : super._();

  @override
  HashMap<PlayerArtifact, int> get builds;
  @override
  @JsonKey(ignore: true)
  _$PlayerArtifactBuildCopyWith<_PlayerArtifactBuild> get copyWith =>
      throw _privateConstructorUsedError;
}
