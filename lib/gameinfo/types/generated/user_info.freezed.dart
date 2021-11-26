// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../user_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
class _$UserInfoTearOff {
  const _$UserInfoTearOff();

  _UserInfo call({List<Avatar>? avatars, List<Home>? homes}) {
    return _UserInfo(
      avatars: avatars,
      homes: homes,
    );
  }

  UserInfo fromJson(Map<String, Object?> json) {
    return UserInfo.fromJson(json);
  }
}

/// @nodoc
const $UserInfo = _$UserInfoTearOff();

/// @nodoc
mixin _$UserInfo {
  List<Avatar>? get avatars => throw _privateConstructorUsedError;
  List<Home>? get homes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res>;
  $Res call({List<Avatar>? avatars, List<Home>? homes});
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res> implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  final UserInfo _value;
  // ignore: unused_field
  final $Res Function(UserInfo) _then;

  @override
  $Res call({
    Object? avatars = freezed,
    Object? homes = freezed,
  }) {
    return _then(_value.copyWith(
      avatars: avatars == freezed
          ? _value.avatars
          : avatars // ignore: cast_nullable_to_non_nullable
              as List<Avatar>?,
      homes: homes == freezed
          ? _value.homes
          : homes // ignore: cast_nullable_to_non_nullable
              as List<Home>?,
    ));
  }
}

/// @nodoc
abstract class _$UserInfoCopyWith<$Res> implements $UserInfoCopyWith<$Res> {
  factory _$UserInfoCopyWith(_UserInfo value, $Res Function(_UserInfo) then) =
      __$UserInfoCopyWithImpl<$Res>;
  @override
  $Res call({List<Avatar>? avatars, List<Home>? homes});
}

/// @nodoc
class __$UserInfoCopyWithImpl<$Res> extends _$UserInfoCopyWithImpl<$Res>
    implements _$UserInfoCopyWith<$Res> {
  __$UserInfoCopyWithImpl(_UserInfo _value, $Res Function(_UserInfo) _then)
      : super(_value, (v) => _then(v as _UserInfo));

  @override
  _UserInfo get _value => super._value as _UserInfo;

  @override
  $Res call({
    Object? avatars = freezed,
    Object? homes = freezed,
  }) {
    return _then(_UserInfo(
      avatars: avatars == freezed
          ? _value.avatars
          : avatars // ignore: cast_nullable_to_non_nullable
              as List<Avatar>?,
      homes: homes == freezed
          ? _value.homes
          : homes // ignore: cast_nullable_to_non_nullable
              as List<Home>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfo implements _UserInfo {
  _$_UserInfo({this.avatars, this.homes});

  factory _$_UserInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserInfoFromJson(json);

  @override
  final List<Avatar>? avatars;
  @override
  final List<Home>? homes;

  @override
  String toString() {
    return 'UserInfo(avatars: $avatars, homes: $homes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserInfo &&
            const DeepCollectionEquality().equals(other.avatars, avatars) &&
            const DeepCollectionEquality().equals(other.homes, homes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(avatars),
      const DeepCollectionEquality().hash(homes));

  @JsonKey(ignore: true)
  @override
  _$UserInfoCopyWith<_UserInfo> get copyWith =>
      __$UserInfoCopyWithImpl<_UserInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoToJson(this);
  }
}

abstract class _UserInfo implements UserInfo {
  factory _UserInfo({List<Avatar>? avatars, List<Home>? homes}) = _$_UserInfo;

  factory _UserInfo.fromJson(Map<String, dynamic> json) = _$_UserInfo.fromJson;

  @override
  List<Avatar>? get avatars;
  @override
  List<Home>? get homes;
  @override
  @JsonKey(ignore: true)
  _$UserInfoCopyWith<_UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return _Avatar.fromJson(json);
}

/// @nodoc
class _$AvatarTearOff {
  const _$AvatarTearOff();

  _Avatar call(
      {required int id,
      required int level,
      required String name,
      required int rarity,
      required int fetter,
      required int activedConstellationNum,
      required String element,
      Weapon? weapon,
      List<Reliquary>? reliquaries}) {
    return _Avatar(
      id: id,
      level: level,
      name: name,
      rarity: rarity,
      fetter: fetter,
      activedConstellationNum: activedConstellationNum,
      element: element,
      weapon: weapon,
      reliquaries: reliquaries,
    );
  }

  Avatar fromJson(Map<String, Object?> json) {
    return Avatar.fromJson(json);
  }
}

/// @nodoc
const $Avatar = _$AvatarTearOff();

/// @nodoc
mixin _$Avatar {
  int get id => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  int get fetter => throw _privateConstructorUsedError;
  int get activedConstellationNum => throw _privateConstructorUsedError;
  String get element => throw _privateConstructorUsedError;
  Weapon? get weapon => throw _privateConstructorUsedError;
  List<Reliquary>? get reliquaries => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarCopyWith<Avatar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarCopyWith<$Res> {
  factory $AvatarCopyWith(Avatar value, $Res Function(Avatar) then) =
      _$AvatarCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int level,
      String name,
      int rarity,
      int fetter,
      int activedConstellationNum,
      String element,
      Weapon? weapon,
      List<Reliquary>? reliquaries});

  $WeaponCopyWith<$Res>? get weapon;
}

/// @nodoc
class _$AvatarCopyWithImpl<$Res> implements $AvatarCopyWith<$Res> {
  _$AvatarCopyWithImpl(this._value, this._then);

  final Avatar _value;
  // ignore: unused_field
  final $Res Function(Avatar) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? name = freezed,
    Object? rarity = freezed,
    Object? fetter = freezed,
    Object? activedConstellationNum = freezed,
    Object? element = freezed,
    Object? weapon = freezed,
    Object? reliquaries = freezed,
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
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      fetter: fetter == freezed
          ? _value.fetter
          : fetter // ignore: cast_nullable_to_non_nullable
              as int,
      activedConstellationNum: activedConstellationNum == freezed
          ? _value.activedConstellationNum
          : activedConstellationNum // ignore: cast_nullable_to_non_nullable
              as int,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as String,
      weapon: weapon == freezed
          ? _value.weapon
          : weapon // ignore: cast_nullable_to_non_nullable
              as Weapon?,
      reliquaries: reliquaries == freezed
          ? _value.reliquaries
          : reliquaries // ignore: cast_nullable_to_non_nullable
              as List<Reliquary>?,
    ));
  }

  @override
  $WeaponCopyWith<$Res>? get weapon {
    if (_value.weapon == null) {
      return null;
    }

    return $WeaponCopyWith<$Res>(_value.weapon!, (value) {
      return _then(_value.copyWith(weapon: value));
    });
  }
}

/// @nodoc
abstract class _$AvatarCopyWith<$Res> implements $AvatarCopyWith<$Res> {
  factory _$AvatarCopyWith(_Avatar value, $Res Function(_Avatar) then) =
      __$AvatarCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int level,
      String name,
      int rarity,
      int fetter,
      int activedConstellationNum,
      String element,
      Weapon? weapon,
      List<Reliquary>? reliquaries});

  @override
  $WeaponCopyWith<$Res>? get weapon;
}

/// @nodoc
class __$AvatarCopyWithImpl<$Res> extends _$AvatarCopyWithImpl<$Res>
    implements _$AvatarCopyWith<$Res> {
  __$AvatarCopyWithImpl(_Avatar _value, $Res Function(_Avatar) _then)
      : super(_value, (v) => _then(v as _Avatar));

  @override
  _Avatar get _value => super._value as _Avatar;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? name = freezed,
    Object? rarity = freezed,
    Object? fetter = freezed,
    Object? activedConstellationNum = freezed,
    Object? element = freezed,
    Object? weapon = freezed,
    Object? reliquaries = freezed,
  }) {
    return _then(_Avatar(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      fetter: fetter == freezed
          ? _value.fetter
          : fetter // ignore: cast_nullable_to_non_nullable
              as int,
      activedConstellationNum: activedConstellationNum == freezed
          ? _value.activedConstellationNum
          : activedConstellationNum // ignore: cast_nullable_to_non_nullable
              as int,
      element: element == freezed
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as String,
      weapon: weapon == freezed
          ? _value.weapon
          : weapon // ignore: cast_nullable_to_non_nullable
              as Weapon?,
      reliquaries: reliquaries == freezed
          ? _value.reliquaries
          : reliquaries // ignore: cast_nullable_to_non_nullable
              as List<Reliquary>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Avatar implements _Avatar {
  _$_Avatar(
      {required this.id,
      required this.level,
      required this.name,
      required this.rarity,
      required this.fetter,
      required this.activedConstellationNum,
      required this.element,
      this.weapon,
      this.reliquaries});

  factory _$_Avatar.fromJson(Map<String, dynamic> json) =>
      _$$_AvatarFromJson(json);

  @override
  final int id;
  @override
  final int level;
  @override
  final String name;
  @override
  final int rarity;
  @override
  final int fetter;
  @override
  final int activedConstellationNum;
  @override
  final String element;
  @override
  final Weapon? weapon;
  @override
  final List<Reliquary>? reliquaries;

  @override
  String toString() {
    return 'Avatar(id: $id, level: $level, name: $name, rarity: $rarity, fetter: $fetter, activedConstellationNum: $activedConstellationNum, element: $element, weapon: $weapon, reliquaries: $reliquaries)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Avatar &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.rarity, rarity) &&
            const DeepCollectionEquality().equals(other.fetter, fetter) &&
            const DeepCollectionEquality().equals(
                other.activedConstellationNum, activedConstellationNum) &&
            const DeepCollectionEquality().equals(other.element, element) &&
            const DeepCollectionEquality().equals(other.weapon, weapon) &&
            const DeepCollectionEquality()
                .equals(other.reliquaries, reliquaries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(rarity),
      const DeepCollectionEquality().hash(fetter),
      const DeepCollectionEquality().hash(activedConstellationNum),
      const DeepCollectionEquality().hash(element),
      const DeepCollectionEquality().hash(weapon),
      const DeepCollectionEquality().hash(reliquaries));

  @JsonKey(ignore: true)
  @override
  _$AvatarCopyWith<_Avatar> get copyWith =>
      __$AvatarCopyWithImpl<_Avatar>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvatarToJson(this);
  }
}

abstract class _Avatar implements Avatar {
  factory _Avatar(
      {required int id,
      required int level,
      required String name,
      required int rarity,
      required int fetter,
      required int activedConstellationNum,
      required String element,
      Weapon? weapon,
      List<Reliquary>? reliquaries}) = _$_Avatar;

  factory _Avatar.fromJson(Map<String, dynamic> json) = _$_Avatar.fromJson;

  @override
  int get id;
  @override
  int get level;
  @override
  String get name;
  @override
  int get rarity;
  @override
  int get fetter;
  @override
  int get activedConstellationNum;
  @override
  String get element;
  @override
  Weapon? get weapon;
  @override
  List<Reliquary>? get reliquaries;
  @override
  @JsonKey(ignore: true)
  _$AvatarCopyWith<_Avatar> get copyWith => throw _privateConstructorUsedError;
}

Reliquary _$ReliquaryFromJson(Map<String, dynamic> json) {
  return _Reliquary.fromJson(json);
}

/// @nodoc
class _$ReliquaryTearOff {
  const _$ReliquaryTearOff();

  _Reliquary call(
      {required int id,
      required int level,
      required String name,
      required int rarity,
      required int pos}) {
    return _Reliquary(
      id: id,
      level: level,
      name: name,
      rarity: rarity,
      pos: pos,
    );
  }

  Reliquary fromJson(Map<String, Object?> json) {
    return Reliquary.fromJson(json);
  }
}

/// @nodoc
const $Reliquary = _$ReliquaryTearOff();

/// @nodoc
mixin _$Reliquary {
  int get id => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  int get pos => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReliquaryCopyWith<Reliquary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReliquaryCopyWith<$Res> {
  factory $ReliquaryCopyWith(Reliquary value, $Res Function(Reliquary) then) =
      _$ReliquaryCopyWithImpl<$Res>;
  $Res call({int id, int level, String name, int rarity, int pos});
}

/// @nodoc
class _$ReliquaryCopyWithImpl<$Res> implements $ReliquaryCopyWith<$Res> {
  _$ReliquaryCopyWithImpl(this._value, this._then);

  final Reliquary _value;
  // ignore: unused_field
  final $Res Function(Reliquary) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? name = freezed,
    Object? rarity = freezed,
    Object? pos = freezed,
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
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      pos: pos == freezed
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ReliquaryCopyWith<$Res> implements $ReliquaryCopyWith<$Res> {
  factory _$ReliquaryCopyWith(
          _Reliquary value, $Res Function(_Reliquary) then) =
      __$ReliquaryCopyWithImpl<$Res>;
  @override
  $Res call({int id, int level, String name, int rarity, int pos});
}

/// @nodoc
class __$ReliquaryCopyWithImpl<$Res> extends _$ReliquaryCopyWithImpl<$Res>
    implements _$ReliquaryCopyWith<$Res> {
  __$ReliquaryCopyWithImpl(_Reliquary _value, $Res Function(_Reliquary) _then)
      : super(_value, (v) => _then(v as _Reliquary));

  @override
  _Reliquary get _value => super._value as _Reliquary;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? name = freezed,
    Object? rarity = freezed,
    Object? pos = freezed,
  }) {
    return _then(_Reliquary(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      pos: pos == freezed
          ? _value.pos
          : pos // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Reliquary implements _Reliquary {
  _$_Reliquary(
      {required this.id,
      required this.level,
      required this.name,
      required this.rarity,
      required this.pos});

  factory _$_Reliquary.fromJson(Map<String, dynamic> json) =>
      _$$_ReliquaryFromJson(json);

  @override
  final int id;
  @override
  final int level;
  @override
  final String name;
  @override
  final int rarity;
  @override
  final int pos;

  @override
  String toString() {
    return 'Reliquary(id: $id, level: $level, name: $name, rarity: $rarity, pos: $pos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Reliquary &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.rarity, rarity) &&
            const DeepCollectionEquality().equals(other.pos, pos));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(rarity),
      const DeepCollectionEquality().hash(pos));

  @JsonKey(ignore: true)
  @override
  _$ReliquaryCopyWith<_Reliquary> get copyWith =>
      __$ReliquaryCopyWithImpl<_Reliquary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReliquaryToJson(this);
  }
}

abstract class _Reliquary implements Reliquary {
  factory _Reliquary(
      {required int id,
      required int level,
      required String name,
      required int rarity,
      required int pos}) = _$_Reliquary;

  factory _Reliquary.fromJson(Map<String, dynamic> json) =
      _$_Reliquary.fromJson;

  @override
  int get id;
  @override
  int get level;
  @override
  String get name;
  @override
  int get rarity;
  @override
  int get pos;
  @override
  @JsonKey(ignore: true)
  _$ReliquaryCopyWith<_Reliquary> get copyWith =>
      throw _privateConstructorUsedError;
}

Weapon _$WeaponFromJson(Map<String, dynamic> json) {
  return _Weapon.fromJson(json);
}

/// @nodoc
class _$WeaponTearOff {
  const _$WeaponTearOff();

  _Weapon call(
      {required int id,
      required int level,
      required String name,
      required int rarity,
      required int affixLevel}) {
    return _Weapon(
      id: id,
      level: level,
      name: name,
      rarity: rarity,
      affixLevel: affixLevel,
    );
  }

  Weapon fromJson(Map<String, Object?> json) {
    return Weapon.fromJson(json);
  }
}

/// @nodoc
const $Weapon = _$WeaponTearOff();

/// @nodoc
mixin _$Weapon {
  int get id => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  int get affixLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeaponCopyWith<Weapon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeaponCopyWith<$Res> {
  factory $WeaponCopyWith(Weapon value, $Res Function(Weapon) then) =
      _$WeaponCopyWithImpl<$Res>;
  $Res call({int id, int level, String name, int rarity, int affixLevel});
}

/// @nodoc
class _$WeaponCopyWithImpl<$Res> implements $WeaponCopyWith<$Res> {
  _$WeaponCopyWithImpl(this._value, this._then);

  final Weapon _value;
  // ignore: unused_field
  final $Res Function(Weapon) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? name = freezed,
    Object? rarity = freezed,
    Object? affixLevel = freezed,
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
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      affixLevel: affixLevel == freezed
          ? _value.affixLevel
          : affixLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$WeaponCopyWith<$Res> implements $WeaponCopyWith<$Res> {
  factory _$WeaponCopyWith(_Weapon value, $Res Function(_Weapon) then) =
      __$WeaponCopyWithImpl<$Res>;
  @override
  $Res call({int id, int level, String name, int rarity, int affixLevel});
}

/// @nodoc
class __$WeaponCopyWithImpl<$Res> extends _$WeaponCopyWithImpl<$Res>
    implements _$WeaponCopyWith<$Res> {
  __$WeaponCopyWithImpl(_Weapon _value, $Res Function(_Weapon) _then)
      : super(_value, (v) => _then(v as _Weapon));

  @override
  _Weapon get _value => super._value as _Weapon;

  @override
  $Res call({
    Object? id = freezed,
    Object? level = freezed,
    Object? name = freezed,
    Object? rarity = freezed,
    Object? affixLevel = freezed,
  }) {
    return _then(_Weapon(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      affixLevel: affixLevel == freezed
          ? _value.affixLevel
          : affixLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Weapon implements _Weapon {
  _$_Weapon(
      {required this.id,
      required this.level,
      required this.name,
      required this.rarity,
      required this.affixLevel});

  factory _$_Weapon.fromJson(Map<String, dynamic> json) =>
      _$$_WeaponFromJson(json);

  @override
  final int id;
  @override
  final int level;
  @override
  final String name;
  @override
  final int rarity;
  @override
  final int affixLevel;

  @override
  String toString() {
    return 'Weapon(id: $id, level: $level, name: $name, rarity: $rarity, affixLevel: $affixLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Weapon &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.rarity, rarity) &&
            const DeepCollectionEquality()
                .equals(other.affixLevel, affixLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(rarity),
      const DeepCollectionEquality().hash(affixLevel));

  @JsonKey(ignore: true)
  @override
  _$WeaponCopyWith<_Weapon> get copyWith =>
      __$WeaponCopyWithImpl<_Weapon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WeaponToJson(this);
  }
}

abstract class _Weapon implements Weapon {
  factory _Weapon(
      {required int id,
      required int level,
      required String name,
      required int rarity,
      required int affixLevel}) = _$_Weapon;

  factory _Weapon.fromJson(Map<String, dynamic> json) = _$_Weapon.fromJson;

  @override
  int get id;
  @override
  int get level;
  @override
  String get name;
  @override
  int get rarity;
  @override
  int get affixLevel;
  @override
  @JsonKey(ignore: true)
  _$WeaponCopyWith<_Weapon> get copyWith => throw _privateConstructorUsedError;
}

Home _$HomeFromJson(Map<String, dynamic> json) {
  return _Home.fromJson(json);
}

/// @nodoc
class _$HomeTearOff {
  const _$HomeTearOff();

  _Home call(
      {required int level,
      required int visitNum,
      required int comfortNum,
      required int itemNum,
      required String name}) {
    return _Home(
      level: level,
      visitNum: visitNum,
      comfortNum: comfortNum,
      itemNum: itemNum,
      name: name,
    );
  }

  Home fromJson(Map<String, Object?> json) {
    return Home.fromJson(json);
  }
}

/// @nodoc
const $Home = _$HomeTearOff();

/// @nodoc
mixin _$Home {
  int get level => throw _privateConstructorUsedError;
  int get visitNum => throw _privateConstructorUsedError;
  int get comfortNum => throw _privateConstructorUsedError;
  int get itemNum => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HomeCopyWith<Home> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeCopyWith<$Res> {
  factory $HomeCopyWith(Home value, $Res Function(Home) then) =
      _$HomeCopyWithImpl<$Res>;
  $Res call(
      {int level, int visitNum, int comfortNum, int itemNum, String name});
}

/// @nodoc
class _$HomeCopyWithImpl<$Res> implements $HomeCopyWith<$Res> {
  _$HomeCopyWithImpl(this._value, this._then);

  final Home _value;
  // ignore: unused_field
  final $Res Function(Home) _then;

  @override
  $Res call({
    Object? level = freezed,
    Object? visitNum = freezed,
    Object? comfortNum = freezed,
    Object? itemNum = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      visitNum: visitNum == freezed
          ? _value.visitNum
          : visitNum // ignore: cast_nullable_to_non_nullable
              as int,
      comfortNum: comfortNum == freezed
          ? _value.comfortNum
          : comfortNum // ignore: cast_nullable_to_non_nullable
              as int,
      itemNum: itemNum == freezed
          ? _value.itemNum
          : itemNum // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$HomeCopyWith<$Res> implements $HomeCopyWith<$Res> {
  factory _$HomeCopyWith(_Home value, $Res Function(_Home) then) =
      __$HomeCopyWithImpl<$Res>;
  @override
  $Res call(
      {int level, int visitNum, int comfortNum, int itemNum, String name});
}

/// @nodoc
class __$HomeCopyWithImpl<$Res> extends _$HomeCopyWithImpl<$Res>
    implements _$HomeCopyWith<$Res> {
  __$HomeCopyWithImpl(_Home _value, $Res Function(_Home) _then)
      : super(_value, (v) => _then(v as _Home));

  @override
  _Home get _value => super._value as _Home;

  @override
  $Res call({
    Object? level = freezed,
    Object? visitNum = freezed,
    Object? comfortNum = freezed,
    Object? itemNum = freezed,
    Object? name = freezed,
  }) {
    return _then(_Home(
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      visitNum: visitNum == freezed
          ? _value.visitNum
          : visitNum // ignore: cast_nullable_to_non_nullable
              as int,
      comfortNum: comfortNum == freezed
          ? _value.comfortNum
          : comfortNum // ignore: cast_nullable_to_non_nullable
              as int,
      itemNum: itemNum == freezed
          ? _value.itemNum
          : itemNum // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_Home implements _Home {
  _$_Home(
      {required this.level,
      required this.visitNum,
      required this.comfortNum,
      required this.itemNum,
      required this.name});

  factory _$_Home.fromJson(Map<String, dynamic> json) => _$$_HomeFromJson(json);

  @override
  final int level;
  @override
  final int visitNum;
  @override
  final int comfortNum;
  @override
  final int itemNum;
  @override
  final String name;

  @override
  String toString() {
    return 'Home(level: $level, visitNum: $visitNum, comfortNum: $comfortNum, itemNum: $itemNum, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Home &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality().equals(other.visitNum, visitNum) &&
            const DeepCollectionEquality()
                .equals(other.comfortNum, comfortNum) &&
            const DeepCollectionEquality().equals(other.itemNum, itemNum) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(visitNum),
      const DeepCollectionEquality().hash(comfortNum),
      const DeepCollectionEquality().hash(itemNum),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$HomeCopyWith<_Home> get copyWith =>
      __$HomeCopyWithImpl<_Home>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HomeToJson(this);
  }
}

abstract class _Home implements Home {
  factory _Home(
      {required int level,
      required int visitNum,
      required int comfortNum,
      required int itemNum,
      required String name}) = _$_Home;

  factory _Home.fromJson(Map<String, dynamic> json) = _$_Home.fromJson;

  @override
  int get level;
  @override
  int get visitNum;
  @override
  int get comfortNum;
  @override
  int get itemNum;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$HomeCopyWith<_Home> get copyWith => throw _privateConstructorUsedError;
}
