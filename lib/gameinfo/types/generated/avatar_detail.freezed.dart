// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../avatar_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AvatarDetail _$AvatarDetailFromJson(Map<String, dynamic> json) {
  return _AvatarDetail.fromJson(json);
}

/// @nodoc
class _$AvatarDetailTearOff {
  const _$AvatarDetailTearOff();

  _AvatarDetail call(
      {required AvatarDetailWeapon weapon,
      required List<AvatarDetailSkill> skillList,
      required List<AvatarDetailReliquary> reliquaryList}) {
    return _AvatarDetail(
      weapon: weapon,
      skillList: skillList,
      reliquaryList: reliquaryList,
    );
  }

  AvatarDetail fromJson(Map<String, Object?> json) {
    return AvatarDetail.fromJson(json);
  }
}

/// @nodoc
const $AvatarDetail = _$AvatarDetailTearOff();

/// @nodoc
mixin _$AvatarDetail {
  AvatarDetailWeapon get weapon => throw _privateConstructorUsedError;
  List<AvatarDetailSkill> get skillList => throw _privateConstructorUsedError;
  List<AvatarDetailReliquary> get reliquaryList =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarDetailCopyWith<AvatarDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarDetailCopyWith<$Res> {
  factory $AvatarDetailCopyWith(
          AvatarDetail value, $Res Function(AvatarDetail) then) =
      _$AvatarDetailCopyWithImpl<$Res>;
  $Res call(
      {AvatarDetailWeapon weapon,
      List<AvatarDetailSkill> skillList,
      List<AvatarDetailReliquary> reliquaryList});

  $AvatarDetailWeaponCopyWith<$Res> get weapon;
}

/// @nodoc
class _$AvatarDetailCopyWithImpl<$Res> implements $AvatarDetailCopyWith<$Res> {
  _$AvatarDetailCopyWithImpl(this._value, this._then);

  final AvatarDetail _value;
  // ignore: unused_field
  final $Res Function(AvatarDetail) _then;

  @override
  $Res call({
    Object? weapon = freezed,
    Object? skillList = freezed,
    Object? reliquaryList = freezed,
  }) {
    return _then(_value.copyWith(
      weapon: weapon == freezed
          ? _value.weapon
          : weapon // ignore: cast_nullable_to_non_nullable
              as AvatarDetailWeapon,
      skillList: skillList == freezed
          ? _value.skillList
          : skillList // ignore: cast_nullable_to_non_nullable
              as List<AvatarDetailSkill>,
      reliquaryList: reliquaryList == freezed
          ? _value.reliquaryList
          : reliquaryList // ignore: cast_nullable_to_non_nullable
              as List<AvatarDetailReliquary>,
    ));
  }

  @override
  $AvatarDetailWeaponCopyWith<$Res> get weapon {
    return $AvatarDetailWeaponCopyWith<$Res>(_value.weapon, (value) {
      return _then(_value.copyWith(weapon: value));
    });
  }
}

/// @nodoc
abstract class _$AvatarDetailCopyWith<$Res>
    implements $AvatarDetailCopyWith<$Res> {
  factory _$AvatarDetailCopyWith(
          _AvatarDetail value, $Res Function(_AvatarDetail) then) =
      __$AvatarDetailCopyWithImpl<$Res>;
  @override
  $Res call(
      {AvatarDetailWeapon weapon,
      List<AvatarDetailSkill> skillList,
      List<AvatarDetailReliquary> reliquaryList});

  @override
  $AvatarDetailWeaponCopyWith<$Res> get weapon;
}

/// @nodoc
class __$AvatarDetailCopyWithImpl<$Res> extends _$AvatarDetailCopyWithImpl<$Res>
    implements _$AvatarDetailCopyWith<$Res> {
  __$AvatarDetailCopyWithImpl(
      _AvatarDetail _value, $Res Function(_AvatarDetail) _then)
      : super(_value, (v) => _then(v as _AvatarDetail));

  @override
  _AvatarDetail get _value => super._value as _AvatarDetail;

  @override
  $Res call({
    Object? weapon = freezed,
    Object? skillList = freezed,
    Object? reliquaryList = freezed,
  }) {
    return _then(_AvatarDetail(
      weapon: weapon == freezed
          ? _value.weapon
          : weapon // ignore: cast_nullable_to_non_nullable
              as AvatarDetailWeapon,
      skillList: skillList == freezed
          ? _value.skillList
          : skillList // ignore: cast_nullable_to_non_nullable
              as List<AvatarDetailSkill>,
      reliquaryList: reliquaryList == freezed
          ? _value.reliquaryList
          : reliquaryList // ignore: cast_nullable_to_non_nullable
              as List<AvatarDetailReliquary>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AvatarDetail implements _AvatarDetail {
  _$_AvatarDetail(
      {required this.weapon,
      required this.skillList,
      required this.reliquaryList});

  factory _$_AvatarDetail.fromJson(Map<String, dynamic> json) =>
      _$$_AvatarDetailFromJson(json);

  @override
  final AvatarDetailWeapon weapon;
  @override
  final List<AvatarDetailSkill> skillList;
  @override
  final List<AvatarDetailReliquary> reliquaryList;

  @override
  String toString() {
    return 'AvatarDetail(weapon: $weapon, skillList: $skillList, reliquaryList: $reliquaryList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AvatarDetail &&
            const DeepCollectionEquality().equals(other.weapon, weapon) &&
            const DeepCollectionEquality().equals(other.skillList, skillList) &&
            const DeepCollectionEquality()
                .equals(other.reliquaryList, reliquaryList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(weapon),
      const DeepCollectionEquality().hash(skillList),
      const DeepCollectionEquality().hash(reliquaryList));

  @JsonKey(ignore: true)
  @override
  _$AvatarDetailCopyWith<_AvatarDetail> get copyWith =>
      __$AvatarDetailCopyWithImpl<_AvatarDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvatarDetailToJson(this);
  }
}

abstract class _AvatarDetail implements AvatarDetail {
  factory _AvatarDetail(
      {required AvatarDetailWeapon weapon,
      required List<AvatarDetailSkill> skillList,
      required List<AvatarDetailReliquary> reliquaryList}) = _$_AvatarDetail;

  factory _AvatarDetail.fromJson(Map<String, dynamic> json) =
      _$_AvatarDetail.fromJson;

  @override
  AvatarDetailWeapon get weapon;
  @override
  List<AvatarDetailSkill> get skillList;
  @override
  List<AvatarDetailReliquary> get reliquaryList;
  @override
  @JsonKey(ignore: true)
  _$AvatarDetailCopyWith<_AvatarDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

AvatarDetailSkill _$AvatarDetailSkillFromJson(Map<String, dynamic> json) {
  return _AvatarDetailSkill.fromJson(json);
}

/// @nodoc
class _$AvatarDetailSkillTearOff {
  const _$AvatarDetailSkillTearOff();

  _AvatarDetailSkill call(
      {required int id,
      required int groupId,
      required String name,
      required String icon,
      required int maxLevel,
      required int levelCurrent}) {
    return _AvatarDetailSkill(
      id: id,
      groupId: groupId,
      name: name,
      icon: icon,
      maxLevel: maxLevel,
      levelCurrent: levelCurrent,
    );
  }

  AvatarDetailSkill fromJson(Map<String, Object?> json) {
    return AvatarDetailSkill.fromJson(json);
  }
}

/// @nodoc
const $AvatarDetailSkill = _$AvatarDetailSkillTearOff();

/// @nodoc
mixin _$AvatarDetailSkill {
  int get id => throw _privateConstructorUsedError;
  int get groupId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;
  int get levelCurrent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarDetailSkillCopyWith<AvatarDetailSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarDetailSkillCopyWith<$Res> {
  factory $AvatarDetailSkillCopyWith(
          AvatarDetailSkill value, $Res Function(AvatarDetailSkill) then) =
      _$AvatarDetailSkillCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int groupId,
      String name,
      String icon,
      int maxLevel,
      int levelCurrent});
}

/// @nodoc
class _$AvatarDetailSkillCopyWithImpl<$Res>
    implements $AvatarDetailSkillCopyWith<$Res> {
  _$AvatarDetailSkillCopyWithImpl(this._value, this._then);

  final AvatarDetailSkill _value;
  // ignore: unused_field
  final $Res Function(AvatarDetailSkill) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? groupId = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? maxLevel = freezed,
    Object? levelCurrent = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      levelCurrent: levelCurrent == freezed
          ? _value.levelCurrent
          : levelCurrent // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AvatarDetailSkillCopyWith<$Res>
    implements $AvatarDetailSkillCopyWith<$Res> {
  factory _$AvatarDetailSkillCopyWith(
          _AvatarDetailSkill value, $Res Function(_AvatarDetailSkill) then) =
      __$AvatarDetailSkillCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int groupId,
      String name,
      String icon,
      int maxLevel,
      int levelCurrent});
}

/// @nodoc
class __$AvatarDetailSkillCopyWithImpl<$Res>
    extends _$AvatarDetailSkillCopyWithImpl<$Res>
    implements _$AvatarDetailSkillCopyWith<$Res> {
  __$AvatarDetailSkillCopyWithImpl(
      _AvatarDetailSkill _value, $Res Function(_AvatarDetailSkill) _then)
      : super(_value, (v) => _then(v as _AvatarDetailSkill));

  @override
  _AvatarDetailSkill get _value => super._value as _AvatarDetailSkill;

  @override
  $Res call({
    Object? id = freezed,
    Object? groupId = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? maxLevel = freezed,
    Object? levelCurrent = freezed,
  }) {
    return _then(_AvatarDetailSkill(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      levelCurrent: levelCurrent == freezed
          ? _value.levelCurrent
          : levelCurrent // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AvatarDetailSkill implements _AvatarDetailSkill {
  _$_AvatarDetailSkill(
      {required this.id,
      required this.groupId,
      required this.name,
      required this.icon,
      required this.maxLevel,
      required this.levelCurrent});

  factory _$_AvatarDetailSkill.fromJson(Map<String, dynamic> json) =>
      _$$_AvatarDetailSkillFromJson(json);

  @override
  final int id;
  @override
  final int groupId;
  @override
  final String name;
  @override
  final String icon;
  @override
  final int maxLevel;
  @override
  final int levelCurrent;

  @override
  String toString() {
    return 'AvatarDetailSkill(id: $id, groupId: $groupId, name: $name, icon: $icon, maxLevel: $maxLevel, levelCurrent: $levelCurrent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AvatarDetailSkill &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality().equals(other.maxLevel, maxLevel) &&
            const DeepCollectionEquality()
                .equals(other.levelCurrent, levelCurrent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(groupId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(maxLevel),
      const DeepCollectionEquality().hash(levelCurrent));

  @JsonKey(ignore: true)
  @override
  _$AvatarDetailSkillCopyWith<_AvatarDetailSkill> get copyWith =>
      __$AvatarDetailSkillCopyWithImpl<_AvatarDetailSkill>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvatarDetailSkillToJson(this);
  }
}

abstract class _AvatarDetailSkill implements AvatarDetailSkill {
  factory _AvatarDetailSkill(
      {required int id,
      required int groupId,
      required String name,
      required String icon,
      required int maxLevel,
      required int levelCurrent}) = _$_AvatarDetailSkill;

  factory _AvatarDetailSkill.fromJson(Map<String, dynamic> json) =
      _$_AvatarDetailSkill.fromJson;

  @override
  int get id;
  @override
  int get groupId;
  @override
  String get name;
  @override
  String get icon;
  @override
  int get maxLevel;
  @override
  int get levelCurrent;
  @override
  @JsonKey(ignore: true)
  _$AvatarDetailSkillCopyWith<_AvatarDetailSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

AvatarDetailWeapon _$AvatarDetailWeaponFromJson(Map<String, dynamic> json) {
  return _AvatarDetailWeapon.fromJson(json);
}

/// @nodoc
class _$AvatarDetailWeaponTearOff {
  const _$AvatarDetailWeaponTearOff();

  _AvatarDetailWeapon call(
      {required int id,
      required int weaponCatId,
      required String name,
      required String icon,
      required int weaponLevel,
      required int levelCurrent,
      required int maxLevel}) {
    return _AvatarDetailWeapon(
      id: id,
      weaponCatId: weaponCatId,
      name: name,
      icon: icon,
      weaponLevel: weaponLevel,
      levelCurrent: levelCurrent,
      maxLevel: maxLevel,
    );
  }

  AvatarDetailWeapon fromJson(Map<String, Object?> json) {
    return AvatarDetailWeapon.fromJson(json);
  }
}

/// @nodoc
const $AvatarDetailWeapon = _$AvatarDetailWeaponTearOff();

/// @nodoc
mixin _$AvatarDetailWeapon {
  int get id => throw _privateConstructorUsedError;
  int get weaponCatId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  int get weaponLevel => throw _privateConstructorUsedError;
  int get levelCurrent => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarDetailWeaponCopyWith<AvatarDetailWeapon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarDetailWeaponCopyWith<$Res> {
  factory $AvatarDetailWeaponCopyWith(
          AvatarDetailWeapon value, $Res Function(AvatarDetailWeapon) then) =
      _$AvatarDetailWeaponCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int weaponCatId,
      String name,
      String icon,
      int weaponLevel,
      int levelCurrent,
      int maxLevel});
}

/// @nodoc
class _$AvatarDetailWeaponCopyWithImpl<$Res>
    implements $AvatarDetailWeaponCopyWith<$Res> {
  _$AvatarDetailWeaponCopyWithImpl(this._value, this._then);

  final AvatarDetailWeapon _value;
  // ignore: unused_field
  final $Res Function(AvatarDetailWeapon) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? weaponCatId = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? weaponLevel = freezed,
    Object? levelCurrent = freezed,
    Object? maxLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weaponCatId: weaponCatId == freezed
          ? _value.weaponCatId
          : weaponCatId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      weaponLevel: weaponLevel == freezed
          ? _value.weaponLevel
          : weaponLevel // ignore: cast_nullable_to_non_nullable
              as int,
      levelCurrent: levelCurrent == freezed
          ? _value.levelCurrent
          : levelCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AvatarDetailWeaponCopyWith<$Res>
    implements $AvatarDetailWeaponCopyWith<$Res> {
  factory _$AvatarDetailWeaponCopyWith(
          _AvatarDetailWeapon value, $Res Function(_AvatarDetailWeapon) then) =
      __$AvatarDetailWeaponCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int weaponCatId,
      String name,
      String icon,
      int weaponLevel,
      int levelCurrent,
      int maxLevel});
}

/// @nodoc
class __$AvatarDetailWeaponCopyWithImpl<$Res>
    extends _$AvatarDetailWeaponCopyWithImpl<$Res>
    implements _$AvatarDetailWeaponCopyWith<$Res> {
  __$AvatarDetailWeaponCopyWithImpl(
      _AvatarDetailWeapon _value, $Res Function(_AvatarDetailWeapon) _then)
      : super(_value, (v) => _then(v as _AvatarDetailWeapon));

  @override
  _AvatarDetailWeapon get _value => super._value as _AvatarDetailWeapon;

  @override
  $Res call({
    Object? id = freezed,
    Object? weaponCatId = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? weaponLevel = freezed,
    Object? levelCurrent = freezed,
    Object? maxLevel = freezed,
  }) {
    return _then(_AvatarDetailWeapon(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      weaponCatId: weaponCatId == freezed
          ? _value.weaponCatId
          : weaponCatId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      weaponLevel: weaponLevel == freezed
          ? _value.weaponLevel
          : weaponLevel // ignore: cast_nullable_to_non_nullable
              as int,
      levelCurrent: levelCurrent == freezed
          ? _value.levelCurrent
          : levelCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AvatarDetailWeapon implements _AvatarDetailWeapon {
  _$_AvatarDetailWeapon(
      {required this.id,
      required this.weaponCatId,
      required this.name,
      required this.icon,
      required this.weaponLevel,
      required this.levelCurrent,
      required this.maxLevel});

  factory _$_AvatarDetailWeapon.fromJson(Map<String, dynamic> json) =>
      _$$_AvatarDetailWeaponFromJson(json);

  @override
  final int id;
  @override
  final int weaponCatId;
  @override
  final String name;
  @override
  final String icon;
  @override
  final int weaponLevel;
  @override
  final int levelCurrent;
  @override
  final int maxLevel;

  @override
  String toString() {
    return 'AvatarDetailWeapon(id: $id, weaponCatId: $weaponCatId, name: $name, icon: $icon, weaponLevel: $weaponLevel, levelCurrent: $levelCurrent, maxLevel: $maxLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AvatarDetailWeapon &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.weaponCatId, weaponCatId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality()
                .equals(other.weaponLevel, weaponLevel) &&
            const DeepCollectionEquality()
                .equals(other.levelCurrent, levelCurrent) &&
            const DeepCollectionEquality().equals(other.maxLevel, maxLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(weaponCatId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(weaponLevel),
      const DeepCollectionEquality().hash(levelCurrent),
      const DeepCollectionEquality().hash(maxLevel));

  @JsonKey(ignore: true)
  @override
  _$AvatarDetailWeaponCopyWith<_AvatarDetailWeapon> get copyWith =>
      __$AvatarDetailWeaponCopyWithImpl<_AvatarDetailWeapon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvatarDetailWeaponToJson(this);
  }
}

abstract class _AvatarDetailWeapon implements AvatarDetailWeapon {
  factory _AvatarDetailWeapon(
      {required int id,
      required int weaponCatId,
      required String name,
      required String icon,
      required int weaponLevel,
      required int levelCurrent,
      required int maxLevel}) = _$_AvatarDetailWeapon;

  factory _AvatarDetailWeapon.fromJson(Map<String, dynamic> json) =
      _$_AvatarDetailWeapon.fromJson;

  @override
  int get id;
  @override
  int get weaponCatId;
  @override
  String get name;
  @override
  String get icon;
  @override
  int get weaponLevel;
  @override
  int get levelCurrent;
  @override
  int get maxLevel;
  @override
  @JsonKey(ignore: true)
  _$AvatarDetailWeaponCopyWith<_AvatarDetailWeapon> get copyWith =>
      throw _privateConstructorUsedError;
}

AvatarDetailReliquary _$AvatarDetailReliquaryFromJson(
    Map<String, dynamic> json) {
  return _AvatarDetailReliquary.fromJson(json);
}

/// @nodoc
class _$AvatarDetailReliquaryTearOff {
  const _$AvatarDetailReliquaryTearOff();

  _AvatarDetailReliquary call(
      {required int id,
      required int reliquaryCatId,
      required String name,
      required String icon,
      required int reliquaryLevel,
      required int levelCurrent,
      required int maxLevel}) {
    return _AvatarDetailReliquary(
      id: id,
      reliquaryCatId: reliquaryCatId,
      name: name,
      icon: icon,
      reliquaryLevel: reliquaryLevel,
      levelCurrent: levelCurrent,
      maxLevel: maxLevel,
    );
  }

  AvatarDetailReliquary fromJson(Map<String, Object?> json) {
    return AvatarDetailReliquary.fromJson(json);
  }
}

/// @nodoc
const $AvatarDetailReliquary = _$AvatarDetailReliquaryTearOff();

/// @nodoc
mixin _$AvatarDetailReliquary {
  int get id => throw _privateConstructorUsedError;
  int get reliquaryCatId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  int get reliquaryLevel => throw _privateConstructorUsedError;
  int get levelCurrent => throw _privateConstructorUsedError;
  int get maxLevel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarDetailReliquaryCopyWith<AvatarDetailReliquary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarDetailReliquaryCopyWith<$Res> {
  factory $AvatarDetailReliquaryCopyWith(AvatarDetailReliquary value,
          $Res Function(AvatarDetailReliquary) then) =
      _$AvatarDetailReliquaryCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int reliquaryCatId,
      String name,
      String icon,
      int reliquaryLevel,
      int levelCurrent,
      int maxLevel});
}

/// @nodoc
class _$AvatarDetailReliquaryCopyWithImpl<$Res>
    implements $AvatarDetailReliquaryCopyWith<$Res> {
  _$AvatarDetailReliquaryCopyWithImpl(this._value, this._then);

  final AvatarDetailReliquary _value;
  // ignore: unused_field
  final $Res Function(AvatarDetailReliquary) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? reliquaryCatId = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? reliquaryLevel = freezed,
    Object? levelCurrent = freezed,
    Object? maxLevel = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reliquaryCatId: reliquaryCatId == freezed
          ? _value.reliquaryCatId
          : reliquaryCatId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      reliquaryLevel: reliquaryLevel == freezed
          ? _value.reliquaryLevel
          : reliquaryLevel // ignore: cast_nullable_to_non_nullable
              as int,
      levelCurrent: levelCurrent == freezed
          ? _value.levelCurrent
          : levelCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AvatarDetailReliquaryCopyWith<$Res>
    implements $AvatarDetailReliquaryCopyWith<$Res> {
  factory _$AvatarDetailReliquaryCopyWith(_AvatarDetailReliquary value,
          $Res Function(_AvatarDetailReliquary) then) =
      __$AvatarDetailReliquaryCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int reliquaryCatId,
      String name,
      String icon,
      int reliquaryLevel,
      int levelCurrent,
      int maxLevel});
}

/// @nodoc
class __$AvatarDetailReliquaryCopyWithImpl<$Res>
    extends _$AvatarDetailReliquaryCopyWithImpl<$Res>
    implements _$AvatarDetailReliquaryCopyWith<$Res> {
  __$AvatarDetailReliquaryCopyWithImpl(_AvatarDetailReliquary _value,
      $Res Function(_AvatarDetailReliquary) _then)
      : super(_value, (v) => _then(v as _AvatarDetailReliquary));

  @override
  _AvatarDetailReliquary get _value => super._value as _AvatarDetailReliquary;

  @override
  $Res call({
    Object? id = freezed,
    Object? reliquaryCatId = freezed,
    Object? name = freezed,
    Object? icon = freezed,
    Object? reliquaryLevel = freezed,
    Object? levelCurrent = freezed,
    Object? maxLevel = freezed,
  }) {
    return _then(_AvatarDetailReliquary(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      reliquaryCatId: reliquaryCatId == freezed
          ? _value.reliquaryCatId
          : reliquaryCatId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      icon: icon == freezed
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      reliquaryLevel: reliquaryLevel == freezed
          ? _value.reliquaryLevel
          : reliquaryLevel // ignore: cast_nullable_to_non_nullable
              as int,
      levelCurrent: levelCurrent == freezed
          ? _value.levelCurrent
          : levelCurrent // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_AvatarDetailReliquary implements _AvatarDetailReliquary {
  _$_AvatarDetailReliquary(
      {required this.id,
      required this.reliquaryCatId,
      required this.name,
      required this.icon,
      required this.reliquaryLevel,
      required this.levelCurrent,
      required this.maxLevel});

  factory _$_AvatarDetailReliquary.fromJson(Map<String, dynamic> json) =>
      _$$_AvatarDetailReliquaryFromJson(json);

  @override
  final int id;
  @override
  final int reliquaryCatId;
  @override
  final String name;
  @override
  final String icon;
  @override
  final int reliquaryLevel;
  @override
  final int levelCurrent;
  @override
  final int maxLevel;

  @override
  String toString() {
    return 'AvatarDetailReliquary(id: $id, reliquaryCatId: $reliquaryCatId, name: $name, icon: $icon, reliquaryLevel: $reliquaryLevel, levelCurrent: $levelCurrent, maxLevel: $maxLevel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AvatarDetailReliquary &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.reliquaryCatId, reliquaryCatId) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.icon, icon) &&
            const DeepCollectionEquality()
                .equals(other.reliquaryLevel, reliquaryLevel) &&
            const DeepCollectionEquality()
                .equals(other.levelCurrent, levelCurrent) &&
            const DeepCollectionEquality().equals(other.maxLevel, maxLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(reliquaryCatId),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(icon),
      const DeepCollectionEquality().hash(reliquaryLevel),
      const DeepCollectionEquality().hash(levelCurrent),
      const DeepCollectionEquality().hash(maxLevel));

  @JsonKey(ignore: true)
  @override
  _$AvatarDetailReliquaryCopyWith<_AvatarDetailReliquary> get copyWith =>
      __$AvatarDetailReliquaryCopyWithImpl<_AvatarDetailReliquary>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AvatarDetailReliquaryToJson(this);
  }
}

abstract class _AvatarDetailReliquary implements AvatarDetailReliquary {
  factory _AvatarDetailReliquary(
      {required int id,
      required int reliquaryCatId,
      required String name,
      required String icon,
      required int reliquaryLevel,
      required int levelCurrent,
      required int maxLevel}) = _$_AvatarDetailReliquary;

  factory _AvatarDetailReliquary.fromJson(Map<String, dynamic> json) =
      _$_AvatarDetailReliquary.fromJson;

  @override
  int get id;
  @override
  int get reliquaryCatId;
  @override
  String get name;
  @override
  String get icon;
  @override
  int get reliquaryLevel;
  @override
  int get levelCurrent;
  @override
  int get maxLevel;
  @override
  @JsonKey(ignore: true)
  _$AvatarDetailReliquaryCopyWith<_AvatarDetailReliquary> get copyWith =>
      throw _privateConstructorUsedError;
}
