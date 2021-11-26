// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../artifact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSArtifact _$GSArtifactFromJson(Map<String, dynamic> json) {
  return _Artifact.fromJson(json);
}

/// @nodoc
class _$GSArtifactTearOff {
  const _$GSArtifactTearOff();

  _Artifact call(
      {required int id,
      required I18n name,
      required I18n desc,
      required int rarity,
      @EquipTypeStringConverter() required EquipType equipType,
      required int setId,
      required int appendPropDepotId,
      required int mainPropDepotId,
      int? maxLevel,
      int? appendPropNum}) {
    return _Artifact(
      id: id,
      name: name,
      desc: desc,
      rarity: rarity,
      equipType: equipType,
      setId: setId,
      appendPropDepotId: appendPropDepotId,
      mainPropDepotId: mainPropDepotId,
      maxLevel: maxLevel,
      appendPropNum: appendPropNum,
    );
  }

  GSArtifact fromJson(Map<String, Object?> json) {
    return GSArtifact.fromJson(json);
  }
}

/// @nodoc
const $GSArtifact = _$GSArtifactTearOff();

/// @nodoc
mixin _$GSArtifact {
  int get id => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  I18n get desc => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  @EquipTypeStringConverter()
  EquipType get equipType => throw _privateConstructorUsedError;
  int get setId => throw _privateConstructorUsedError;
  int get appendPropDepotId => throw _privateConstructorUsedError;
  int get mainPropDepotId => throw _privateConstructorUsedError;
  int? get maxLevel => throw _privateConstructorUsedError;
  int? get appendPropNum => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSArtifactCopyWith<GSArtifact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSArtifactCopyWith<$Res> {
  factory $GSArtifactCopyWith(
          GSArtifact value, $Res Function(GSArtifact) then) =
      _$GSArtifactCopyWithImpl<$Res>;
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      int rarity,
      @EquipTypeStringConverter() EquipType equipType,
      int setId,
      int appendPropDepotId,
      int mainPropDepotId,
      int? maxLevel,
      int? appendPropNum});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get desc;
}

/// @nodoc
class _$GSArtifactCopyWithImpl<$Res> implements $GSArtifactCopyWith<$Res> {
  _$GSArtifactCopyWithImpl(this._value, this._then);

  final GSArtifact _value;
  // ignore: unused_field
  final $Res Function(GSArtifact) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? rarity = freezed,
    Object? equipType = freezed,
    Object? setId = freezed,
    Object? appendPropDepotId = freezed,
    Object? mainPropDepotId = freezed,
    Object? maxLevel = freezed,
    Object? appendPropNum = freezed,
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
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as I18n,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      equipType: equipType == freezed
          ? _value.equipType
          : equipType // ignore: cast_nullable_to_non_nullable
              as EquipType,
      setId: setId == freezed
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as int,
      appendPropDepotId: appendPropDepotId == freezed
          ? _value.appendPropDepotId
          : appendPropDepotId // ignore: cast_nullable_to_non_nullable
              as int,
      mainPropDepotId: mainPropDepotId == freezed
          ? _value.mainPropDepotId
          : mainPropDepotId // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      appendPropNum: appendPropNum == freezed
          ? _value.appendPropNum
          : appendPropNum // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  @override
  $I18nCopyWith<$Res> get name {
    return $I18nCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value));
    });
  }

  @override
  $I18nCopyWith<$Res> get desc {
    return $I18nCopyWith<$Res>(_value.desc, (value) {
      return _then(_value.copyWith(desc: value));
    });
  }
}

/// @nodoc
abstract class _$ArtifactCopyWith<$Res> implements $GSArtifactCopyWith<$Res> {
  factory _$ArtifactCopyWith(_Artifact value, $Res Function(_Artifact) then) =
      __$ArtifactCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      int rarity,
      @EquipTypeStringConverter() EquipType equipType,
      int setId,
      int appendPropDepotId,
      int mainPropDepotId,
      int? maxLevel,
      int? appendPropNum});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get desc;
}

/// @nodoc
class __$ArtifactCopyWithImpl<$Res> extends _$GSArtifactCopyWithImpl<$Res>
    implements _$ArtifactCopyWith<$Res> {
  __$ArtifactCopyWithImpl(_Artifact _value, $Res Function(_Artifact) _then)
      : super(_value, (v) => _then(v as _Artifact));

  @override
  _Artifact get _value => super._value as _Artifact;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? rarity = freezed,
    Object? equipType = freezed,
    Object? setId = freezed,
    Object? appendPropDepotId = freezed,
    Object? mainPropDepotId = freezed,
    Object? maxLevel = freezed,
    Object? appendPropNum = freezed,
  }) {
    return _then(_Artifact(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as I18n,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      equipType: equipType == freezed
          ? _value.equipType
          : equipType // ignore: cast_nullable_to_non_nullable
              as EquipType,
      setId: setId == freezed
          ? _value.setId
          : setId // ignore: cast_nullable_to_non_nullable
              as int,
      appendPropDepotId: appendPropDepotId == freezed
          ? _value.appendPropDepotId
          : appendPropDepotId // ignore: cast_nullable_to_non_nullable
              as int,
      mainPropDepotId: mainPropDepotId == freezed
          ? _value.mainPropDepotId
          : mainPropDepotId // ignore: cast_nullable_to_non_nullable
              as int,
      maxLevel: maxLevel == freezed
          ? _value.maxLevel
          : maxLevel // ignore: cast_nullable_to_non_nullable
              as int?,
      appendPropNum: appendPropNum == freezed
          ? _value.appendPropNum
          : appendPropNum // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_Artifact extends _Artifact {
  _$_Artifact(
      {required this.id,
      required this.name,
      required this.desc,
      required this.rarity,
      @EquipTypeStringConverter() required this.equipType,
      required this.setId,
      required this.appendPropDepotId,
      required this.mainPropDepotId,
      this.maxLevel,
      this.appendPropNum})
      : super._();

  factory _$_Artifact.fromJson(Map<String, dynamic> json) =>
      _$$_ArtifactFromJson(json);

  @override
  final int id;
  @override
  final I18n name;
  @override
  final I18n desc;
  @override
  final int rarity;
  @override
  @EquipTypeStringConverter()
  final EquipType equipType;
  @override
  final int setId;
  @override
  final int appendPropDepotId;
  @override
  final int mainPropDepotId;
  @override
  final int? maxLevel;
  @override
  final int? appendPropNum;

  @override
  String toString() {
    return 'GSArtifact(id: $id, name: $name, desc: $desc, rarity: $rarity, equipType: $equipType, setId: $setId, appendPropDepotId: $appendPropDepotId, mainPropDepotId: $mainPropDepotId, maxLevel: $maxLevel, appendPropNum: $appendPropNum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Artifact &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.rarity, rarity) &&
            const DeepCollectionEquality().equals(other.equipType, equipType) &&
            const DeepCollectionEquality().equals(other.setId, setId) &&
            const DeepCollectionEquality()
                .equals(other.appendPropDepotId, appendPropDepotId) &&
            const DeepCollectionEquality()
                .equals(other.mainPropDepotId, mainPropDepotId) &&
            const DeepCollectionEquality().equals(other.maxLevel, maxLevel) &&
            const DeepCollectionEquality()
                .equals(other.appendPropNum, appendPropNum));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(rarity),
      const DeepCollectionEquality().hash(equipType),
      const DeepCollectionEquality().hash(setId),
      const DeepCollectionEquality().hash(appendPropDepotId),
      const DeepCollectionEquality().hash(mainPropDepotId),
      const DeepCollectionEquality().hash(maxLevel),
      const DeepCollectionEquality().hash(appendPropNum));

  @JsonKey(ignore: true)
  @override
  _$ArtifactCopyWith<_Artifact> get copyWith =>
      __$ArtifactCopyWithImpl<_Artifact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtifactToJson(this);
  }
}

abstract class _Artifact extends GSArtifact {
  factory _Artifact(
      {required int id,
      required I18n name,
      required I18n desc,
      required int rarity,
      @EquipTypeStringConverter() required EquipType equipType,
      required int setId,
      required int appendPropDepotId,
      required int mainPropDepotId,
      int? maxLevel,
      int? appendPropNum}) = _$_Artifact;
  _Artifact._() : super._();

  factory _Artifact.fromJson(Map<String, dynamic> json) = _$_Artifact.fromJson;

  @override
  int get id;
  @override
  I18n get name;
  @override
  I18n get desc;
  @override
  int get rarity;
  @override
  @EquipTypeStringConverter()
  EquipType get equipType;
  @override
  int get setId;
  @override
  int get appendPropDepotId;
  @override
  int get mainPropDepotId;
  @override
  int? get maxLevel;
  @override
  int? get appendPropNum;
  @override
  @JsonKey(ignore: true)
  _$ArtifactCopyWith<_Artifact> get copyWith =>
      throw _privateConstructorUsedError;
}

GSArtifactSet _$GSArtifactSetFromJson(Map<String, dynamic> json) {
  return _ArtifactSet.fromJson(json);
}

/// @nodoc
class _$GSArtifactSetTearOff {
  const _$GSArtifactSetTearOff();

  _ArtifactSet call(
      {required int id,
      required I18n name,
      required List<EquipAffix> equipAffixes,
      int? activeNum,
      Map<EquipType, GSArtifact>? artifacts}) {
    return _ArtifactSet(
      id: id,
      name: name,
      equipAffixes: equipAffixes,
      activeNum: activeNum,
      artifacts: artifacts,
    );
  }

  GSArtifactSet fromJson(Map<String, Object?> json) {
    return GSArtifactSet.fromJson(json);
  }
}

/// @nodoc
const $GSArtifactSet = _$GSArtifactSetTearOff();

/// @nodoc
mixin _$GSArtifactSet {
  int get id => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  List<EquipAffix> get equipAffixes => throw _privateConstructorUsedError;
  int? get activeNum => throw _privateConstructorUsedError;
  Map<EquipType, GSArtifact>? get artifacts =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSArtifactSetCopyWith<GSArtifactSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSArtifactSetCopyWith<$Res> {
  factory $GSArtifactSetCopyWith(
          GSArtifactSet value, $Res Function(GSArtifactSet) then) =
      _$GSArtifactSetCopyWithImpl<$Res>;
  $Res call(
      {int id,
      I18n name,
      List<EquipAffix> equipAffixes,
      int? activeNum,
      Map<EquipType, GSArtifact>? artifacts});

  $I18nCopyWith<$Res> get name;
}

/// @nodoc
class _$GSArtifactSetCopyWithImpl<$Res>
    implements $GSArtifactSetCopyWith<$Res> {
  _$GSArtifactSetCopyWithImpl(this._value, this._then);

  final GSArtifactSet _value;
  // ignore: unused_field
  final $Res Function(GSArtifactSet) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? equipAffixes = freezed,
    Object? activeNum = freezed,
    Object? artifacts = freezed,
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
      equipAffixes: equipAffixes == freezed
          ? _value.equipAffixes
          : equipAffixes // ignore: cast_nullable_to_non_nullable
              as List<EquipAffix>,
      activeNum: activeNum == freezed
          ? _value.activeNum
          : activeNum // ignore: cast_nullable_to_non_nullable
              as int?,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as Map<EquipType, GSArtifact>?,
    ));
  }

  @override
  $I18nCopyWith<$Res> get name {
    return $I18nCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value));
    });
  }
}

/// @nodoc
abstract class _$ArtifactSetCopyWith<$Res>
    implements $GSArtifactSetCopyWith<$Res> {
  factory _$ArtifactSetCopyWith(
          _ArtifactSet value, $Res Function(_ArtifactSet) then) =
      __$ArtifactSetCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      I18n name,
      List<EquipAffix> equipAffixes,
      int? activeNum,
      Map<EquipType, GSArtifact>? artifacts});

  @override
  $I18nCopyWith<$Res> get name;
}

/// @nodoc
class __$ArtifactSetCopyWithImpl<$Res> extends _$GSArtifactSetCopyWithImpl<$Res>
    implements _$ArtifactSetCopyWith<$Res> {
  __$ArtifactSetCopyWithImpl(
      _ArtifactSet _value, $Res Function(_ArtifactSet) _then)
      : super(_value, (v) => _then(v as _ArtifactSet));

  @override
  _ArtifactSet get _value => super._value as _ArtifactSet;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? equipAffixes = freezed,
    Object? activeNum = freezed,
    Object? artifacts = freezed,
  }) {
    return _then(_ArtifactSet(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      equipAffixes: equipAffixes == freezed
          ? _value.equipAffixes
          : equipAffixes // ignore: cast_nullable_to_non_nullable
              as List<EquipAffix>,
      activeNum: activeNum == freezed
          ? _value.activeNum
          : activeNum // ignore: cast_nullable_to_non_nullable
              as int?,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as Map<EquipType, GSArtifact>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_ArtifactSet extends _ArtifactSet {
  _$_ArtifactSet(
      {required this.id,
      required this.name,
      required this.equipAffixes,
      this.activeNum,
      this.artifacts})
      : super._();

  factory _$_ArtifactSet.fromJson(Map<String, dynamic> json) =>
      _$$_ArtifactSetFromJson(json);

  @override
  final int id;
  @override
  final I18n name;
  @override
  final List<EquipAffix> equipAffixes;
  @override
  final int? activeNum;
  @override
  final Map<EquipType, GSArtifact>? artifacts;

  @override
  String toString() {
    return 'GSArtifactSet(id: $id, name: $name, equipAffixes: $equipAffixes, activeNum: $activeNum, artifacts: $artifacts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtifactSet &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.equipAffixes, equipAffixes) &&
            const DeepCollectionEquality().equals(other.activeNum, activeNum) &&
            const DeepCollectionEquality().equals(other.artifacts, artifacts));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(equipAffixes),
      const DeepCollectionEquality().hash(activeNum),
      const DeepCollectionEquality().hash(artifacts));

  @JsonKey(ignore: true)
  @override
  _$ArtifactSetCopyWith<_ArtifactSet> get copyWith =>
      __$ArtifactSetCopyWithImpl<_ArtifactSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtifactSetToJson(this);
  }
}

abstract class _ArtifactSet extends GSArtifactSet {
  factory _ArtifactSet(
      {required int id,
      required I18n name,
      required List<EquipAffix> equipAffixes,
      int? activeNum,
      Map<EquipType, GSArtifact>? artifacts}) = _$_ArtifactSet;
  _ArtifactSet._() : super._();

  factory _ArtifactSet.fromJson(Map<String, dynamic> json) =
      _$_ArtifactSet.fromJson;

  @override
  int get id;
  @override
  I18n get name;
  @override
  List<EquipAffix> get equipAffixes;
  @override
  int? get activeNum;
  @override
  Map<EquipType, GSArtifact>? get artifacts;
  @override
  @JsonKey(ignore: true)
  _$ArtifactSetCopyWith<_ArtifactSet> get copyWith =>
      throw _privateConstructorUsedError;
}

GSArtifactAppendDepot _$GSArtifactAppendDepotFromJson(
    Map<String, dynamic> json) {
  return _GSArtifactAppendDepot.fromJson(json);
}

/// @nodoc
class _$GSArtifactAppendDepotTearOff {
  const _$GSArtifactAppendDepotTearOff();

  _GSArtifactAppendDepot call(Map<FightProp, List<double>> values) {
    return _GSArtifactAppendDepot(
      values,
    );
  }

  GSArtifactAppendDepot fromJson(Map<String, Object?> json) {
    return GSArtifactAppendDepot.fromJson(json);
  }
}

/// @nodoc
const $GSArtifactAppendDepot = _$GSArtifactAppendDepotTearOff();

/// @nodoc
mixin _$GSArtifactAppendDepot {
  Map<FightProp, List<double>> get values => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSArtifactAppendDepotCopyWith<GSArtifactAppendDepot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSArtifactAppendDepotCopyWith<$Res> {
  factory $GSArtifactAppendDepotCopyWith(GSArtifactAppendDepot value,
          $Res Function(GSArtifactAppendDepot) then) =
      _$GSArtifactAppendDepotCopyWithImpl<$Res>;
  $Res call({Map<FightProp, List<double>> values});
}

/// @nodoc
class _$GSArtifactAppendDepotCopyWithImpl<$Res>
    implements $GSArtifactAppendDepotCopyWith<$Res> {
  _$GSArtifactAppendDepotCopyWithImpl(this._value, this._then);

  final GSArtifactAppendDepot _value;
  // ignore: unused_field
  final $Res Function(GSArtifactAppendDepot) _then;

  @override
  $Res call({
    Object? values = freezed,
  }) {
    return _then(_value.copyWith(
      values: values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, List<double>>,
    ));
  }
}

/// @nodoc
abstract class _$GSArtifactAppendDepotCopyWith<$Res>
    implements $GSArtifactAppendDepotCopyWith<$Res> {
  factory _$GSArtifactAppendDepotCopyWith(_GSArtifactAppendDepot value,
          $Res Function(_GSArtifactAppendDepot) then) =
      __$GSArtifactAppendDepotCopyWithImpl<$Res>;
  @override
  $Res call({Map<FightProp, List<double>> values});
}

/// @nodoc
class __$GSArtifactAppendDepotCopyWithImpl<$Res>
    extends _$GSArtifactAppendDepotCopyWithImpl<$Res>
    implements _$GSArtifactAppendDepotCopyWith<$Res> {
  __$GSArtifactAppendDepotCopyWithImpl(_GSArtifactAppendDepot _value,
      $Res Function(_GSArtifactAppendDepot) _then)
      : super(_value, (v) => _then(v as _GSArtifactAppendDepot));

  @override
  _GSArtifactAppendDepot get _value => super._value as _GSArtifactAppendDepot;

  @override
  $Res call({
    Object? values = freezed,
  }) {
    return _then(_GSArtifactAppendDepot(
      values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<FightProp, List<double>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FightPropStringConverter()
class _$_GSArtifactAppendDepot extends _GSArtifactAppendDepot {
  _$_GSArtifactAppendDepot(this.values) : super._();

  factory _$_GSArtifactAppendDepot.fromJson(Map<String, dynamic> json) =>
      _$$_GSArtifactAppendDepotFromJson(json);

  @override
  final Map<FightProp, List<double>> values;

  @override
  String toString() {
    return 'GSArtifactAppendDepot(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GSArtifactAppendDepot &&
            const DeepCollectionEquality().equals(other.values, values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(values));

  @JsonKey(ignore: true)
  @override
  _$GSArtifactAppendDepotCopyWith<_GSArtifactAppendDepot> get copyWith =>
      __$GSArtifactAppendDepotCopyWithImpl<_GSArtifactAppendDepot>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GSArtifactAppendDepotToJson(this);
  }
}

abstract class _GSArtifactAppendDepot extends GSArtifactAppendDepot {
  factory _GSArtifactAppendDepot(Map<FightProp, List<double>> values) =
      _$_GSArtifactAppendDepot;
  _GSArtifactAppendDepot._() : super._();

  factory _GSArtifactAppendDepot.fromJson(Map<String, dynamic> json) =
      _$_GSArtifactAppendDepot.fromJson;

  @override
  Map<FightProp, List<double>> get values;
  @override
  @JsonKey(ignore: true)
  _$GSArtifactAppendDepotCopyWith<_GSArtifactAppendDepot> get copyWith =>
      throw _privateConstructorUsedError;
}
