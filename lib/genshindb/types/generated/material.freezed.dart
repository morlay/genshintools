// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSMaterial _$GSMaterialFromJson(Map<String, dynamic> json) {
  return _Material.fromJson(json);
}

/// @nodoc
class _$GSMaterialTearOff {
  const _$GSMaterialTearOff();

  _Material call(
      {required int id,
      required I18n name,
      required I18n desc,
      @GSMaterialTypeStringConverter() required GSMaterialType materialType,
      required int rarity,
      required int rank,
      List<I18n>? sources,
      List<String>? dropFromTags,
      GSMonsterRarity? dropFromRarity,
      int? dungeonId,
      GSDungeon? dungeon,
      int? count}) {
    return _Material(
      id: id,
      name: name,
      desc: desc,
      materialType: materialType,
      rarity: rarity,
      rank: rank,
      sources: sources,
      dropFromTags: dropFromTags,
      dropFromRarity: dropFromRarity,
      dungeonId: dungeonId,
      dungeon: dungeon,
      count: count,
    );
  }

  GSMaterial fromJson(Map<String, Object?> json) {
    return GSMaterial.fromJson(json);
  }
}

/// @nodoc
const $GSMaterial = _$GSMaterialTearOff();

/// @nodoc
mixin _$GSMaterial {
  int get id => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  I18n get desc => throw _privateConstructorUsedError;
  @GSMaterialTypeStringConverter()
  GSMaterialType get materialType => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  List<I18n>? get sources => throw _privateConstructorUsedError;
  List<String>? get dropFromTags => throw _privateConstructorUsedError;
  GSMonsterRarity? get dropFromRarity => throw _privateConstructorUsedError;
  int? get dungeonId => throw _privateConstructorUsedError;
  GSDungeon? get dungeon => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSMaterialCopyWith<GSMaterial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSMaterialCopyWith<$Res> {
  factory $GSMaterialCopyWith(
          GSMaterial value, $Res Function(GSMaterial) then) =
      _$GSMaterialCopyWithImpl<$Res>;
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      @GSMaterialTypeStringConverter() GSMaterialType materialType,
      int rarity,
      int rank,
      List<I18n>? sources,
      List<String>? dropFromTags,
      GSMonsterRarity? dropFromRarity,
      int? dungeonId,
      GSDungeon? dungeon,
      int? count});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get desc;
  $GSDungeonCopyWith<$Res>? get dungeon;
}

/// @nodoc
class _$GSMaterialCopyWithImpl<$Res> implements $GSMaterialCopyWith<$Res> {
  _$GSMaterialCopyWithImpl(this._value, this._then);

  final GSMaterial _value;
  // ignore: unused_field
  final $Res Function(GSMaterial) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? materialType = freezed,
    Object? rarity = freezed,
    Object? rank = freezed,
    Object? sources = freezed,
    Object? dropFromTags = freezed,
    Object? dropFromRarity = freezed,
    Object? dungeonId = freezed,
    Object? dungeon = freezed,
    Object? count = freezed,
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
      materialType: materialType == freezed
          ? _value.materialType
          : materialType // ignore: cast_nullable_to_non_nullable
              as GSMaterialType,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      rank: rank == freezed
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      sources: sources == freezed
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<I18n>?,
      dropFromTags: dropFromTags == freezed
          ? _value.dropFromTags
          : dropFromTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dropFromRarity: dropFromRarity == freezed
          ? _value.dropFromRarity
          : dropFromRarity // ignore: cast_nullable_to_non_nullable
              as GSMonsterRarity?,
      dungeonId: dungeonId == freezed
          ? _value.dungeonId
          : dungeonId // ignore: cast_nullable_to_non_nullable
              as int?,
      dungeon: dungeon == freezed
          ? _value.dungeon
          : dungeon // ignore: cast_nullable_to_non_nullable
              as GSDungeon?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
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

  @override
  $GSDungeonCopyWith<$Res>? get dungeon {
    if (_value.dungeon == null) {
      return null;
    }

    return $GSDungeonCopyWith<$Res>(_value.dungeon!, (value) {
      return _then(_value.copyWith(dungeon: value));
    });
  }
}

/// @nodoc
abstract class _$MaterialCopyWith<$Res> implements $GSMaterialCopyWith<$Res> {
  factory _$MaterialCopyWith(_Material value, $Res Function(_Material) then) =
      __$MaterialCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      I18n name,
      I18n desc,
      @GSMaterialTypeStringConverter() GSMaterialType materialType,
      int rarity,
      int rank,
      List<I18n>? sources,
      List<String>? dropFromTags,
      GSMonsterRarity? dropFromRarity,
      int? dungeonId,
      GSDungeon? dungeon,
      int? count});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get desc;
  @override
  $GSDungeonCopyWith<$Res>? get dungeon;
}

/// @nodoc
class __$MaterialCopyWithImpl<$Res> extends _$GSMaterialCopyWithImpl<$Res>
    implements _$MaterialCopyWith<$Res> {
  __$MaterialCopyWithImpl(_Material _value, $Res Function(_Material) _then)
      : super(_value, (v) => _then(v as _Material));

  @override
  _Material get _value => super._value as _Material;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? desc = freezed,
    Object? materialType = freezed,
    Object? rarity = freezed,
    Object? rank = freezed,
    Object? sources = freezed,
    Object? dropFromTags = freezed,
    Object? dropFromRarity = freezed,
    Object? dungeonId = freezed,
    Object? dungeon = freezed,
    Object? count = freezed,
  }) {
    return _then(_Material(
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
      materialType: materialType == freezed
          ? _value.materialType
          : materialType // ignore: cast_nullable_to_non_nullable
              as GSMaterialType,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      rank: rank == freezed
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      sources: sources == freezed
          ? _value.sources
          : sources // ignore: cast_nullable_to_non_nullable
              as List<I18n>?,
      dropFromTags: dropFromTags == freezed
          ? _value.dropFromTags
          : dropFromTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      dropFromRarity: dropFromRarity == freezed
          ? _value.dropFromRarity
          : dropFromRarity // ignore: cast_nullable_to_non_nullable
              as GSMonsterRarity?,
      dungeonId: dungeonId == freezed
          ? _value.dungeonId
          : dungeonId // ignore: cast_nullable_to_non_nullable
              as int?,
      dungeon: dungeon == freezed
          ? _value.dungeon
          : dungeon // ignore: cast_nullable_to_non_nullable
              as GSDungeon?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_Material extends _Material {
  _$_Material(
      {required this.id,
      required this.name,
      required this.desc,
      @GSMaterialTypeStringConverter() required this.materialType,
      required this.rarity,
      required this.rank,
      this.sources,
      this.dropFromTags,
      this.dropFromRarity,
      this.dungeonId,
      this.dungeon,
      this.count})
      : super._();

  factory _$_Material.fromJson(Map<String, dynamic> json) =>
      _$$_MaterialFromJson(json);

  @override
  final int id;
  @override
  final I18n name;
  @override
  final I18n desc;
  @override
  @GSMaterialTypeStringConverter()
  final GSMaterialType materialType;
  @override
  final int rarity;
  @override
  final int rank;
  @override
  final List<I18n>? sources;
  @override
  final List<String>? dropFromTags;
  @override
  final GSMonsterRarity? dropFromRarity;
  @override
  final int? dungeonId;
  @override
  final GSDungeon? dungeon;
  @override
  final int? count;

  @override
  String toString() {
    return 'GSMaterial(id: $id, name: $name, desc: $desc, materialType: $materialType, rarity: $rarity, rank: $rank, sources: $sources, dropFromTags: $dropFromTags, dropFromRarity: $dropFromRarity, dungeonId: $dungeonId, dungeon: $dungeon, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Material &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality()
                .equals(other.materialType, materialType) &&
            const DeepCollectionEquality().equals(other.rarity, rarity) &&
            const DeepCollectionEquality().equals(other.rank, rank) &&
            const DeepCollectionEquality().equals(other.sources, sources) &&
            const DeepCollectionEquality()
                .equals(other.dropFromTags, dropFromTags) &&
            const DeepCollectionEquality()
                .equals(other.dropFromRarity, dropFromRarity) &&
            const DeepCollectionEquality().equals(other.dungeonId, dungeonId) &&
            const DeepCollectionEquality().equals(other.dungeon, dungeon) &&
            const DeepCollectionEquality().equals(other.count, count));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(materialType),
      const DeepCollectionEquality().hash(rarity),
      const DeepCollectionEquality().hash(rank),
      const DeepCollectionEquality().hash(sources),
      const DeepCollectionEquality().hash(dropFromTags),
      const DeepCollectionEquality().hash(dropFromRarity),
      const DeepCollectionEquality().hash(dungeonId),
      const DeepCollectionEquality().hash(dungeon),
      const DeepCollectionEquality().hash(count));

  @JsonKey(ignore: true)
  @override
  _$MaterialCopyWith<_Material> get copyWith =>
      __$MaterialCopyWithImpl<_Material>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaterialToJson(this);
  }
}

abstract class _Material extends GSMaterial {
  factory _Material(
      {required int id,
      required I18n name,
      required I18n desc,
      @GSMaterialTypeStringConverter() required GSMaterialType materialType,
      required int rarity,
      required int rank,
      List<I18n>? sources,
      List<String>? dropFromTags,
      GSMonsterRarity? dropFromRarity,
      int? dungeonId,
      GSDungeon? dungeon,
      int? count}) = _$_Material;
  _Material._() : super._();

  factory _Material.fromJson(Map<String, dynamic> json) = _$_Material.fromJson;

  @override
  int get id;
  @override
  I18n get name;
  @override
  I18n get desc;
  @override
  @GSMaterialTypeStringConverter()
  GSMaterialType get materialType;
  @override
  int get rarity;
  @override
  int get rank;
  @override
  List<I18n>? get sources;
  @override
  List<String>? get dropFromTags;
  @override
  GSMonsterRarity? get dropFromRarity;
  @override
  int? get dungeonId;
  @override
  GSDungeon? get dungeon;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$MaterialCopyWith<_Material> get copyWith =>
      throw _privateConstructorUsedError;
}

GSMaterialCost _$GSMaterialCostFromJson(Map<String, dynamic> json) {
  return _MaterialCost.fromJson(json);
}

/// @nodoc
class _$GSMaterialCostTearOff {
  const _$GSMaterialCostTearOff();

  _MaterialCost call({required String materialKey, required int count}) {
    return _MaterialCost(
      materialKey: materialKey,
      count: count,
    );
  }

  GSMaterialCost fromJson(Map<String, Object?> json) {
    return GSMaterialCost.fromJson(json);
  }
}

/// @nodoc
const $GSMaterialCost = _$GSMaterialCostTearOff();

/// @nodoc
mixin _$GSMaterialCost {
  String get materialKey => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSMaterialCostCopyWith<GSMaterialCost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSMaterialCostCopyWith<$Res> {
  factory $GSMaterialCostCopyWith(
          GSMaterialCost value, $Res Function(GSMaterialCost) then) =
      _$GSMaterialCostCopyWithImpl<$Res>;
  $Res call({String materialKey, int count});
}

/// @nodoc
class _$GSMaterialCostCopyWithImpl<$Res>
    implements $GSMaterialCostCopyWith<$Res> {
  _$GSMaterialCostCopyWithImpl(this._value, this._then);

  final GSMaterialCost _value;
  // ignore: unused_field
  final $Res Function(GSMaterialCost) _then;

  @override
  $Res call({
    Object? materialKey = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      materialKey: materialKey == freezed
          ? _value.materialKey
          : materialKey // ignore: cast_nullable_to_non_nullable
              as String,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$MaterialCostCopyWith<$Res>
    implements $GSMaterialCostCopyWith<$Res> {
  factory _$MaterialCostCopyWith(
          _MaterialCost value, $Res Function(_MaterialCost) then) =
      __$MaterialCostCopyWithImpl<$Res>;
  @override
  $Res call({String materialKey, int count});
}

/// @nodoc
class __$MaterialCostCopyWithImpl<$Res>
    extends _$GSMaterialCostCopyWithImpl<$Res>
    implements _$MaterialCostCopyWith<$Res> {
  __$MaterialCostCopyWithImpl(
      _MaterialCost _value, $Res Function(_MaterialCost) _then)
      : super(_value, (v) => _then(v as _MaterialCost));

  @override
  _MaterialCost get _value => super._value as _MaterialCost;

  @override
  $Res call({
    Object? materialKey = freezed,
    Object? count = freezed,
  }) {
    return _then(_MaterialCost(
      materialKey: materialKey == freezed
          ? _value.materialKey
          : materialKey // ignore: cast_nullable_to_non_nullable
              as String,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_MaterialCost implements _MaterialCost {
  _$_MaterialCost({required this.materialKey, required this.count});

  factory _$_MaterialCost.fromJson(Map<String, dynamic> json) =>
      _$$_MaterialCostFromJson(json);

  @override
  final String materialKey;
  @override
  final int count;

  @override
  String toString() {
    return 'GSMaterialCost(materialKey: $materialKey, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MaterialCost &&
            const DeepCollectionEquality()
                .equals(other.materialKey, materialKey) &&
            const DeepCollectionEquality().equals(other.count, count));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(materialKey),
      const DeepCollectionEquality().hash(count));

  @JsonKey(ignore: true)
  @override
  _$MaterialCostCopyWith<_MaterialCost> get copyWith =>
      __$MaterialCostCopyWithImpl<_MaterialCost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaterialCostToJson(this);
  }
}

abstract class _MaterialCost implements GSMaterialCost {
  factory _MaterialCost({required String materialKey, required int count}) =
      _$_MaterialCost;

  factory _MaterialCost.fromJson(Map<String, dynamic> json) =
      _$_MaterialCost.fromJson;

  @override
  String get materialKey;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$MaterialCostCopyWith<_MaterialCost> get copyWith =>
      throw _privateConstructorUsedError;
}

GSDungeon _$GSDungeonFromJson(Map<String, dynamic> json) {
  return _Dungeon.fromJson(json);
}

/// @nodoc
class _$GSDungeonTearOff {
  const _$GSDungeonTearOff();

  _Dungeon call(
      {required int id,
      required String type,
      required I18n name,
      required I18n displayName,
      List<int>? openWeekdays}) {
    return _Dungeon(
      id: id,
      type: type,
      name: name,
      displayName: displayName,
      openWeekdays: openWeekdays,
    );
  }

  GSDungeon fromJson(Map<String, Object?> json) {
    return GSDungeon.fromJson(json);
  }
}

/// @nodoc
const $GSDungeon = _$GSDungeonTearOff();

/// @nodoc
mixin _$GSDungeon {
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  I18n get name => throw _privateConstructorUsedError;
  I18n get displayName => throw _privateConstructorUsedError;
  List<int>? get openWeekdays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSDungeonCopyWith<GSDungeon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSDungeonCopyWith<$Res> {
  factory $GSDungeonCopyWith(GSDungeon value, $Res Function(GSDungeon) then) =
      _$GSDungeonCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String type,
      I18n name,
      I18n displayName,
      List<int>? openWeekdays});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get displayName;
}

/// @nodoc
class _$GSDungeonCopyWithImpl<$Res> implements $GSDungeonCopyWith<$Res> {
  _$GSDungeonCopyWithImpl(this._value, this._then);

  final GSDungeon _value;
  // ignore: unused_field
  final $Res Function(GSDungeon) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? displayName = freezed,
    Object? openWeekdays = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as I18n,
      openWeekdays: openWeekdays == freezed
          ? _value.openWeekdays
          : openWeekdays // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }

  @override
  $I18nCopyWith<$Res> get name {
    return $I18nCopyWith<$Res>(_value.name, (value) {
      return _then(_value.copyWith(name: value));
    });
  }

  @override
  $I18nCopyWith<$Res> get displayName {
    return $I18nCopyWith<$Res>(_value.displayName, (value) {
      return _then(_value.copyWith(displayName: value));
    });
  }
}

/// @nodoc
abstract class _$DungeonCopyWith<$Res> implements $GSDungeonCopyWith<$Res> {
  factory _$DungeonCopyWith(_Dungeon value, $Res Function(_Dungeon) then) =
      __$DungeonCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String type,
      I18n name,
      I18n displayName,
      List<int>? openWeekdays});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get displayName;
}

/// @nodoc
class __$DungeonCopyWithImpl<$Res> extends _$GSDungeonCopyWithImpl<$Res>
    implements _$DungeonCopyWith<$Res> {
  __$DungeonCopyWithImpl(_Dungeon _value, $Res Function(_Dungeon) _then)
      : super(_value, (v) => _then(v as _Dungeon));

  @override
  _Dungeon get _value => super._value as _Dungeon;

  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? name = freezed,
    Object? displayName = freezed,
    Object? openWeekdays = freezed,
  }) {
    return _then(_Dungeon(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as I18n,
      openWeekdays: openWeekdays == freezed
          ? _value.openWeekdays
          : openWeekdays // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_Dungeon extends _Dungeon {
  _$_Dungeon(
      {required this.id,
      required this.type,
      required this.name,
      required this.displayName,
      this.openWeekdays})
      : super._();

  factory _$_Dungeon.fromJson(Map<String, dynamic> json) =>
      _$$_DungeonFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final I18n name;
  @override
  final I18n displayName;
  @override
  final List<int>? openWeekdays;

  @override
  String toString() {
    return 'GSDungeon(id: $id, type: $type, name: $name, displayName: $displayName, openWeekdays: $openWeekdays)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Dungeon &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality()
                .equals(other.openWeekdays, openWeekdays));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(openWeekdays));

  @JsonKey(ignore: true)
  @override
  _$DungeonCopyWith<_Dungeon> get copyWith =>
      __$DungeonCopyWithImpl<_Dungeon>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DungeonToJson(this);
  }
}

abstract class _Dungeon extends GSDungeon {
  factory _Dungeon(
      {required int id,
      required String type,
      required I18n name,
      required I18n displayName,
      List<int>? openWeekdays}) = _$_Dungeon;
  _Dungeon._() : super._();

  factory _Dungeon.fromJson(Map<String, dynamic> json) = _$_Dungeon.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  I18n get name;
  @override
  I18n get displayName;
  @override
  List<int>? get openWeekdays;
  @override
  @JsonKey(ignore: true)
  _$DungeonCopyWith<_Dungeon> get copyWith =>
      throw _privateConstructorUsedError;
}
