// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../good.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GOOD _$GOODFromJson(Map<String, dynamic> json) {
  return _GOOD.fromJson(json);
}

/// @nodoc
class _$GOODTearOff {
  const _$GOODTearOff();

  _GOOD call(
      {String format = "GOOD",
      double version = 1,
      String source = "dev.morlay.genshintools",
      required List<GOODCharacter> characters,
      required List<GOODArtifact> artifacts,
      required List<GOODWeapon> weapons,
      required Map<String, double> materials}) {
    return _GOOD(
      format: format,
      version: version,
      source: source,
      characters: characters,
      artifacts: artifacts,
      weapons: weapons,
      materials: materials,
    );
  }

  GOOD fromJson(Map<String, Object?> json) {
    return GOOD.fromJson(json);
  }
}

/// @nodoc
const $GOOD = _$GOODTearOff();

/// @nodoc
mixin _$GOOD {
  String get format => throw _privateConstructorUsedError;
  double get version => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  List<GOODCharacter> get characters => throw _privateConstructorUsedError;
  List<GOODArtifact> get artifacts => throw _privateConstructorUsedError;
  List<GOODWeapon> get weapons => throw _privateConstructorUsedError;
  Map<String, double> get materials => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GOODCopyWith<GOOD> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GOODCopyWith<$Res> {
  factory $GOODCopyWith(GOOD value, $Res Function(GOOD) then) =
      _$GOODCopyWithImpl<$Res>;
  $Res call(
      {String format,
      double version,
      String source,
      List<GOODCharacter> characters,
      List<GOODArtifact> artifacts,
      List<GOODWeapon> weapons,
      Map<String, double> materials});
}

/// @nodoc
class _$GOODCopyWithImpl<$Res> implements $GOODCopyWith<$Res> {
  _$GOODCopyWithImpl(this._value, this._then);

  final GOOD _value;
  // ignore: unused_field
  final $Res Function(GOOD) _then;

  @override
  $Res call({
    Object? format = freezed,
    Object? version = freezed,
    Object? source = freezed,
    Object? characters = freezed,
    Object? artifacts = freezed,
    Object? weapons = freezed,
    Object? materials = freezed,
  }) {
    return _then(_value.copyWith(
      format: format == freezed
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as double,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<GOODCharacter>,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as List<GOODArtifact>,
      weapons: weapons == freezed
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as List<GOODWeapon>,
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
abstract class _$GOODCopyWith<$Res> implements $GOODCopyWith<$Res> {
  factory _$GOODCopyWith(_GOOD value, $Res Function(_GOOD) then) =
      __$GOODCopyWithImpl<$Res>;
  @override
  $Res call(
      {String format,
      double version,
      String source,
      List<GOODCharacter> characters,
      List<GOODArtifact> artifacts,
      List<GOODWeapon> weapons,
      Map<String, double> materials});
}

/// @nodoc
class __$GOODCopyWithImpl<$Res> extends _$GOODCopyWithImpl<$Res>
    implements _$GOODCopyWith<$Res> {
  __$GOODCopyWithImpl(_GOOD _value, $Res Function(_GOOD) _then)
      : super(_value, (v) => _then(v as _GOOD));

  @override
  _GOOD get _value => super._value as _GOOD;

  @override
  $Res call({
    Object? format = freezed,
    Object? version = freezed,
    Object? source = freezed,
    Object? characters = freezed,
    Object? artifacts = freezed,
    Object? weapons = freezed,
    Object? materials = freezed,
  }) {
    return _then(_GOOD(
      format: format == freezed
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as double,
      source: source == freezed
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      characters: characters == freezed
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as List<GOODCharacter>,
      artifacts: artifacts == freezed
          ? _value.artifacts
          : artifacts // ignore: cast_nullable_to_non_nullable
              as List<GOODArtifact>,
      weapons: weapons == freezed
          ? _value.weapons
          : weapons // ignore: cast_nullable_to_non_nullable
              as List<GOODWeapon>,
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GOOD extends _GOOD {
  _$_GOOD(
      {this.format = "GOOD",
      this.version = 1,
      this.source = "dev.morlay.genshintools",
      required this.characters,
      required this.artifacts,
      required this.weapons,
      required this.materials})
      : super._();

  factory _$_GOOD.fromJson(Map<String, dynamic> json) => _$$_GOODFromJson(json);

  @JsonKey()
  @override
  final String format;
  @JsonKey()
  @override
  final double version;
  @JsonKey()
  @override
  final String source;
  @override
  final List<GOODCharacter> characters;
  @override
  final List<GOODArtifact> artifacts;
  @override
  final List<GOODWeapon> weapons;
  @override
  final Map<String, double> materials;

  @override
  String toString() {
    return 'GOOD(format: $format, version: $version, source: $source, characters: $characters, artifacts: $artifacts, weapons: $weapons, materials: $materials)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GOOD &&
            const DeepCollectionEquality().equals(other.format, format) &&
            const DeepCollectionEquality().equals(other.version, version) &&
            const DeepCollectionEquality().equals(other.source, source) &&
            const DeepCollectionEquality()
                .equals(other.characters, characters) &&
            const DeepCollectionEquality().equals(other.artifacts, artifacts) &&
            const DeepCollectionEquality().equals(other.weapons, weapons) &&
            const DeepCollectionEquality().equals(other.materials, materials));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(format),
      const DeepCollectionEquality().hash(version),
      const DeepCollectionEquality().hash(source),
      const DeepCollectionEquality().hash(characters),
      const DeepCollectionEquality().hash(artifacts),
      const DeepCollectionEquality().hash(weapons),
      const DeepCollectionEquality().hash(materials));

  @JsonKey(ignore: true)
  @override
  _$GOODCopyWith<_GOOD> get copyWith =>
      __$GOODCopyWithImpl<_GOOD>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GOODToJson(this);
  }
}

abstract class _GOOD extends GOOD {
  factory _GOOD(
      {String format,
      double version,
      String source,
      required List<GOODCharacter> characters,
      required List<GOODArtifact> artifacts,
      required List<GOODWeapon> weapons,
      required Map<String, double> materials}) = _$_GOOD;
  _GOOD._() : super._();

  factory _GOOD.fromJson(Map<String, dynamic> json) = _$_GOOD.fromJson;

  @override
  String get format;
  @override
  double get version;
  @override
  String get source;
  @override
  List<GOODCharacter> get characters;
  @override
  List<GOODArtifact> get artifacts;
  @override
  List<GOODWeapon> get weapons;
  @override
  Map<String, double> get materials;
  @override
  @JsonKey(ignore: true)
  _$GOODCopyWith<_GOOD> get copyWith => throw _privateConstructorUsedError;
}

GOODCharacter _$GOODCharacterFromJson(Map<String, dynamic> json) {
  return _GOODCharacter.fromJson(json);
}

/// @nodoc
class _$GOODCharacterTearOff {
  const _$GOODCharacterTearOff();

  _GOODCharacter call(
      {required String key,
      required int level,
      required int constellation,
      required int ascension,
      required Map<TalentType, int> talent}) {
    return _GOODCharacter(
      key: key,
      level: level,
      constellation: constellation,
      ascension: ascension,
      talent: talent,
    );
  }

  GOODCharacter fromJson(Map<String, Object?> json) {
    return GOODCharacter.fromJson(json);
  }
}

/// @nodoc
const $GOODCharacter = _$GOODCharacterTearOff();

/// @nodoc
mixin _$GOODCharacter {
  String get key => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get constellation => throw _privateConstructorUsedError;
  int get ascension => throw _privateConstructorUsedError;
  Map<TalentType, int> get talent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GOODCharacterCopyWith<GOODCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GOODCharacterCopyWith<$Res> {
  factory $GOODCharacterCopyWith(
          GOODCharacter value, $Res Function(GOODCharacter) then) =
      _$GOODCharacterCopyWithImpl<$Res>;
  $Res call(
      {String key,
      int level,
      int constellation,
      int ascension,
      Map<TalentType, int> talent});
}

/// @nodoc
class _$GOODCharacterCopyWithImpl<$Res>
    implements $GOODCharacterCopyWith<$Res> {
  _$GOODCharacterCopyWithImpl(this._value, this._then);

  final GOODCharacter _value;
  // ignore: unused_field
  final $Res Function(GOODCharacter) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? level = freezed,
    Object? constellation = freezed,
    Object? ascension = freezed,
    Object? talent = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      constellation: constellation == freezed
          ? _value.constellation
          : constellation // ignore: cast_nullable_to_non_nullable
              as int,
      ascension: ascension == freezed
          ? _value.ascension
          : ascension // ignore: cast_nullable_to_non_nullable
              as int,
      talent: talent == freezed
          ? _value.talent
          : talent // ignore: cast_nullable_to_non_nullable
              as Map<TalentType, int>,
    ));
  }
}

/// @nodoc
abstract class _$GOODCharacterCopyWith<$Res>
    implements $GOODCharacterCopyWith<$Res> {
  factory _$GOODCharacterCopyWith(
          _GOODCharacter value, $Res Function(_GOODCharacter) then) =
      __$GOODCharacterCopyWithImpl<$Res>;
  @override
  $Res call(
      {String key,
      int level,
      int constellation,
      int ascension,
      Map<TalentType, int> talent});
}

/// @nodoc
class __$GOODCharacterCopyWithImpl<$Res>
    extends _$GOODCharacterCopyWithImpl<$Res>
    implements _$GOODCharacterCopyWith<$Res> {
  __$GOODCharacterCopyWithImpl(
      _GOODCharacter _value, $Res Function(_GOODCharacter) _then)
      : super(_value, (v) => _then(v as _GOODCharacter));

  @override
  _GOODCharacter get _value => super._value as _GOODCharacter;

  @override
  $Res call({
    Object? key = freezed,
    Object? level = freezed,
    Object? constellation = freezed,
    Object? ascension = freezed,
    Object? talent = freezed,
  }) {
    return _then(_GOODCharacter(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      constellation: constellation == freezed
          ? _value.constellation
          : constellation // ignore: cast_nullable_to_non_nullable
              as int,
      ascension: ascension == freezed
          ? _value.ascension
          : ascension // ignore: cast_nullable_to_non_nullable
              as int,
      talent: talent == freezed
          ? _value.talent
          : talent // ignore: cast_nullable_to_non_nullable
              as Map<TalentType, int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GOODCharacter extends _GOODCharacter {
  _$_GOODCharacter(
      {required this.key,
      required this.level,
      required this.constellation,
      required this.ascension,
      required this.talent})
      : super._();

  factory _$_GOODCharacter.fromJson(Map<String, dynamic> json) =>
      _$$_GOODCharacterFromJson(json);

  @override
  final String key;
  @override
  final int level;
  @override
  final int constellation;
  @override
  final int ascension;
  @override
  final Map<TalentType, int> talent;

  @override
  String toString() {
    return 'GOODCharacter(key: $key, level: $level, constellation: $constellation, ascension: $ascension, talent: $talent)';
  }

  @JsonKey(ignore: true)
  @override
  _$GOODCharacterCopyWith<_GOODCharacter> get copyWith =>
      __$GOODCharacterCopyWithImpl<_GOODCharacter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GOODCharacterToJson(this);
  }
}

abstract class _GOODCharacter extends GOODCharacter {
  factory _GOODCharacter(
      {required String key,
      required int level,
      required int constellation,
      required int ascension,
      required Map<TalentType, int> talent}) = _$_GOODCharacter;
  _GOODCharacter._() : super._();

  factory _GOODCharacter.fromJson(Map<String, dynamic> json) =
      _$_GOODCharacter.fromJson;

  @override
  String get key;
  @override
  int get level;
  @override
  int get constellation;
  @override
  int get ascension;
  @override
  Map<TalentType, int> get talent;
  @override
  @JsonKey(ignore: true)
  _$GOODCharacterCopyWith<_GOODCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

GOODSubStat _$GOODSubStatFromJson(Map<String, dynamic> json) {
  return _GOODSubStat.fromJson(json);
}

/// @nodoc
class _$GOODSubStatTearOff {
  const _$GOODSubStatTearOff();

  _GOODSubStat call({required StatKey key, double value = 0}) {
    return _GOODSubStat(
      key: key,
      value: value,
    );
  }

  GOODSubStat fromJson(Map<String, Object?> json) {
    return GOODSubStat.fromJson(json);
  }
}

/// @nodoc
const $GOODSubStat = _$GOODSubStatTearOff();

/// @nodoc
mixin _$GOODSubStat {
  StatKey get key => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GOODSubStatCopyWith<GOODSubStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GOODSubStatCopyWith<$Res> {
  factory $GOODSubStatCopyWith(
          GOODSubStat value, $Res Function(GOODSubStat) then) =
      _$GOODSubStatCopyWithImpl<$Res>;
  $Res call({StatKey key, double value});
}

/// @nodoc
class _$GOODSubStatCopyWithImpl<$Res> implements $GOODSubStatCopyWith<$Res> {
  _$GOODSubStatCopyWithImpl(this._value, this._then);

  final GOODSubStat _value;
  // ignore: unused_field
  final $Res Function(GOODSubStat) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as StatKey,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
abstract class _$GOODSubStatCopyWith<$Res>
    implements $GOODSubStatCopyWith<$Res> {
  factory _$GOODSubStatCopyWith(
          _GOODSubStat value, $Res Function(_GOODSubStat) then) =
      __$GOODSubStatCopyWithImpl<$Res>;
  @override
  $Res call({StatKey key, double value});
}

/// @nodoc
class __$GOODSubStatCopyWithImpl<$Res> extends _$GOODSubStatCopyWithImpl<$Res>
    implements _$GOODSubStatCopyWith<$Res> {
  __$GOODSubStatCopyWithImpl(
      _GOODSubStat _value, $Res Function(_GOODSubStat) _then)
      : super(_value, (v) => _then(v as _GOODSubStat));

  @override
  _GOODSubStat get _value => super._value as _GOODSubStat;

  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_GOODSubStat(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as StatKey,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GOODSubStat extends _GOODSubStat {
  _$_GOODSubStat({required this.key, this.value = 0}) : super._();

  factory _$_GOODSubStat.fromJson(Map<String, dynamic> json) =>
      _$$_GOODSubStatFromJson(json);

  @override
  final StatKey key;
  @JsonKey()
  @override
  final double value;

  @JsonKey(ignore: true)
  @override
  _$GOODSubStatCopyWith<_GOODSubStat> get copyWith =>
      __$GOODSubStatCopyWithImpl<_GOODSubStat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GOODSubStatToJson(this);
  }
}

abstract class _GOODSubStat extends GOODSubStat {
  factory _GOODSubStat({required StatKey key, double value}) = _$_GOODSubStat;
  _GOODSubStat._() : super._();

  factory _GOODSubStat.fromJson(Map<String, dynamic> json) =
      _$_GOODSubStat.fromJson;

  @override
  StatKey get key;
  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$GOODSubStatCopyWith<_GOODSubStat> get copyWith =>
      throw _privateConstructorUsedError;
}

GOODArtifact _$GOODArtifactFromJson(Map<String, dynamic> json) {
  return _GOODArtifact.fromJson(json);
}

/// @nodoc
class _$GOODArtifactTearOff {
  const _$GOODArtifactTearOff();

  _GOODArtifact call(
      {required String setKey,
      required SlotKey slotKey,
      required int level,
      required int rarity,
      required StatKey mainStatKey,
      required String location,
      required List<GOODSubStat> substats,
      bool lock = true}) {
    return _GOODArtifact(
      setKey: setKey,
      slotKey: slotKey,
      level: level,
      rarity: rarity,
      mainStatKey: mainStatKey,
      location: location,
      substats: substats,
      lock: lock,
    );
  }

  GOODArtifact fromJson(Map<String, Object?> json) {
    return GOODArtifact.fromJson(json);
  }
}

/// @nodoc
const $GOODArtifact = _$GOODArtifactTearOff();

/// @nodoc
mixin _$GOODArtifact {
  String get setKey => throw _privateConstructorUsedError;
  SlotKey get slotKey => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  StatKey get mainStatKey => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  List<GOODSubStat> get substats => throw _privateConstructorUsedError;
  bool get lock => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GOODArtifactCopyWith<GOODArtifact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GOODArtifactCopyWith<$Res> {
  factory $GOODArtifactCopyWith(
          GOODArtifact value, $Res Function(GOODArtifact) then) =
      _$GOODArtifactCopyWithImpl<$Res>;
  $Res call(
      {String setKey,
      SlotKey slotKey,
      int level,
      int rarity,
      StatKey mainStatKey,
      String location,
      List<GOODSubStat> substats,
      bool lock});
}

/// @nodoc
class _$GOODArtifactCopyWithImpl<$Res> implements $GOODArtifactCopyWith<$Res> {
  _$GOODArtifactCopyWithImpl(this._value, this._then);

  final GOODArtifact _value;
  // ignore: unused_field
  final $Res Function(GOODArtifact) _then;

  @override
  $Res call({
    Object? setKey = freezed,
    Object? slotKey = freezed,
    Object? level = freezed,
    Object? rarity = freezed,
    Object? mainStatKey = freezed,
    Object? location = freezed,
    Object? substats = freezed,
    Object? lock = freezed,
  }) {
    return _then(_value.copyWith(
      setKey: setKey == freezed
          ? _value.setKey
          : setKey // ignore: cast_nullable_to_non_nullable
              as String,
      slotKey: slotKey == freezed
          ? _value.slotKey
          : slotKey // ignore: cast_nullable_to_non_nullable
              as SlotKey,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      mainStatKey: mainStatKey == freezed
          ? _value.mainStatKey
          : mainStatKey // ignore: cast_nullable_to_non_nullable
              as StatKey,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      substats: substats == freezed
          ? _value.substats
          : substats // ignore: cast_nullable_to_non_nullable
              as List<GOODSubStat>,
      lock: lock == freezed
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$GOODArtifactCopyWith<$Res>
    implements $GOODArtifactCopyWith<$Res> {
  factory _$GOODArtifactCopyWith(
          _GOODArtifact value, $Res Function(_GOODArtifact) then) =
      __$GOODArtifactCopyWithImpl<$Res>;
  @override
  $Res call(
      {String setKey,
      SlotKey slotKey,
      int level,
      int rarity,
      StatKey mainStatKey,
      String location,
      List<GOODSubStat> substats,
      bool lock});
}

/// @nodoc
class __$GOODArtifactCopyWithImpl<$Res> extends _$GOODArtifactCopyWithImpl<$Res>
    implements _$GOODArtifactCopyWith<$Res> {
  __$GOODArtifactCopyWithImpl(
      _GOODArtifact _value, $Res Function(_GOODArtifact) _then)
      : super(_value, (v) => _then(v as _GOODArtifact));

  @override
  _GOODArtifact get _value => super._value as _GOODArtifact;

  @override
  $Res call({
    Object? setKey = freezed,
    Object? slotKey = freezed,
    Object? level = freezed,
    Object? rarity = freezed,
    Object? mainStatKey = freezed,
    Object? location = freezed,
    Object? substats = freezed,
    Object? lock = freezed,
  }) {
    return _then(_GOODArtifact(
      setKey: setKey == freezed
          ? _value.setKey
          : setKey // ignore: cast_nullable_to_non_nullable
              as String,
      slotKey: slotKey == freezed
          ? _value.slotKey
          : slotKey // ignore: cast_nullable_to_non_nullable
              as SlotKey,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      mainStatKey: mainStatKey == freezed
          ? _value.mainStatKey
          : mainStatKey // ignore: cast_nullable_to_non_nullable
              as StatKey,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      substats: substats == freezed
          ? _value.substats
          : substats // ignore: cast_nullable_to_non_nullable
              as List<GOODSubStat>,
      lock: lock == freezed
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GOODArtifact extends _GOODArtifact {
  _$_GOODArtifact(
      {required this.setKey,
      required this.slotKey,
      required this.level,
      required this.rarity,
      required this.mainStatKey,
      required this.location,
      required this.substats,
      this.lock = true})
      : super._();

  factory _$_GOODArtifact.fromJson(Map<String, dynamic> json) =>
      _$$_GOODArtifactFromJson(json);

  @override
  final String setKey;
  @override
  final SlotKey slotKey;
  @override
  final int level;
  @override
  final int rarity;
  @override
  final StatKey mainStatKey;
  @override
  final String location;
  @override
  final List<GOODSubStat> substats;
  @JsonKey()
  @override
  final bool lock;

  @override
  String toString() {
    return 'GOODArtifact(setKey: $setKey, slotKey: $slotKey, level: $level, rarity: $rarity, mainStatKey: $mainStatKey, location: $location, substats: $substats, lock: $lock)';
  }

  @JsonKey(ignore: true)
  @override
  _$GOODArtifactCopyWith<_GOODArtifact> get copyWith =>
      __$GOODArtifactCopyWithImpl<_GOODArtifact>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GOODArtifactToJson(this);
  }
}

abstract class _GOODArtifact extends GOODArtifact {
  factory _GOODArtifact(
      {required String setKey,
      required SlotKey slotKey,
      required int level,
      required int rarity,
      required StatKey mainStatKey,
      required String location,
      required List<GOODSubStat> substats,
      bool lock}) = _$_GOODArtifact;
  _GOODArtifact._() : super._();

  factory _GOODArtifact.fromJson(Map<String, dynamic> json) =
      _$_GOODArtifact.fromJson;

  @override
  String get setKey;
  @override
  SlotKey get slotKey;
  @override
  int get level;
  @override
  int get rarity;
  @override
  StatKey get mainStatKey;
  @override
  String get location;
  @override
  List<GOODSubStat> get substats;
  @override
  bool get lock;
  @override
  @JsonKey(ignore: true)
  _$GOODArtifactCopyWith<_GOODArtifact> get copyWith =>
      throw _privateConstructorUsedError;
}

GOODWeapon _$GOODWeaponFromJson(Map<String, dynamic> json) {
  return _GOODWeapon.fromJson(json);
}

/// @nodoc
class _$GOODWeaponTearOff {
  const _$GOODWeaponTearOff();

  _GOODWeapon call(
      {required String key,
      required int level,
      required int ascension,
      required int refinement,
      required String location,
      bool lock = true}) {
    return _GOODWeapon(
      key: key,
      level: level,
      ascension: ascension,
      refinement: refinement,
      location: location,
      lock: lock,
    );
  }

  GOODWeapon fromJson(Map<String, Object?> json) {
    return GOODWeapon.fromJson(json);
  }
}

/// @nodoc
const $GOODWeapon = _$GOODWeaponTearOff();

/// @nodoc
mixin _$GOODWeapon {
  String get key => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  int get ascension => throw _privateConstructorUsedError;
  int get refinement => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  bool get lock => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GOODWeaponCopyWith<GOODWeapon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GOODWeaponCopyWith<$Res> {
  factory $GOODWeaponCopyWith(
          GOODWeapon value, $Res Function(GOODWeapon) then) =
      _$GOODWeaponCopyWithImpl<$Res>;
  $Res call(
      {String key,
      int level,
      int ascension,
      int refinement,
      String location,
      bool lock});
}

/// @nodoc
class _$GOODWeaponCopyWithImpl<$Res> implements $GOODWeaponCopyWith<$Res> {
  _$GOODWeaponCopyWithImpl(this._value, this._then);

  final GOODWeapon _value;
  // ignore: unused_field
  final $Res Function(GOODWeapon) _then;

  @override
  $Res call({
    Object? key = freezed,
    Object? level = freezed,
    Object? ascension = freezed,
    Object? refinement = freezed,
    Object? location = freezed,
    Object? lock = freezed,
  }) {
    return _then(_value.copyWith(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      ascension: ascension == freezed
          ? _value.ascension
          : ascension // ignore: cast_nullable_to_non_nullable
              as int,
      refinement: refinement == freezed
          ? _value.refinement
          : refinement // ignore: cast_nullable_to_non_nullable
              as int,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      lock: lock == freezed
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$GOODWeaponCopyWith<$Res> implements $GOODWeaponCopyWith<$Res> {
  factory _$GOODWeaponCopyWith(
          _GOODWeapon value, $Res Function(_GOODWeapon) then) =
      __$GOODWeaponCopyWithImpl<$Res>;
  @override
  $Res call(
      {String key,
      int level,
      int ascension,
      int refinement,
      String location,
      bool lock});
}

/// @nodoc
class __$GOODWeaponCopyWithImpl<$Res> extends _$GOODWeaponCopyWithImpl<$Res>
    implements _$GOODWeaponCopyWith<$Res> {
  __$GOODWeaponCopyWithImpl(
      _GOODWeapon _value, $Res Function(_GOODWeapon) _then)
      : super(_value, (v) => _then(v as _GOODWeapon));

  @override
  _GOODWeapon get _value => super._value as _GOODWeapon;

  @override
  $Res call({
    Object? key = freezed,
    Object? level = freezed,
    Object? ascension = freezed,
    Object? refinement = freezed,
    Object? location = freezed,
    Object? lock = freezed,
  }) {
    return _then(_GOODWeapon(
      key: key == freezed
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      ascension: ascension == freezed
          ? _value.ascension
          : ascension // ignore: cast_nullable_to_non_nullable
              as int,
      refinement: refinement == freezed
          ? _value.refinement
          : refinement // ignore: cast_nullable_to_non_nullable
              as int,
      location: location == freezed
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      lock: lock == freezed
          ? _value.lock
          : lock // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GOODWeapon extends _GOODWeapon {
  _$_GOODWeapon(
      {required this.key,
      required this.level,
      required this.ascension,
      required this.refinement,
      required this.location,
      this.lock = true})
      : super._();

  factory _$_GOODWeapon.fromJson(Map<String, dynamic> json) =>
      _$$_GOODWeaponFromJson(json);

  @override
  final String key;
  @override
  final int level;
  @override
  final int ascension;
  @override
  final int refinement;
  @override
  final String location;
  @JsonKey()
  @override
  final bool lock;

  @override
  String toString() {
    return 'GOODWeapon(key: $key, level: $level, ascension: $ascension, refinement: $refinement, location: $location, lock: $lock)';
  }

  @JsonKey(ignore: true)
  @override
  _$GOODWeaponCopyWith<_GOODWeapon> get copyWith =>
      __$GOODWeaponCopyWithImpl<_GOODWeapon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GOODWeaponToJson(this);
  }
}

abstract class _GOODWeapon extends GOODWeapon {
  factory _GOODWeapon(
      {required String key,
      required int level,
      required int ascension,
      required int refinement,
      required String location,
      bool lock}) = _$_GOODWeapon;
  _GOODWeapon._() : super._();

  factory _GOODWeapon.fromJson(Map<String, dynamic> json) =
      _$_GOODWeapon.fromJson;

  @override
  String get key;
  @override
  int get level;
  @override
  int get ascension;
  @override
  int get refinement;
  @override
  String get location;
  @override
  bool get lock;
  @override
  @JsonKey(ignore: true)
  _$GOODWeaponCopyWith<_GOODWeapon> get copyWith =>
      throw _privateConstructorUsedError;
}
