// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../game_role.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GameRole _$GameRoleFromJson(Map<String, dynamic> json) {
  return _GameRole.fromJson(json);
}

/// @nodoc
class _$GameRoleTearOff {
  const _$GameRoleTearOff();

  _GameRole call(
      {required String gameBiz,
      required String gameUid,
      required String regionName,
      required bool isChosen,
      required String region,
      required String nickname,
      required int level}) {
    return _GameRole(
      gameBiz: gameBiz,
      gameUid: gameUid,
      regionName: regionName,
      isChosen: isChosen,
      region: region,
      nickname: nickname,
      level: level,
    );
  }

  GameRole fromJson(Map<String, Object?> json) {
    return GameRole.fromJson(json);
  }
}

/// @nodoc
const $GameRole = _$GameRoleTearOff();

/// @nodoc
mixin _$GameRole {
  String get gameBiz => throw _privateConstructorUsedError;
  String get gameUid => throw _privateConstructorUsedError;
  String get regionName => throw _privateConstructorUsedError;
  bool get isChosen => throw _privateConstructorUsedError;
  String get region => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameRoleCopyWith<GameRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameRoleCopyWith<$Res> {
  factory $GameRoleCopyWith(GameRole value, $Res Function(GameRole) then) =
      _$GameRoleCopyWithImpl<$Res>;
  $Res call(
      {String gameBiz,
      String gameUid,
      String regionName,
      bool isChosen,
      String region,
      String nickname,
      int level});
}

/// @nodoc
class _$GameRoleCopyWithImpl<$Res> implements $GameRoleCopyWith<$Res> {
  _$GameRoleCopyWithImpl(this._value, this._then);

  final GameRole _value;
  // ignore: unused_field
  final $Res Function(GameRole) _then;

  @override
  $Res call({
    Object? gameBiz = freezed,
    Object? gameUid = freezed,
    Object? regionName = freezed,
    Object? isChosen = freezed,
    Object? region = freezed,
    Object? nickname = freezed,
    Object? level = freezed,
  }) {
    return _then(_value.copyWith(
      gameBiz: gameBiz == freezed
          ? _value.gameBiz
          : gameBiz // ignore: cast_nullable_to_non_nullable
              as String,
      gameUid: gameUid == freezed
          ? _value.gameUid
          : gameUid // ignore: cast_nullable_to_non_nullable
              as String,
      regionName: regionName == freezed
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String,
      isChosen: isChosen == freezed
          ? _value.isChosen
          : isChosen // ignore: cast_nullable_to_non_nullable
              as bool,
      region: region == freezed
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$GameRoleCopyWith<$Res> implements $GameRoleCopyWith<$Res> {
  factory _$GameRoleCopyWith(_GameRole value, $Res Function(_GameRole) then) =
      __$GameRoleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String gameBiz,
      String gameUid,
      String regionName,
      bool isChosen,
      String region,
      String nickname,
      int level});
}

/// @nodoc
class __$GameRoleCopyWithImpl<$Res> extends _$GameRoleCopyWithImpl<$Res>
    implements _$GameRoleCopyWith<$Res> {
  __$GameRoleCopyWithImpl(_GameRole _value, $Res Function(_GameRole) _then)
      : super(_value, (v) => _then(v as _GameRole));

  @override
  _GameRole get _value => super._value as _GameRole;

  @override
  $Res call({
    Object? gameBiz = freezed,
    Object? gameUid = freezed,
    Object? regionName = freezed,
    Object? isChosen = freezed,
    Object? region = freezed,
    Object? nickname = freezed,
    Object? level = freezed,
  }) {
    return _then(_GameRole(
      gameBiz: gameBiz == freezed
          ? _value.gameBiz
          : gameBiz // ignore: cast_nullable_to_non_nullable
              as String,
      gameUid: gameUid == freezed
          ? _value.gameUid
          : gameUid // ignore: cast_nullable_to_non_nullable
              as String,
      regionName: regionName == freezed
          ? _value.regionName
          : regionName // ignore: cast_nullable_to_non_nullable
              as String,
      isChosen: isChosen == freezed
          ? _value.isChosen
          : isChosen // ignore: cast_nullable_to_non_nullable
              as bool,
      region: region == freezed
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_GameRole extends _GameRole {
  _$_GameRole(
      {required this.gameBiz,
      required this.gameUid,
      required this.regionName,
      required this.isChosen,
      required this.region,
      required this.nickname,
      required this.level})
      : super._();

  factory _$_GameRole.fromJson(Map<String, dynamic> json) =>
      _$$_GameRoleFromJson(json);

  @override
  final String gameBiz;
  @override
  final String gameUid;
  @override
  final String regionName;
  @override
  final bool isChosen;
  @override
  final String region;
  @override
  final String nickname;
  @override
  final int level;

  @override
  String toString() {
    return 'GameRole(gameBiz: $gameBiz, gameUid: $gameUid, regionName: $regionName, isChosen: $isChosen, region: $region, nickname: $nickname, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameRole &&
            const DeepCollectionEquality().equals(other.gameBiz, gameBiz) &&
            const DeepCollectionEquality().equals(other.gameUid, gameUid) &&
            const DeepCollectionEquality()
                .equals(other.regionName, regionName) &&
            const DeepCollectionEquality().equals(other.isChosen, isChosen) &&
            const DeepCollectionEquality().equals(other.region, region) &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.level, level));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(gameBiz),
      const DeepCollectionEquality().hash(gameUid),
      const DeepCollectionEquality().hash(regionName),
      const DeepCollectionEquality().hash(isChosen),
      const DeepCollectionEquality().hash(region),
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(level));

  @JsonKey(ignore: true)
  @override
  _$GameRoleCopyWith<_GameRole> get copyWith =>
      __$GameRoleCopyWithImpl<_GameRole>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GameRoleToJson(this);
  }
}

abstract class _GameRole extends GameRole {
  factory _GameRole(
      {required String gameBiz,
      required String gameUid,
      required String regionName,
      required bool isChosen,
      required String region,
      required String nickname,
      required int level}) = _$_GameRole;
  _GameRole._() : super._();

  factory _GameRole.fromJson(Map<String, dynamic> json) = _$_GameRole.fromJson;

  @override
  String get gameBiz;
  @override
  String get gameUid;
  @override
  String get regionName;
  @override
  bool get isChosen;
  @override
  String get region;
  @override
  String get nickname;
  @override
  int get level;
  @override
  @JsonKey(ignore: true)
  _$GameRoleCopyWith<_GameRole> get copyWith =>
      throw _privateConstructorUsedError;
}
