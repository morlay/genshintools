// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../artifact_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ArtifactService _$ArtifactServiceFromJson(Map<String, dynamic> json) {
  return _ArtifactService.fromJson(json);
}

/// @nodoc
class _$ArtifactServiceTearOff {
  const _$ArtifactServiceTearOff();

  _ArtifactService call(
      {Map<int, GSArtifact>? artifacts,
      Map<String, GSArtifactSet>? artifactSets,
      Map<int, List<FightProp>>? artifactMainPropDepots,
      Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots,
      List<List<int>>? artifactLevelupExps,
      List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues}) {
    return _ArtifactService(
      artifacts: artifacts,
      artifactSets: artifactSets,
      artifactMainPropDepots: artifactMainPropDepots,
      artifactAppendPropDepots: artifactAppendPropDepots,
      artifactLevelupExps: artifactLevelupExps,
      artifactLevelupMainPropValues: artifactLevelupMainPropValues,
    );
  }

  ArtifactService fromJson(Map<String, Object?> json) {
    return ArtifactService.fromJson(json);
  }
}

/// @nodoc
const $ArtifactService = _$ArtifactServiceTearOff();

/// @nodoc
mixin _$ArtifactService {
  Map<int, GSArtifact>? get artifacts => throw _privateConstructorUsedError;
  Map<String, GSArtifactSet>? get artifactSets =>
      throw _privateConstructorUsedError;
  Map<int, List<FightProp>>? get artifactMainPropDepots =>
      throw _privateConstructorUsedError;
  Map<int, GSArtifactAppendDepot>? get artifactAppendPropDepots =>
      throw _privateConstructorUsedError;
  List<List<int>>? get artifactLevelupExps =>
      throw _privateConstructorUsedError;
  List<List<Map<FightProp, double>>>? get artifactLevelupMainPropValues =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtifactServiceCopyWith<ArtifactService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtifactServiceCopyWith<$Res> {
  factory $ArtifactServiceCopyWith(
          ArtifactService value, $Res Function(ArtifactService) then) =
      _$ArtifactServiceCopyWithImpl<$Res>;
  $Res call(
      {Map<int, GSArtifact>? artifacts,
      Map<String, GSArtifactSet>? artifactSets,
      Map<int, List<FightProp>>? artifactMainPropDepots,
      Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots,
      List<List<int>>? artifactLevelupExps,
      List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues});
}

/// @nodoc
class _$ArtifactServiceCopyWithImpl<$Res>
    implements $ArtifactServiceCopyWith<$Res> {
  _$ArtifactServiceCopyWithImpl(this._value, this._then);

  final ArtifactService _value;
  // ignore: unused_field
  final $Res Function(ArtifactService) _then;

  @override
  $Res call({
    Object? artifacts = freezed,
    Object? artifactSets = freezed,
    Object? artifactMainPropDepots = freezed,
    Object? artifactAppendPropDepots = freezed,
    Object? artifactLevelupExps = freezed,
    Object? artifactLevelupMainPropValues = freezed,
  }) {
    return _then(_value.copyWith(
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as Map<int, GSArtifact>?,
      artifactSets: artifactSets == freezed
          ? _value.artifactSets
          : artifactSets // ignore: cast_nullable_to_non_nullable
              as Map<String, GSArtifactSet>?,
      artifactMainPropDepots: artifactMainPropDepots == freezed
          ? _value.artifactMainPropDepots
          : artifactMainPropDepots // ignore: cast_nullable_to_non_nullable
              as Map<int, List<FightProp>>?,
      artifactAppendPropDepots: artifactAppendPropDepots == freezed
          ? _value.artifactAppendPropDepots
          : artifactAppendPropDepots // ignore: cast_nullable_to_non_nullable
              as Map<int, GSArtifactAppendDepot>?,
      artifactLevelupExps: artifactLevelupExps == freezed
          ? _value.artifactLevelupExps
          : artifactLevelupExps // ignore: cast_nullable_to_non_nullable
              as List<List<int>>?,
      artifactLevelupMainPropValues: artifactLevelupMainPropValues == freezed
          ? _value.artifactLevelupMainPropValues
          : artifactLevelupMainPropValues // ignore: cast_nullable_to_non_nullable
              as List<List<Map<FightProp, double>>>?,
    ));
  }
}

/// @nodoc
abstract class _$ArtifactServiceCopyWith<$Res>
    implements $ArtifactServiceCopyWith<$Res> {
  factory _$ArtifactServiceCopyWith(
          _ArtifactService value, $Res Function(_ArtifactService) then) =
      __$ArtifactServiceCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<int, GSArtifact>? artifacts,
      Map<String, GSArtifactSet>? artifactSets,
      Map<int, List<FightProp>>? artifactMainPropDepots,
      Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots,
      List<List<int>>? artifactLevelupExps,
      List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues});
}

/// @nodoc
class __$ArtifactServiceCopyWithImpl<$Res>
    extends _$ArtifactServiceCopyWithImpl<$Res>
    implements _$ArtifactServiceCopyWith<$Res> {
  __$ArtifactServiceCopyWithImpl(
      _ArtifactService _value, $Res Function(_ArtifactService) _then)
      : super(_value, (v) => _then(v as _ArtifactService));

  @override
  _ArtifactService get _value => super._value as _ArtifactService;

  @override
  $Res call({
    Object? artifacts = freezed,
    Object? artifactSets = freezed,
    Object? artifactMainPropDepots = freezed,
    Object? artifactAppendPropDepots = freezed,
    Object? artifactLevelupExps = freezed,
    Object? artifactLevelupMainPropValues = freezed,
  }) {
    return _then(_ArtifactService(
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as Map<int, GSArtifact>?,
      artifactSets: artifactSets == freezed
          ? _value.artifactSets
          : artifactSets // ignore: cast_nullable_to_non_nullable
              as Map<String, GSArtifactSet>?,
      artifactMainPropDepots: artifactMainPropDepots == freezed
          ? _value.artifactMainPropDepots
          : artifactMainPropDepots // ignore: cast_nullable_to_non_nullable
              as Map<int, List<FightProp>>?,
      artifactAppendPropDepots: artifactAppendPropDepots == freezed
          ? _value.artifactAppendPropDepots
          : artifactAppendPropDepots // ignore: cast_nullable_to_non_nullable
              as Map<int, GSArtifactAppendDepot>?,
      artifactLevelupExps: artifactLevelupExps == freezed
          ? _value.artifactLevelupExps
          : artifactLevelupExps // ignore: cast_nullable_to_non_nullable
              as List<List<int>>?,
      artifactLevelupMainPropValues: artifactLevelupMainPropValues == freezed
          ? _value.artifactLevelupMainPropValues
          : artifactLevelupMainPropValues // ignore: cast_nullable_to_non_nullable
              as List<List<Map<FightProp, double>>>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
@FightPropStringConverter()
class _$_ArtifactService extends _ArtifactService {
  _$_ArtifactService(
      {this.artifacts,
      this.artifactSets,
      this.artifactMainPropDepots,
      this.artifactAppendPropDepots,
      this.artifactLevelupExps,
      this.artifactLevelupMainPropValues})
      : super._();

  factory _$_ArtifactService.fromJson(Map<String, dynamic> json) =>
      _$$_ArtifactServiceFromJson(json);

  @override
  final Map<int, GSArtifact>? artifacts;
  @override
  final Map<String, GSArtifactSet>? artifactSets;
  @override
  final Map<int, List<FightProp>>? artifactMainPropDepots;
  @override
  final Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots;
  @override
  final List<List<int>>? artifactLevelupExps;
  @override
  final List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues;

  @override
  String toString() {
    return 'ArtifactService(artifacts: $artifacts, artifactSets: $artifactSets, artifactMainPropDepots: $artifactMainPropDepots, artifactAppendPropDepots: $artifactAppendPropDepots, artifactLevelupExps: $artifactLevelupExps, artifactLevelupMainPropValues: $artifactLevelupMainPropValues)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtifactService &&
            const DeepCollectionEquality().equals(other.artifacts, artifacts) &&
            const DeepCollectionEquality()
                .equals(other.artifactSets, artifactSets) &&
            const DeepCollectionEquality()
                .equals(other.artifactMainPropDepots, artifactMainPropDepots) &&
            const DeepCollectionEquality().equals(
                other.artifactAppendPropDepots, artifactAppendPropDepots) &&
            const DeepCollectionEquality()
                .equals(other.artifactLevelupExps, artifactLevelupExps) &&
            const DeepCollectionEquality().equals(
                other.artifactLevelupMainPropValues,
                artifactLevelupMainPropValues));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(artifacts),
      const DeepCollectionEquality().hash(artifactSets),
      const DeepCollectionEquality().hash(artifactMainPropDepots),
      const DeepCollectionEquality().hash(artifactAppendPropDepots),
      const DeepCollectionEquality().hash(artifactLevelupExps),
      const DeepCollectionEquality().hash(artifactLevelupMainPropValues));

  @JsonKey(ignore: true)
  @override
  _$ArtifactServiceCopyWith<_ArtifactService> get copyWith =>
      __$ArtifactServiceCopyWithImpl<_ArtifactService>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtifactServiceToJson(this);
  }
}

abstract class _ArtifactService extends ArtifactService {
  factory _ArtifactService(
          {Map<int, GSArtifact>? artifacts,
          Map<String, GSArtifactSet>? artifactSets,
          Map<int, List<FightProp>>? artifactMainPropDepots,
          Map<int, GSArtifactAppendDepot>? artifactAppendPropDepots,
          List<List<int>>? artifactLevelupExps,
          List<List<Map<FightProp, double>>>? artifactLevelupMainPropValues}) =
      _$_ArtifactService;
  _ArtifactService._() : super._();

  factory _ArtifactService.fromJson(Map<String, dynamic> json) =
      _$_ArtifactService.fromJson;

  @override
  Map<int, GSArtifact>? get artifacts;
  @override
  Map<String, GSArtifactSet>? get artifactSets;
  @override
  Map<int, List<FightProp>>? get artifactMainPropDepots;
  @override
  Map<int, GSArtifactAppendDepot>? get artifactAppendPropDepots;
  @override
  List<List<int>>? get artifactLevelupExps;
  @override
  List<List<Map<FightProp, double>>>? get artifactLevelupMainPropValues;
  @override
  @JsonKey(ignore: true)
  _$ArtifactServiceCopyWith<_ArtifactService> get copyWith =>
      throw _privateConstructorUsedError;
}
