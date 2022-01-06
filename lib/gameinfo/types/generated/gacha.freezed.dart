// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../gacha.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GachaType _$GachaTypeFromJson(Map<String, dynamic> json) {
  return _GachaType.fromJson(json);
}

/// @nodoc
class _$GachaTypeTearOff {
  const _$GachaTypeTearOff();

  _GachaType call({required String key, required String name, String? id}) {
    return _GachaType(
      key: key,
      name: name,
      id: id,
    );
  }

  GachaType fromJson(Map<String, Object?> json) {
    return GachaType.fromJson(json);
  }
}

/// @nodoc
const $GachaType = _$GachaTypeTearOff();

/// @nodoc
mixin _$GachaType {
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GachaTypeCopyWith<GachaType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GachaTypeCopyWith<$Res> {
  factory $GachaTypeCopyWith(GachaType value, $Res Function(GachaType) then) =
      _$GachaTypeCopyWithImpl<$Res>;
  $Res call({String key, String name, String? id});
}

/// @nodoc
class _$GachaTypeCopyWithImpl<$Res> implements $GachaTypeCopyWith<$Res> {
  _$GachaTypeCopyWithImpl(this._value, this._then);

  final GachaType _value;
  // ignore: unused_field
  final $Res Function(GachaType) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$GachaTypeCopyWith<$Res> implements $GachaTypeCopyWith<$Res> {
  factory _$GachaTypeCopyWith(
          _GachaType value, $Res Function(_GachaType) then) =
      __$GachaTypeCopyWithImpl<$Res>;
  @override
  $Res call({String key, String name, String? id});
}

/// @nodoc
class __$GachaTypeCopyWithImpl<$Res> extends _$GachaTypeCopyWithImpl<$Res>
    implements _$GachaTypeCopyWith<$Res> {
  __$GachaTypeCopyWithImpl(_GachaType _value, $Res Function(_GachaType) _then)
      : super(_value, (v) => _then(v as _GachaType));

  @override
  _GachaType get _value => super._value as _GachaType;

  @override
  $Res call({
    Object? key = freezed,
    Object? name = freezed,
    Object? id = freezed,
  }) {
    return _then(_GachaType(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GachaType implements _GachaType {
  _$_GachaType({required this.key, required this.name, this.id});

  factory _$_GachaType.fromJson(Map<String, dynamic> json) =>
      _$$_GachaTypeFromJson(json);

  @override
  final String key;
  @override
  final String name;
  @override
  final String? id;

  @override
  String toString() {
    return 'GachaType(key: $key, name: $name, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GachaType &&
            const DeepCollectionEquality().equals(other.key, key) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(key),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$GachaTypeCopyWith<_GachaType> get copyWith =>
      __$GachaTypeCopyWithImpl<_GachaType>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GachaTypeToJson(this);
  }
}

abstract class _GachaType implements GachaType {
  factory _GachaType({required String key, required String name, String? id}) =
      _$_GachaType;

  factory _GachaType.fromJson(Map<String, dynamic> json) =
      _$_GachaType.fromJson;

  @override
  String get key;
  @override
  String get name;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$GachaTypeCopyWith<_GachaType> get copyWith =>
      throw _privateConstructorUsedError;
}

GachaLog _$GachaLogFromJson(Map<String, dynamic> json) {
  return _GachaLog.fromJson(json);
}

/// @nodoc
class _$GachaLogTearOff {
  const _$GachaLogTearOff();

  _GachaLog call(
      {required String uid,
      required String gachaType,
      required String name,
      required String lang,
      required String itemType,
      required String rankType,
      required String id,
      required DateTime time,
      @JsonKey(ignore: true) int countSinceLastGold = 0,
      @JsonKey(ignore: true) int countSinceLastPurple = 0}) {
    return _GachaLog(
      uid: uid,
      gachaType: gachaType,
      name: name,
      lang: lang,
      itemType: itemType,
      rankType: rankType,
      id: id,
      time: time,
      countSinceLastGold: countSinceLastGold,
      countSinceLastPurple: countSinceLastPurple,
    );
  }

  GachaLog fromJson(Map<String, Object?> json) {
    return GachaLog.fromJson(json);
  }
}

/// @nodoc
const $GachaLog = _$GachaLogTearOff();

/// @nodoc
mixin _$GachaLog {
  String get uid => throw _privateConstructorUsedError;
  String get gachaType => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;
  String get itemType => throw _privateConstructorUsedError;
  String get rankType => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  int get countSinceLastGold => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  int get countSinceLastPurple => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GachaLogCopyWith<GachaLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GachaLogCopyWith<$Res> {
  factory $GachaLogCopyWith(GachaLog value, $Res Function(GachaLog) then) =
      _$GachaLogCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String gachaType,
      String name,
      String lang,
      String itemType,
      String rankType,
      String id,
      DateTime time,
      @JsonKey(ignore: true) int countSinceLastGold,
      @JsonKey(ignore: true) int countSinceLastPurple});
}

/// @nodoc
class _$GachaLogCopyWithImpl<$Res> implements $GachaLogCopyWith<$Res> {
  _$GachaLogCopyWithImpl(this._value, this._then);

  final GachaLog _value;
  // ignore: unused_field
  final $Res Function(GachaLog) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? gachaType = freezed,
    Object? name = freezed,
    Object? lang = freezed,
    Object? itemType = freezed,
    Object? rankType = freezed,
    Object? id = freezed,
    Object? time = freezed,
    Object? countSinceLastGold = freezed,
    Object? countSinceLastPurple = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      gachaType: gachaType == freezed
          ? _value.gachaType
          : gachaType // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      itemType: itemType == freezed
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as String,
      rankType: rankType == freezed
          ? _value.rankType
          : rankType // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      countSinceLastGold: countSinceLastGold == freezed
          ? _value.countSinceLastGold
          : countSinceLastGold // ignore: cast_nullable_to_non_nullable
              as int,
      countSinceLastPurple: countSinceLastPurple == freezed
          ? _value.countSinceLastPurple
          : countSinceLastPurple // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$GachaLogCopyWith<$Res> implements $GachaLogCopyWith<$Res> {
  factory _$GachaLogCopyWith(_GachaLog value, $Res Function(_GachaLog) then) =
      __$GachaLogCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String gachaType,
      String name,
      String lang,
      String itemType,
      String rankType,
      String id,
      DateTime time,
      @JsonKey(ignore: true) int countSinceLastGold,
      @JsonKey(ignore: true) int countSinceLastPurple});
}

/// @nodoc
class __$GachaLogCopyWithImpl<$Res> extends _$GachaLogCopyWithImpl<$Res>
    implements _$GachaLogCopyWith<$Res> {
  __$GachaLogCopyWithImpl(_GachaLog _value, $Res Function(_GachaLog) _then)
      : super(_value, (v) => _then(v as _GachaLog));

  @override
  _GachaLog get _value => super._value as _GachaLog;

  @override
  $Res call({
    Object? uid = freezed,
    Object? gachaType = freezed,
    Object? name = freezed,
    Object? lang = freezed,
    Object? itemType = freezed,
    Object? rankType = freezed,
    Object? id = freezed,
    Object? time = freezed,
    Object? countSinceLastGold = freezed,
    Object? countSinceLastPurple = freezed,
  }) {
    return _then(_GachaLog(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      gachaType: gachaType == freezed
          ? _value.gachaType
          : gachaType // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      itemType: itemType == freezed
          ? _value.itemType
          : itemType // ignore: cast_nullable_to_non_nullable
              as String,
      rankType: rankType == freezed
          ? _value.rankType
          : rankType // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      time: time == freezed
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      countSinceLastGold: countSinceLastGold == freezed
          ? _value.countSinceLastGold
          : countSinceLastGold // ignore: cast_nullable_to_non_nullable
              as int,
      countSinceLastPurple: countSinceLastPurple == freezed
          ? _value.countSinceLastPurple
          : countSinceLastPurple // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_GachaLog extends _GachaLog {
  _$_GachaLog(
      {required this.uid,
      required this.gachaType,
      required this.name,
      required this.lang,
      required this.itemType,
      required this.rankType,
      required this.id,
      required this.time,
      @JsonKey(ignore: true) this.countSinceLastGold = 0,
      @JsonKey(ignore: true) this.countSinceLastPurple = 0})
      : super._();

  factory _$_GachaLog.fromJson(Map<String, dynamic> json) =>
      _$$_GachaLogFromJson(json);

  @override
  final String uid;
  @override
  final String gachaType;
  @override
  final String name;
  @override
  final String lang;
  @override
  final String itemType;
  @override
  final String rankType;
  @override
  final String id;
  @override
  final DateTime time;
  @override
  @JsonKey(ignore: true)
  final int countSinceLastGold;
  @override
  @JsonKey(ignore: true)
  final int countSinceLastPurple;

  @override
  String toString() {
    return 'GachaLog(uid: $uid, gachaType: $gachaType, name: $name, lang: $lang, itemType: $itemType, rankType: $rankType, id: $id, time: $time, countSinceLastGold: $countSinceLastGold, countSinceLastPurple: $countSinceLastPurple)';
  }

  @JsonKey(ignore: true)
  @override
  _$GachaLogCopyWith<_GachaLog> get copyWith =>
      __$GachaLogCopyWithImpl<_GachaLog>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GachaLogToJson(this);
  }
}

abstract class _GachaLog extends GachaLog {
  factory _GachaLog(
      {required String uid,
      required String gachaType,
      required String name,
      required String lang,
      required String itemType,
      required String rankType,
      required String id,
      required DateTime time,
      @JsonKey(ignore: true) int countSinceLastGold,
      @JsonKey(ignore: true) int countSinceLastPurple}) = _$_GachaLog;
  _GachaLog._() : super._();

  factory _GachaLog.fromJson(Map<String, dynamic> json) = _$_GachaLog.fromJson;

  @override
  String get uid;
  @override
  String get gachaType;
  @override
  String get name;
  @override
  String get lang;
  @override
  String get itemType;
  @override
  String get rankType;
  @override
  String get id;
  @override
  DateTime get time;
  @override
  @JsonKey(ignore: true)
  int get countSinceLastGold;
  @override
  @JsonKey(ignore: true)
  int get countSinceLastPurple;
  @override
  @JsonKey(ignore: true)
  _$GachaLogCopyWith<_GachaLog> get copyWith =>
      throw _privateConstructorUsedError;
}
