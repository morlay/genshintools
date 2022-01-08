// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../webdav.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WebDAV _$WebDAVFromJson(Map<String, dynamic> json) {
  return _WebDAV.fromJson(json);
}

/// @nodoc
class _$WebDAVTearOff {
  const _$WebDAVTearOff();

  _WebDAV call(
      {required String address,
      required String username,
      required String password,
      bool? valid}) {
    return _WebDAV(
      address: address,
      username: username,
      password: password,
      valid: valid,
    );
  }

  WebDAV fromJson(Map<String, Object?> json) {
    return WebDAV.fromJson(json);
  }
}

/// @nodoc
const $WebDAV = _$WebDAVTearOff();

/// @nodoc
mixin _$WebDAV {
  String get address => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool? get valid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebDAVCopyWith<WebDAV> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebDAVCopyWith<$Res> {
  factory $WebDAVCopyWith(WebDAV value, $Res Function(WebDAV) then) =
      _$WebDAVCopyWithImpl<$Res>;
  $Res call({String address, String username, String password, bool? valid});
}

/// @nodoc
class _$WebDAVCopyWithImpl<$Res> implements $WebDAVCopyWith<$Res> {
  _$WebDAVCopyWithImpl(this._value, this._then);

  final WebDAV _value;
  // ignore: unused_field
  final $Res Function(WebDAV) _then;

  @override
  $Res call({
    Object? address = freezed,
    Object? username = freezed,
    Object? password = freezed,
    Object? valid = freezed,
  }) {
    return _then(_value.copyWith(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      valid: valid == freezed
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$WebDAVCopyWith<$Res> implements $WebDAVCopyWith<$Res> {
  factory _$WebDAVCopyWith(_WebDAV value, $Res Function(_WebDAV) then) =
      __$WebDAVCopyWithImpl<$Res>;
  @override
  $Res call({String address, String username, String password, bool? valid});
}

/// @nodoc
class __$WebDAVCopyWithImpl<$Res> extends _$WebDAVCopyWithImpl<$Res>
    implements _$WebDAVCopyWith<$Res> {
  __$WebDAVCopyWithImpl(_WebDAV _value, $Res Function(_WebDAV) _then)
      : super(_value, (v) => _then(v as _WebDAV));

  @override
  _WebDAV get _value => super._value as _WebDAV;

  @override
  $Res call({
    Object? address = freezed,
    Object? username = freezed,
    Object? password = freezed,
    Object? valid = freezed,
  }) {
    return _then(_WebDAV(
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      valid: valid == freezed
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WebDAV extends _WebDAV {
  _$_WebDAV(
      {required this.address,
      required this.username,
      required this.password,
      this.valid})
      : super._();

  factory _$_WebDAV.fromJson(Map<String, dynamic> json) =>
      _$$_WebDAVFromJson(json);

  @override
  final String address;
  @override
  final String username;
  @override
  final String password;
  @override
  final bool? valid;

  @override
  String toString() {
    return 'WebDAV(address: $address, username: $username, password: $password, valid: $valid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebDAV &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.valid, valid));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(valid));

  @JsonKey(ignore: true)
  @override
  _$WebDAVCopyWith<_WebDAV> get copyWith =>
      __$WebDAVCopyWithImpl<_WebDAV>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WebDAVToJson(this);
  }
}

abstract class _WebDAV extends WebDAV {
  factory _WebDAV(
      {required String address,
      required String username,
      required String password,
      bool? valid}) = _$_WebDAV;
  _WebDAV._() : super._();

  factory _WebDAV.fromJson(Map<String, dynamic> json) = _$_WebDAV.fromJson;

  @override
  String get address;
  @override
  String get username;
  @override
  String get password;
  @override
  bool? get valid;
  @override
  @JsonKey(ignore: true)
  _$WebDAVCopyWith<_WebDAV> get copyWith => throw _privateConstructorUsedError;
}
