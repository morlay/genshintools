// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) {
  return _PlayerState.fromJson(json);
}

/// @nodoc
class _$PlayerStateTearOff {
  const _$PlayerStateTearOff();

  _PlayerState call({required Map<int, CharacterState> characters}) {
    return _PlayerState(
      characters: characters,
    );
  }

  PlayerState fromJson(Map<String, Object?> json) {
    return PlayerState.fromJson(json);
  }
}

/// @nodoc
const $PlayerState = _$PlayerStateTearOff();

/// @nodoc
mixin _$PlayerState {
  Map<int, CharacterState> get characters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerStateCopyWith<PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
          PlayerState value, $Res Function(PlayerState) then) =
      _$PlayerStateCopyWithImpl<$Res>;
  $Res call({Map<int, CharacterState> characters});
}

/// @nodoc
class _$PlayerStateCopyWithImpl<$Res> implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  final PlayerState _value;
  // ignore: unused_field
  final $Res Function(PlayerState) _then;

  @override
  $Res call({
    Object? characters = freezed,
  }) {
    return _then(_value.copyWith(
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as Map<int, CharacterState>,
    ));
  }
}

/// @nodoc
abstract class _$PlayerStateCopyWith<$Res>
    implements $PlayerStateCopyWith<$Res> {
  factory _$PlayerStateCopyWith(
          _PlayerState value, $Res Function(_PlayerState) then) =
      __$PlayerStateCopyWithImpl<$Res>;
  @override
  $Res call({Map<int, CharacterState> characters});
}

/// @nodoc
class __$PlayerStateCopyWithImpl<$Res> extends _$PlayerStateCopyWithImpl<$Res>
    implements _$PlayerStateCopyWith<$Res> {
  __$PlayerStateCopyWithImpl(
      _PlayerState _value, $Res Function(_PlayerState) _then)
      : super(_value, (v) => _then(v as _PlayerState));

  @override
  _PlayerState get _value => super._value as _PlayerState;

  @override
  $Res call({
    Object? characters = freezed,
  }) {
    return _then(_PlayerState(
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as Map<int, CharacterState>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlayerState extends _PlayerState {
  _$_PlayerState({required this.characters}) : super._();

  factory _$_PlayerState.fromJson(Map<String, dynamic> json) =>
      _$$_PlayerStateFromJson(json);

  @override
  final Map<int, CharacterState> characters;

  @override
  String toString() {
    return 'PlayerState(characters: $characters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlayerState &&
            const DeepCollectionEquality()
                .equals(other.characters, characters));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(characters));

  @JsonKey(ignore: true)
  @override
  _$PlayerStateCopyWith<_PlayerState> get copyWith =>
      __$PlayerStateCopyWithImpl<_PlayerState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlayerStateToJson(this);
  }
}

abstract class _PlayerState extends PlayerState {
  factory _PlayerState({required Map<int, CharacterState> characters}) =
      _$_PlayerState;
  _PlayerState._() : super._();

  factory _PlayerState.fromJson(Map<String, dynamic> json) =
      _$_PlayerState.fromJson;

  @override
  Map<int, CharacterState> get characters;
  @override
  @JsonKey(ignore: true)
  _$PlayerStateCopyWith<_PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterState _$CharacterStateFromJson(Map<String, dynamic> json) {
  return _CharacterState.fromJson(json);
}

/// @nodoc
class _$CharacterStateTearOff {
  const _$CharacterStateTearOff();

  _CharacterState call(
      {required int id,
      required int level,
      required int activeConstellationNum,
      required Map<SkillType, int> skillLevels,
      required bool own,
      required bool todo,
      required CharacterBuildState build,
      CharacterBuildState? defaultBuild,
      DateTime? skillLevelsLastSyncAt}) {
    return _CharacterState(
      id: id,
      level: level,
      activeConstellationNum: activeConstellationNum,
      skillLevels: skillLevels,
      own: own,
      todo: todo,
      build: build,
      defaultBuild: defaultBuild,
      skillLevelsLastSyncAt: skillLevelsLastSyncAt,
    );
  }

  CharacterState fromJson(Map<String, Object?> json) {
    return CharacterState.fromJson(json);
  }
}

/// @nodoc
const $CharacterState = _$CharacterStateTearOff();

/// @nodoc
mixin _$CharacterState {
  int get id => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get activeConstellationNum => throw _privateConstructorUsedError;
  Map<SkillType, int> get skillLevels => throw _privateConstructorUsedError;
  bool get own => throw _privateConstructorUsedError;
  bool get todo => throw _privateConstructorUsedError;
  CharacterBuildState get build => throw _privateConstructorUsedError;
  CharacterBuildState? get defaultBuild => throw _privateConstructorUsedError;
  DateTime? get skillLevelsLastSyncAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterStateCopyWith<CharacterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterStateCopyWith<$Res> {
  factory $CharacterStateCopyWith(
          CharacterState value, $Res Function(CharacterState) then) =
      _$CharacterStateCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int level,
      int activeConstellationNum,
      Map<SkillType, int> skillLevels,
      bool own,
      bool todo,
      CharacterBuildState build,
      CharacterBuildState? defaultBuild,
      DateTime? skillLevelsLastSyncAt});

  $CharacterBuildStateCopyWith<$Res> get build;
  $CharacterBuildStateCopyWith<$Res>? get defaultBuild;
}

/// @nodoc
class _$CharacterStateCopyWithImpl<$Res>
    implements $CharacterStateCopyWith<$Res> {
  _$CharacterStateCopyWithImpl(this._value, this._then);

  final CharacterState _value;
  // ignore: unused_field
  final $Res Function(CharacterState) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? activeConstellationNum = freezed,
    Object? skillLevels = freezed,
    Object? own = freezed,
    Object? todo = freezed,
    Object? build = freezed,
    Object? defaultBuild = freezed,
    Object? skillLevelsLastSyncAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      activeConstellationNum: activeConstellationNum == freezed
          ? _value.activeConstellationNum
          : activeConstellationNum // ignore: cast_nullable_to_non_nullable
              as int,
      skillLevels: skillLevels == freezed
          ? _value.skillLevels
          : skillLevels // ignore: cast_nullable_to_non_nullable
              as Map<SkillType, int>,
      own: own == freezed
          ? _value.own
          : own // ignore: cast_nullable_to_non_nullable
              as bool,
      todo: todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as bool,
      build: build == freezed
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as CharacterBuildState,
      defaultBuild: defaultBuild == freezed
          ? _value.defaultBuild
          : defaultBuild // ignore: cast_nullable_to_non_nullable
              as CharacterBuildState?,
      skillLevelsLastSyncAt: skillLevelsLastSyncAt == freezed
          ? _value.skillLevelsLastSyncAt
          : skillLevelsLastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }

  @override
  $CharacterBuildStateCopyWith<$Res> get build {
    return $CharacterBuildStateCopyWith<$Res>(_value.build, (value) {
      return _then(_value.copyWith(build: value));
    });
  }

  @override
  $CharacterBuildStateCopyWith<$Res>? get defaultBuild {
    if (_value.defaultBuild == null) {
      return null;
    }

    return $CharacterBuildStateCopyWith<$Res>(_value.defaultBuild!, (value) {
      return _then(_value.copyWith(defaultBuild: value));
    });
  }
}

/// @nodoc
abstract class _$CharacterStateCopyWith<$Res>
    implements $CharacterStateCopyWith<$Res> {
  factory _$CharacterStateCopyWith(
          _CharacterState value, $Res Function(_CharacterState) then) =
      __$CharacterStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int level,
      int activeConstellationNum,
      Map<SkillType, int> skillLevels,
      bool own,
      bool todo,
      CharacterBuildState build,
      CharacterBuildState? defaultBuild,
      DateTime? skillLevelsLastSyncAt});

  @override
  $CharacterBuildStateCopyWith<$Res> get build;
  @override
  $CharacterBuildStateCopyWith<$Res>? get defaultBuild;
}

/// @nodoc
class __$CharacterStateCopyWithImpl<$Res>
    extends _$CharacterStateCopyWithImpl<$Res>
    implements _$CharacterStateCopyWith<$Res> {
  __$CharacterStateCopyWithImpl(
      _CharacterState _value, $Res Function(_CharacterState) _then)
      : super(_value, (v) => _then(v as _CharacterState));

  @override
  _CharacterState get _value => super._value as _CharacterState;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? activeConstellationNum = freezed,
    Object? skillLevels = freezed,
    Object? own = freezed,
    Object? todo = freezed,
    Object? build = freezed,
    Object? defaultBuild = freezed,
    Object? skillLevelsLastSyncAt = freezed,
  }) {
    return _then(_CharacterState(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      activeConstellationNum: activeConstellationNum == freezed
          ? _value.activeConstellationNum
          : activeConstellationNum // ignore: cast_nullable_to_non_nullable
              as int,
      skillLevels: skillLevels == freezed
          ? _value.skillLevels
          : skillLevels // ignore: cast_nullable_to_non_nullable
              as Map<SkillType, int>,
      own: own == freezed
          ? _value.own
          : own // ignore: cast_nullable_to_non_nullable
              as bool,
      todo: todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as bool,
      build: build == freezed
          ? _value.build
          : build // ignore: cast_nullable_to_non_nullable
              as CharacterBuildState,
      defaultBuild: defaultBuild == freezed
          ? _value.defaultBuild
          : defaultBuild // ignore: cast_nullable_to_non_nullable
              as CharacterBuildState?,
      skillLevelsLastSyncAt: skillLevelsLastSyncAt == freezed
          ? _value.skillLevelsLastSyncAt
          : skillLevelsLastSyncAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharacterState extends _CharacterState {
  _$_CharacterState(
      {required this.id,
      required this.level,
      required this.activeConstellationNum,
      required this.skillLevels,
      required this.own,
      required this.todo,
      required this.build,
      this.defaultBuild,
      this.skillLevelsLastSyncAt})
      : super._();

  factory _$_CharacterState.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterStateFromJson(json);

  @override
  final int id;
  @override
  final int level;
  @override
  final int activeConstellationNum;
  @override
  final Map<SkillType, int> skillLevels;
  @override
  final bool own;
  @override
  final bool todo;
  @override
  final CharacterBuildState build;
  @override
  final CharacterBuildState? defaultBuild;
  @override
  final DateTime? skillLevelsLastSyncAt;

  @override
  String toString() {
    return 'CharacterState(id: $id, level: $level, activeConstellationNum: $activeConstellationNum, skillLevels: $skillLevels, own: $own, todo: $todo, build: $build, defaultBuild: $defaultBuild, skillLevelsLastSyncAt: $skillLevelsLastSyncAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterState &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality()
                .equals(other.activeConstellationNum, activeConstellationNum) &&
            const DeepCollectionEquality()
                .equals(other.skillLevels, skillLevels) &&
            const DeepCollectionEquality().equals(other.own, own) &&
            const DeepCollectionEquality().equals(other.todo, todo) &&
            const DeepCollectionEquality().equals(other.build, build) &&
            const DeepCollectionEquality()
                .equals(other.defaultBuild, defaultBuild) &&
            const DeepCollectionEquality()
                .equals(other.skillLevelsLastSyncAt, skillLevelsLastSyncAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(activeConstellationNum),
      const DeepCollectionEquality().hash(skillLevels),
      const DeepCollectionEquality().hash(own),
      const DeepCollectionEquality().hash(todo),
      const DeepCollectionEquality().hash(build),
      const DeepCollectionEquality().hash(defaultBuild),
      const DeepCollectionEquality().hash(skillLevelsLastSyncAt));

  @JsonKey(ignore: true)
  @override
  _$CharacterStateCopyWith<_CharacterState> get copyWith =>
      __$CharacterStateCopyWithImpl<_CharacterState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterStateToJson(this);
  }
}

abstract class _CharacterState extends CharacterState {
  factory _CharacterState(
      {required int id,
      required int level,
      required int activeConstellationNum,
      required Map<SkillType, int> skillLevels,
      required bool own,
      required bool todo,
      required CharacterBuildState build,
      CharacterBuildState? defaultBuild,
      DateTime? skillLevelsLastSyncAt}) = _$_CharacterState;
  _CharacterState._() : super._();

  factory _CharacterState.fromJson(Map<String, dynamic> json) =
      _$_CharacterState.fromJson;

  @override
  int get id;
  @override
  int get level;
  @override
  int get activeConstellationNum;
  @override
  Map<SkillType, int> get skillLevels;
  @override
  bool get own;
  @override
  bool get todo;
  @override
  CharacterBuildState get build;
  @override
  CharacterBuildState? get defaultBuild;
  @override
  DateTime? get skillLevelsLastSyncAt;
  @override
  @JsonKey(ignore: true)
  _$CharacterStateCopyWith<_CharacterState> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterBuildState _$CharacterBuildStateFromJson(Map<String, dynamic> json) {
  return _CharacterBuildState.fromJson(json);
}

/// @nodoc
class _$CharacterBuildStateTearOff {
  const _$CharacterBuildStateTearOff();

  _CharacterBuildState call(
      {required int weaponID,
      required int weaponLevel,
      required int weaponAffixLevel,
      required Map<EquipType, PlayerArtifact> artifacts}) {
    return _CharacterBuildState(
      weaponID: weaponID,
      weaponLevel: weaponLevel,
      weaponAffixLevel: weaponAffixLevel,
      artifacts: artifacts,
    );
  }

  CharacterBuildState fromJson(Map<String, Object?> json) {
    return CharacterBuildState.fromJson(json);
  }
}

/// @nodoc
const $CharacterBuildState = _$CharacterBuildStateTearOff();

/// @nodoc
mixin _$CharacterBuildState {
  int get weaponID => throw _privateConstructorUsedError;
  int get weaponLevel => throw _privateConstructorUsedError;
  int get weaponAffixLevel => throw _privateConstructorUsedError;
  Map<EquipType, PlayerArtifact> get artifacts =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterBuildStateCopyWith<CharacterBuildState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterBuildStateCopyWith<$Res> {
  factory $CharacterBuildStateCopyWith(
          CharacterBuildState value, $Res Function(CharacterBuildState) then) =
      _$CharacterBuildStateCopyWithImpl<$Res>;
  $Res call(
      {int weaponID,
      int weaponLevel,
      int weaponAffixLevel,
      Map<EquipType, PlayerArtifact> artifacts});
}

/// @nodoc
class _$CharacterBuildStateCopyWithImpl<$Res>
    implements $CharacterBuildStateCopyWith<$Res> {
  _$CharacterBuildStateCopyWithImpl(this._value, this._then);

  final CharacterBuildState _value;
  // ignore: unused_field
  final $Res Function(CharacterBuildState) _then;

  @override
  $Res call({
    Object? weaponID = freezed,
    Object? weaponLevel = freezed,
    Object? weaponAffixLevel = freezed,
    Object? artifacts = freezed,
  }) {
    return _then(_value.copyWith(
      weaponID: weaponID == freezed
          ? _value.weaponID
          : weaponID // ignore: cast_nullable_to_non_nullable
              as int,
      weaponLevel: weaponLevel == freezed
          ? _value.weaponLevel
          : weaponLevel // ignore: cast_nullable_to_non_nullable
              as int,
      weaponAffixLevel: weaponAffixLevel == freezed
          ? _value.weaponAffixLevel
          : weaponAffixLevel // ignore: cast_nullable_to_non_nullable
              as int,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as Map<EquipType, PlayerArtifact>,
    ));
  }
}

/// @nodoc
abstract class _$CharacterBuildStateCopyWith<$Res>
    implements $CharacterBuildStateCopyWith<$Res> {
  factory _$CharacterBuildStateCopyWith(_CharacterBuildState value,
          $Res Function(_CharacterBuildState) then) =
      __$CharacterBuildStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int weaponID,
      int weaponLevel,
      int weaponAffixLevel,
      Map<EquipType, PlayerArtifact> artifacts});
}

/// @nodoc
class __$CharacterBuildStateCopyWithImpl<$Res>
    extends _$CharacterBuildStateCopyWithImpl<$Res>
    implements _$CharacterBuildStateCopyWith<$Res> {
  __$CharacterBuildStateCopyWithImpl(
      _CharacterBuildState _value, $Res Function(_CharacterBuildState) _then)
      : super(_value, (v) => _then(v as _CharacterBuildState));

  @override
  _CharacterBuildState get _value => super._value as _CharacterBuildState;

  @override
  $Res call({
    Object? weaponID = freezed,
    Object? weaponLevel = freezed,
    Object? weaponAffixLevel = freezed,
    Object? artifacts = freezed,
  }) {
    return _then(_CharacterBuildState(
      weaponID: weaponID == freezed
          ? _value.weaponID
          : weaponID // ignore: cast_nullable_to_non_nullable
              as int,
      weaponLevel: weaponLevel == freezed
          ? _value.weaponLevel
          : weaponLevel // ignore: cast_nullable_to_non_nullable
              as int,
      weaponAffixLevel: weaponAffixLevel == freezed
          ? _value.weaponAffixLevel
          : weaponAffixLevel // ignore: cast_nullable_to_non_nullable
              as int,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as Map<EquipType, PlayerArtifact>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CharacterBuildState extends _CharacterBuildState {
  _$_CharacterBuildState(
      {required this.weaponID,
      required this.weaponLevel,
      required this.weaponAffixLevel,
      required this.artifacts})
      : super._();

  factory _$_CharacterBuildState.fromJson(Map<String, dynamic> json) =>
      _$$_CharacterBuildStateFromJson(json);

  @override
  final int weaponID;
  @override
  final int weaponLevel;
  @override
  final int weaponAffixLevel;
  @override
  final Map<EquipType, PlayerArtifact> artifacts;

  @override
  String toString() {
    return 'CharacterBuildState(weaponID: $weaponID, weaponLevel: $weaponLevel, weaponAffixLevel: $weaponAffixLevel, artifacts: $artifacts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterBuildState &&
            const DeepCollectionEquality().equals(other.weaponID, weaponID) &&
            const DeepCollectionEquality()
                .equals(other.weaponLevel, weaponLevel) &&
            const DeepCollectionEquality()
                .equals(other.weaponAffixLevel, weaponAffixLevel) &&
            const DeepCollectionEquality().equals(other.artifacts, artifacts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(weaponID),
      const DeepCollectionEquality().hash(weaponLevel),
      const DeepCollectionEquality().hash(weaponAffixLevel),
      const DeepCollectionEquality().hash(artifacts));

  @JsonKey(ignore: true)
  @override
  _$CharacterBuildStateCopyWith<_CharacterBuildState> get copyWith =>
      __$CharacterBuildStateCopyWithImpl<_CharacterBuildState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CharacterBuildStateToJson(this);
  }
}

abstract class _CharacterBuildState extends CharacterBuildState {
  factory _CharacterBuildState(
          {required int weaponID,
          required int weaponLevel,
          required int weaponAffixLevel,
          required Map<EquipType, PlayerArtifact> artifacts}) =
      _$_CharacterBuildState;
  _CharacterBuildState._() : super._();

  factory _CharacterBuildState.fromJson(Map<String, dynamic> json) =
      _$_CharacterBuildState.fromJson;

  @override
  int get weaponID;
  @override
  int get weaponLevel;
  @override
  int get weaponAffixLevel;
  @override
  Map<EquipType, PlayerArtifact> get artifacts;
  @override
  @JsonKey(ignore: true)
  _$CharacterBuildStateCopyWith<_CharacterBuildState> get copyWith =>
      throw _privateConstructorUsedError;
}
