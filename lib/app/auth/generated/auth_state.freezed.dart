// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthStateV1 _$AuthStateV1FromJson(Map<String, dynamic> json) {
  return _AuthStateV1.fromJson(json);
}

/// @nodoc
class _$AuthStateV1TearOff {
  const _$AuthStateV1TearOff();

  _AuthStateV1 call(
      {required String encodedCookie, List<GameRole> gameRoles = const []}) {
    return _AuthStateV1(
      encodedCookie: encodedCookie,
      gameRoles: gameRoles,
    );
  }

  AuthStateV1 fromJson(Map<String, Object?> json) {
    return AuthStateV1.fromJson(json);
  }
}

/// @nodoc
const $AuthStateV1 = _$AuthStateV1TearOff();

/// @nodoc
mixin _$AuthStateV1 {
  String get encodedCookie => throw _privateConstructorUsedError;
  List<GameRole> get gameRoles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthStateV1CopyWith<AuthStateV1> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateV1CopyWith<$Res> {
  factory $AuthStateV1CopyWith(
          AuthStateV1 value, $Res Function(AuthStateV1) then) =
      _$AuthStateV1CopyWithImpl<$Res>;
  $Res call({String encodedCookie, List<GameRole> gameRoles});
}

/// @nodoc
class _$AuthStateV1CopyWithImpl<$Res> implements $AuthStateV1CopyWith<$Res> {
  _$AuthStateV1CopyWithImpl(this._value, this._then);

  final AuthStateV1 _value;
  // ignore: unused_field
  final $Res Function(AuthStateV1) _then;

  @override
  $Res call({
    Object? encodedCookie = freezed,
    Object? gameRoles = freezed,
  }) {
    return _then(_value.copyWith(
      encodedCookie: encodedCookie == freezed
          ? _value.encodedCookie
          : encodedCookie // ignore: cast_nullable_to_non_nullable
              as String,
      gameRoles: gameRoles == freezed
          ? _value.gameRoles
          : gameRoles // ignore: cast_nullable_to_non_nullable
              as List<GameRole>,
    ));
  }
}

/// @nodoc
abstract class _$AuthStateV1CopyWith<$Res>
    implements $AuthStateV1CopyWith<$Res> {
  factory _$AuthStateV1CopyWith(
          _AuthStateV1 value, $Res Function(_AuthStateV1) then) =
      __$AuthStateV1CopyWithImpl<$Res>;
  @override
  $Res call({String encodedCookie, List<GameRole> gameRoles});
}

/// @nodoc
class __$AuthStateV1CopyWithImpl<$Res> extends _$AuthStateV1CopyWithImpl<$Res>
    implements _$AuthStateV1CopyWith<$Res> {
  __$AuthStateV1CopyWithImpl(
      _AuthStateV1 _value, $Res Function(_AuthStateV1) _then)
      : super(_value, (v) => _then(v as _AuthStateV1));

  @override
  _AuthStateV1 get _value => super._value as _AuthStateV1;

  @override
  $Res call({
    Object? encodedCookie = freezed,
    Object? gameRoles = freezed,
  }) {
    return _then(_AuthStateV1(
      encodedCookie: encodedCookie == freezed
          ? _value.encodedCookie
          : encodedCookie // ignore: cast_nullable_to_non_nullable
              as String,
      gameRoles: gameRoles == freezed
          ? _value.gameRoles
          : gameRoles // ignore: cast_nullable_to_non_nullable
              as List<GameRole>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthStateV1 extends _AuthStateV1 with DiagnosticableTreeMixin {
  _$_AuthStateV1({required this.encodedCookie, this.gameRoles = const []})
      : super._();

  factory _$_AuthStateV1.fromJson(Map<String, dynamic> json) =>
      _$$_AuthStateV1FromJson(json);

  @override
  final String encodedCookie;
  @JsonKey()
  @override
  final List<GameRole> gameRoles;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthStateV1(encodedCookie: $encodedCookie, gameRoles: $gameRoles)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthStateV1'))
      ..add(DiagnosticsProperty('encodedCookie', encodedCookie))
      ..add(DiagnosticsProperty('gameRoles', gameRoles));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthStateV1 &&
            const DeepCollectionEquality()
                .equals(other.encodedCookie, encodedCookie) &&
            const DeepCollectionEquality().equals(other.gameRoles, gameRoles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(encodedCookie),
      const DeepCollectionEquality().hash(gameRoles));

  @JsonKey(ignore: true)
  @override
  _$AuthStateV1CopyWith<_AuthStateV1> get copyWith =>
      __$AuthStateV1CopyWithImpl<_AuthStateV1>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthStateV1ToJson(this);
  }
}

abstract class _AuthStateV1 extends AuthStateV1 {
  factory _AuthStateV1(
      {required String encodedCookie,
      List<GameRole> gameRoles}) = _$_AuthStateV1;
  _AuthStateV1._() : super._();

  factory _AuthStateV1.fromJson(Map<String, dynamic> json) =
      _$_AuthStateV1.fromJson;

  @override
  String get encodedCookie;
  @override
  List<GameRole> get gameRoles;
  @override
  @JsonKey(ignore: true)
  _$AuthStateV1CopyWith<_AuthStateV1> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthState _$AuthStateFromJson(Map<String, dynamic> json) {
  return _AuthState.fromJson(json);
}

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  _AuthState call(
      {required String currentUID,
      Map<String, String> cookies = const {},
      Map<String, GameRole> roles = const {},
      String? channel}) {
    return _AuthState(
      currentUID: currentUID,
      cookies: cookies,
      roles: roles,
      channel: channel,
    );
  }

  AuthState fromJson(Map<String, Object?> json) {
    return AuthState.fromJson(json);
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  String get currentUID => throw _privateConstructorUsedError;
  Map<String, String> get cookies => throw _privateConstructorUsedError;
  Map<String, GameRole> get roles => throw _privateConstructorUsedError;
  String? get channel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
  $Res call(
      {String currentUID,
      Map<String, String> cookies,
      Map<String, GameRole> roles,
      String? channel});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;

  @override
  $Res call({
    Object? currentUID = freezed,
    Object? cookies = freezed,
    Object? roles = freezed,
    Object? channel = freezed,
  }) {
    return _then(_value.copyWith(
      currentUID: currentUID == freezed
          ? _value.currentUID
          : currentUID // ignore: cast_nullable_to_non_nullable
              as String,
      cookies: cookies == freezed
          ? _value.cookies
          : cookies // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as Map<String, GameRole>,
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(
          _AuthState value, $Res Function(_AuthState) then) =
      __$AuthStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {String currentUID,
      Map<String, String> cookies,
      Map<String, GameRole> roles,
      String? channel});
}

/// @nodoc
class __$AuthStateCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(_AuthState _value, $Res Function(_AuthState) _then)
      : super(_value, (v) => _then(v as _AuthState));

  @override
  _AuthState get _value => super._value as _AuthState;

  @override
  $Res call({
    Object? currentUID = freezed,
    Object? cookies = freezed,
    Object? roles = freezed,
    Object? channel = freezed,
  }) {
    return _then(_AuthState(
      currentUID: currentUID == freezed
          ? _value.currentUID
          : currentUID // ignore: cast_nullable_to_non_nullable
              as String,
      cookies: cookies == freezed
          ? _value.cookies
          : cookies // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as Map<String, GameRole>,
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuthState extends _AuthState with DiagnosticableTreeMixin {
  _$_AuthState(
      {required this.currentUID,
      this.cookies = const {},
      this.roles = const {},
      this.channel})
      : super._();

  factory _$_AuthState.fromJson(Map<String, dynamic> json) =>
      _$$_AuthStateFromJson(json);

  @override
  final String currentUID;
  @JsonKey()
  @override
  final Map<String, String> cookies;
  @JsonKey()
  @override
  final Map<String, GameRole> roles;
  @override
  final String? channel;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuthState(currentUID: $currentUID, cookies: $cookies, roles: $roles, channel: $channel)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuthState'))
      ..add(DiagnosticsProperty('currentUID', currentUID))
      ..add(DiagnosticsProperty('cookies', cookies))
      ..add(DiagnosticsProperty('roles', roles))
      ..add(DiagnosticsProperty('channel', channel));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthState &&
            const DeepCollectionEquality()
                .equals(other.currentUID, currentUID) &&
            const DeepCollectionEquality().equals(other.cookies, cookies) &&
            const DeepCollectionEquality().equals(other.roles, roles) &&
            const DeepCollectionEquality().equals(other.channel, channel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(currentUID),
      const DeepCollectionEquality().hash(cookies),
      const DeepCollectionEquality().hash(roles),
      const DeepCollectionEquality().hash(channel));

  @JsonKey(ignore: true)
  @override
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthStateToJson(this);
  }
}

abstract class _AuthState extends AuthState {
  factory _AuthState(
      {required String currentUID,
      Map<String, String> cookies,
      Map<String, GameRole> roles,
      String? channel}) = _$_AuthState;
  _AuthState._() : super._();

  factory _AuthState.fromJson(Map<String, dynamic> json) =
      _$_AuthState.fromJson;

  @override
  String get currentUID;
  @override
  Map<String, String> get cookies;
  @override
  Map<String, GameRole> get roles;
  @override
  String? get channel;
  @override
  @JsonKey(ignore: true)
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
