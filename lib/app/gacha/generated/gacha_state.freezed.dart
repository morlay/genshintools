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

UigfInfo _$UigfInfoFromJson(Map<String, dynamic> json) {
  return _UigfInfo.fromJson(json);
}

/// @nodoc
class _$UigfInfoTearOff {
  const _$UigfInfoTearOff();

  _UigfInfo call(
      {required String uid,
      required String lang,
      String uigfVersion = "v2.2"}) {
    return _UigfInfo(
      uid: uid,
      lang: lang,
      uigfVersion: uigfVersion,
    );
  }

  UigfInfo fromJson(Map<String, Object?> json) {
    return UigfInfo.fromJson(json);
  }
}

/// @nodoc
const $UigfInfo = _$UigfInfoTearOff();

/// @nodoc
mixin _$UigfInfo {
  String get uid => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;
  String get uigfVersion => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UigfInfoCopyWith<UigfInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UigfInfoCopyWith<$Res> {
  factory $UigfInfoCopyWith(UigfInfo value, $Res Function(UigfInfo) then) =
      _$UigfInfoCopyWithImpl<$Res>;
  $Res call({String uid, String lang, String uigfVersion});
}

/// @nodoc
class _$UigfInfoCopyWithImpl<$Res> implements $UigfInfoCopyWith<$Res> {
  _$UigfInfoCopyWithImpl(this._value, this._then);

  final UigfInfo _value;
  // ignore: unused_field
  final $Res Function(UigfInfo) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? lang = freezed,
    Object? uigfVersion = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      uigfVersion: uigfVersion == freezed
          ? _value.uigfVersion
          : uigfVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UigfInfoCopyWith<$Res> implements $UigfInfoCopyWith<$Res> {
  factory _$UigfInfoCopyWith(_UigfInfo value, $Res Function(_UigfInfo) then) =
      __$UigfInfoCopyWithImpl<$Res>;
  @override
  $Res call({String uid, String lang, String uigfVersion});
}

/// @nodoc
class __$UigfInfoCopyWithImpl<$Res> extends _$UigfInfoCopyWithImpl<$Res>
    implements _$UigfInfoCopyWith<$Res> {
  __$UigfInfoCopyWithImpl(_UigfInfo _value, $Res Function(_UigfInfo) _then)
      : super(_value, (v) => _then(v as _UigfInfo));

  @override
  _UigfInfo get _value => super._value as _UigfInfo;

  @override
  $Res call({
    Object? uid = freezed,
    Object? lang = freezed,
    Object? uigfVersion = freezed,
  }) {
    return _then(_UigfInfo(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      uigfVersion: uigfVersion == freezed
          ? _value.uigfVersion
          : uigfVersion // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_UigfInfo implements _UigfInfo {
  _$_UigfInfo(
      {required this.uid, required this.lang, this.uigfVersion = "v2.2"});

  factory _$_UigfInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UigfInfoFromJson(json);

  @override
  final String uid;
  @override
  final String lang;
  @JsonKey()
  @override
  final String uigfVersion;

  @override
  String toString() {
    return 'UigfInfo(uid: $uid, lang: $lang, uigfVersion: $uigfVersion)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UigfInfo &&
            const DeepCollectionEquality().equals(other.uid, uid) &&
            const DeepCollectionEquality().equals(other.lang, lang) &&
            const DeepCollectionEquality()
                .equals(other.uigfVersion, uigfVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uid),
      const DeepCollectionEquality().hash(lang),
      const DeepCollectionEquality().hash(uigfVersion));

  @JsonKey(ignore: true)
  @override
  _$UigfInfoCopyWith<_UigfInfo> get copyWith =>
      __$UigfInfoCopyWithImpl<_UigfInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UigfInfoToJson(this);
  }
}

abstract class _UigfInfo implements UigfInfo {
  factory _UigfInfo(
      {required String uid,
      required String lang,
      String uigfVersion}) = _$_UigfInfo;

  factory _UigfInfo.fromJson(Map<String, dynamic> json) = _$_UigfInfo.fromJson;

  @override
  String get uid;
  @override
  String get lang;
  @override
  String get uigfVersion;
  @override
  @JsonKey(ignore: true)
  _$UigfInfoCopyWith<_UigfInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

GachaState _$GachaStateFromJson(Map<String, dynamic> json) {
  return _GachaState.fromJson(json);
}

/// @nodoc
class _$GachaStateTearOff {
  const _$GachaStateTearOff();

  _GachaState call({required List<GachaLog> list, UigfInfo? info}) {
    return _GachaState(
      list: list,
      info: info,
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
  List<GachaLog> get list => throw _privateConstructorUsedError;
  UigfInfo? get info => throw _privateConstructorUsedError;

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
  $Res call({List<GachaLog> list, UigfInfo? info});

  $UigfInfoCopyWith<$Res>? get info;
}

/// @nodoc
class _$GachaStateCopyWithImpl<$Res> implements $GachaStateCopyWith<$Res> {
  _$GachaStateCopyWithImpl(this._value, this._then);

  final GachaState _value;
  // ignore: unused_field
  final $Res Function(GachaState) _then;

  @override
  $Res call({
    Object? list = freezed,
    Object? info = freezed,
  }) {
    return _then(_value.copyWith(
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<GachaLog>,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UigfInfo?,
    ));
  }

  @override
  $UigfInfoCopyWith<$Res>? get info {
    if (_value.info == null) {
      return null;
    }

    return $UigfInfoCopyWith<$Res>(_value.info!, (value) {
      return _then(_value.copyWith(info: value));
    });
  }
}

/// @nodoc
abstract class _$GachaStateCopyWith<$Res> implements $GachaStateCopyWith<$Res> {
  factory _$GachaStateCopyWith(
          _GachaState value, $Res Function(_GachaState) then) =
      __$GachaStateCopyWithImpl<$Res>;
  @override
  $Res call({List<GachaLog> list, UigfInfo? info});

  @override
  $UigfInfoCopyWith<$Res>? get info;
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
    Object? list = freezed,
    Object? info = freezed,
  }) {
    return _then(_GachaState(
      list: list == freezed
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<GachaLog>,
      info: info == freezed
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as UigfInfo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GachaState extends _GachaState {
  _$_GachaState({required this.list, this.info}) : super._();

  factory _$_GachaState.fromJson(Map<String, dynamic> json) =>
      _$$_GachaStateFromJson(json);

  @override
  final List<GachaLog> list;
  @override
  final UigfInfo? info;

  @override
  String toString() {
    return 'GachaState(list: $list, info: $info)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GachaState &&
            const DeepCollectionEquality().equals(other.list, list) &&
            const DeepCollectionEquality().equals(other.info, info));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(list),
      const DeepCollectionEquality().hash(info));

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
  factory _GachaState({required List<GachaLog> list, UigfInfo? info}) =
      _$_GachaState;
  _GachaState._() : super._();

  factory _GachaState.fromJson(Map<String, dynamic> json) =
      _$_GachaState.fromJson;

  @override
  List<GachaLog> get list;
  @override
  UigfInfo? get info;
  @override
  @JsonKey(ignore: true)
  _$GachaStateCopyWith<_GachaState> get copyWith =>
      throw _privateConstructorUsedError;
}
