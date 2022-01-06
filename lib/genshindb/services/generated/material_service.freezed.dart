// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../material_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MaterialService _$MaterialServiceFromJson(Map<String, dynamic> json) {
  return _MaterialService.fromJson(json);
}

/// @nodoc
class _$MaterialServiceTearOff {
  const _$MaterialServiceTearOff();

  _MaterialService call(
      {Map<int, GSMaterial>? materials, Map<int, GSDungeon>? dungeons}) {
    return _MaterialService(
      materials: materials,
      dungeons: dungeons,
    );
  }

  MaterialService fromJson(Map<String, Object?> json) {
    return MaterialService.fromJson(json);
  }
}

/// @nodoc
const $MaterialService = _$MaterialServiceTearOff();

/// @nodoc
mixin _$MaterialService {
  Map<int, GSMaterial>? get materials => throw _privateConstructorUsedError;
  Map<int, GSDungeon>? get dungeons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaterialServiceCopyWith<MaterialService> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaterialServiceCopyWith<$Res> {
  factory $MaterialServiceCopyWith(
          MaterialService value, $Res Function(MaterialService) then) =
      _$MaterialServiceCopyWithImpl<$Res>;
  $Res call({Map<int, GSMaterial>? materials, Map<int, GSDungeon>? dungeons});
}

/// @nodoc
class _$MaterialServiceCopyWithImpl<$Res>
    implements $MaterialServiceCopyWith<$Res> {
  _$MaterialServiceCopyWithImpl(this._value, this._then);

  final MaterialService _value;
  // ignore: unused_field
  final $Res Function(MaterialService) _then;

  @override
  $Res call({
    Object? materials = freezed,
    Object? dungeons = freezed,
  }) {
    return _then(_value.copyWith(
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as Map<int, GSMaterial>?,
      dungeons: dungeons == freezed
          ? _value.dungeons
          : dungeons // ignore: cast_nullable_to_non_nullable
              as Map<int, GSDungeon>?,
    ));
  }
}

/// @nodoc
abstract class _$MaterialServiceCopyWith<$Res>
    implements $MaterialServiceCopyWith<$Res> {
  factory _$MaterialServiceCopyWith(
          _MaterialService value, $Res Function(_MaterialService) then) =
      __$MaterialServiceCopyWithImpl<$Res>;
  @override
  $Res call({Map<int, GSMaterial>? materials, Map<int, GSDungeon>? dungeons});
}

/// @nodoc
class __$MaterialServiceCopyWithImpl<$Res>
    extends _$MaterialServiceCopyWithImpl<$Res>
    implements _$MaterialServiceCopyWith<$Res> {
  __$MaterialServiceCopyWithImpl(
      _MaterialService _value, $Res Function(_MaterialService) _then)
      : super(_value, (v) => _then(v as _MaterialService));

  @override
  _MaterialService get _value => super._value as _MaterialService;

  @override
  $Res call({
    Object? materials = freezed,
    Object? dungeons = freezed,
  }) {
    return _then(_MaterialService(
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as Map<int, GSMaterial>?,
      dungeons: dungeons == freezed
          ? _value.dungeons
          : dungeons // ignore: cast_nullable_to_non_nullable
              as Map<int, GSDungeon>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_MaterialService extends _MaterialService {
  _$_MaterialService({this.materials, this.dungeons}) : super._();

  factory _$_MaterialService.fromJson(Map<String, dynamic> json) =>
      _$$_MaterialServiceFromJson(json);

  @override
  final Map<int, GSMaterial>? materials;
  @override
  final Map<int, GSDungeon>? dungeons;

  @override
  String toString() {
    return 'MaterialService(materials: $materials, dungeons: $dungeons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MaterialService &&
            const DeepCollectionEquality().equals(other.materials, materials) &&
            const DeepCollectionEquality().equals(other.dungeons, dungeons));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(materials),
      const DeepCollectionEquality().hash(dungeons));

  @JsonKey(ignore: true)
  @override
  _$MaterialServiceCopyWith<_MaterialService> get copyWith =>
      __$MaterialServiceCopyWithImpl<_MaterialService>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaterialServiceToJson(this);
  }
}

abstract class _MaterialService extends MaterialService {
  factory _MaterialService(
      {Map<int, GSMaterial>? materials,
      Map<int, GSDungeon>? dungeons}) = _$_MaterialService;
  _MaterialService._() : super._();

  factory _MaterialService.fromJson(Map<String, dynamic> json) =
      _$_MaterialService.fromJson;

  @override
  Map<int, GSMaterial>? get materials;
  @override
  Map<int, GSDungeon>? get dungeons;
  @override
  @JsonKey(ignore: true)
  _$MaterialServiceCopyWith<_MaterialService> get copyWith =>
      throw _privateConstructorUsedError;
}
