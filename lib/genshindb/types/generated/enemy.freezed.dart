// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../enemy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSEnemy _$GSEnemyFromJson(Map<String, dynamic> json) {
  return _Enemy.fromJson(json);
}

/// @nodoc
class _$GSEnemyTearOff {
  const _$GSEnemyTearOff();

  _Enemy call(
      {required int id,
      required I18n name,
      required String dropTag,
      required String type,
      required GSMonsterRarity monsterRarity,
      I18n? title,
      I18n? specialName,
      FightProps? addProps}) {
    return _Enemy(
      id: id,
      name: name,
      dropTag: dropTag,
      type: type,
      monsterRarity: monsterRarity,
      title: title,
      specialName: specialName,
      addProps: addProps,
    );
  }

  GSEnemy fromJson(Map<String, Object?> json) {
    return GSEnemy.fromJson(json);
  }
}

/// @nodoc
const $GSEnemy = _$GSEnemyTearOff();

/// @nodoc
mixin _$GSEnemy {
  int get id => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  String get dropTag => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  GSMonsterRarity get monsterRarity => throw _privateConstructorUsedError;
  I18n? get title => throw _privateConstructorUsedError;
  I18n? get specialName => throw _privateConstructorUsedError;
  FightProps? get addProps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSEnemyCopyWith<GSEnemy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSEnemyCopyWith<$Res> {
  factory $GSEnemyCopyWith(GSEnemy value, $Res Function(GSEnemy) then) =
      _$GSEnemyCopyWithImpl<$Res>;
  $Res call(
      {int id,
      I18n name,
      String dropTag,
      String type,
      GSMonsterRarity monsterRarity,
      I18n? title,
      I18n? specialName,
      FightProps? addProps});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res>? get title;
  $I18nCopyWith<$Res>? get specialName;
  $FightPropsCopyWith<$Res>? get addProps;
}

/// @nodoc
class _$GSEnemyCopyWithImpl<$Res> implements $GSEnemyCopyWith<$Res> {
  _$GSEnemyCopyWithImpl(this._value, this._then);

  final GSEnemy _value;
  // ignore: unused_field
  final $Res Function(GSEnemy) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? dropTag = freezed,
    Object? type = freezed,
    Object? monsterRarity = freezed,
    Object? title = freezed,
    Object? specialName = freezed,
    Object? addProps = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      dropTag: dropTag == freezed
          ? _value.dropTag
          : dropTag // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      monsterRarity: monsterRarity == freezed
          ? _value.monsterRarity
          : monsterRarity // ignore: cast_nullable_to_non_nullable
              as GSMonsterRarity,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as I18n?,
      specialName: specialName == freezed
          ? _value.specialName
          : specialName // ignore: cast_nullable_to_non_nullable
              as I18n?,
      addProps: addProps == freezed
          ? _value.addProps
          : addProps // ignore: cast_nullable_to_non_nullable
              as FightProps?,
    ));
  }

  @override
  $I18nCopyWith<$Res> get name {
    return $I18nCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value));
    });
  }

  @override
  $I18nCopyWith<$Res>? get title {
    if (_value.title == null) {
      return null;
    }

    return $I18nCopyWith<$Res>(_value.title!, (value) {
      return _then(_value.copyWith(title: value));
    });
  }

  @override
  $I18nCopyWith<$Res>? get specialName {
    if (_value.specialName == null) {
      return null;
    }

    return $I18nCopyWith<$Res>(_value.specialName!, (value) {
      return _then(_value.copyWith(specialName: value));
    });
  }

  @override
  $FightPropsCopyWith<$Res>? get addProps {
    if (_value.addProps == null) {
      return null;
    }

    return $FightPropsCopyWith<$Res>(_value.addProps!, (value) {
      return _then(_value.copyWith(addProps: value));
    });
  }
}

/// @nodoc
abstract class _$EnemyCopyWith<$Res> implements $GSEnemyCopyWith<$Res> {
  factory _$EnemyCopyWith(_Enemy value, $Res Function(_Enemy) then) =
      __$EnemyCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      I18n name,
      String dropTag,
      String type,
      GSMonsterRarity monsterRarity,
      I18n? title,
      I18n? specialName,
      FightProps? addProps});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res>? get title;
  @override
  $I18nCopyWith<$Res>? get specialName;
  @override
  $FightPropsCopyWith<$Res>? get addProps;
}

/// @nodoc
class __$EnemyCopyWithImpl<$Res> extends _$GSEnemyCopyWithImpl<$Res>
    implements _$EnemyCopyWith<$Res> {
  __$EnemyCopyWithImpl(_Enemy _value, $Res Function(_Enemy) _then)
      : super(_value, (v) => _then(v as _Enemy));

  @override
  _Enemy get _value => super._value as _Enemy;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? dropTag = freezed,
    Object? type = freezed,
    Object? monsterRarity = freezed,
    Object? title = freezed,
    Object? specialName = freezed,
    Object? addProps = freezed,
  }) {
    return _then(_Enemy(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      dropTag: dropTag == freezed
          ? _value.dropTag
          : dropTag // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      monsterRarity: monsterRarity == freezed
          ? _value.monsterRarity
          : monsterRarity // ignore: cast_nullable_to_non_nullable
              as GSMonsterRarity,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as I18n?,
      specialName: specialName == freezed
          ? _value.specialName
          : specialName // ignore: cast_nullable_to_non_nullable
              as I18n?,
      addProps: addProps == freezed
          ? _value.addProps
          : addProps // ignore: cast_nullable_to_non_nullable
              as FightProps?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_Enemy extends _Enemy {
  _$_Enemy(
      {required this.id,
      required this.name,
      required this.dropTag,
      required this.type,
      required this.monsterRarity,
      this.title,
      this.specialName,
      this.addProps})
      : super._();

  factory _$_Enemy.fromJson(Map<String, dynamic> json) =>
      _$$_EnemyFromJson(json);

  @override
  final int id;
  @override
  final I18n name;
  @override
  final String dropTag;
  @override
  final String type;
  @override
  final GSMonsterRarity monsterRarity;
  @override
  final I18n? title;
  @override
  final I18n? specialName;
  @override
  final FightProps? addProps;

  @override
  String toString() {
    return 'GSEnemy(id: $id, name: $name, dropTag: $dropTag, type: $type, monsterRarity: $monsterRarity, title: $title, specialName: $specialName, addProps: $addProps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Enemy &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.dropTag, dropTag) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other.monsterRarity, monsterRarity) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.specialName, specialName) &&
            const DeepCollectionEquality().equals(other.addProps, addProps));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(dropTag),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(monsterRarity),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(specialName),
      const DeepCollectionEquality().hash(addProps));

  @JsonKey(ignore: true)
  @override
  _$EnemyCopyWith<_Enemy> get copyWith =>
      __$EnemyCopyWithImpl<_Enemy>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EnemyToJson(this);
  }
}

abstract class _Enemy extends GSEnemy {
  factory _Enemy(
      {required int id,
      required I18n name,
      required String dropTag,
      required String type,
      required GSMonsterRarity monsterRarity,
      I18n? title,
      I18n? specialName,
      FightProps? addProps}) = _$_Enemy;
  _Enemy._() : super._();

  factory _Enemy.fromJson(Map<String, dynamic> json) = _$_Enemy.fromJson;

  @override
  int get id;
  @override
  I18n get name;
  @override
  String get dropTag;
  @override
  String get type;
  @override
  GSMonsterRarity get monsterRarity;
  @override
  I18n? get title;
  @override
  I18n? get specialName;
  @override
  FightProps? get addProps;
  @override
  @JsonKey(ignore: true)
  _$EnemyCopyWith<_Enemy> get copyWith => throw _privateConstructorUsedError;
}
