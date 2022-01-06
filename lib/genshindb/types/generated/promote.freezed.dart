// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../promote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSPromoteSet _$GSPromoteSetFromJson(Map<String, dynamic> json) {
  return _PromoteSet.fromJson(json);
}

/// @nodoc
class _$GSPromoteSetTearOff {
  const _$GSPromoteSetTearOff();

  _PromoteSet call(Map<int, List<GSPromote>> promotes) {
    return _PromoteSet(
      promotes,
    );
  }

  GSPromoteSet fromJson(Map<String, Object?> json) {
    return GSPromoteSet.fromJson(json);
  }
}

/// @nodoc
const $GSPromoteSet = _$GSPromoteSetTearOff();

/// @nodoc
mixin _$GSPromoteSet {
  Map<int, List<GSPromote>> get promotes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSPromoteSetCopyWith<GSPromoteSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSPromoteSetCopyWith<$Res> {
  factory $GSPromoteSetCopyWith(
          GSPromoteSet value, $Res Function(GSPromoteSet) then) =
      _$GSPromoteSetCopyWithImpl<$Res>;
  $Res call({Map<int, List<GSPromote>> promotes});
}

/// @nodoc
class _$GSPromoteSetCopyWithImpl<$Res> implements $GSPromoteSetCopyWith<$Res> {
  _$GSPromoteSetCopyWithImpl(this._value, this._then);

  final GSPromoteSet _value;
  // ignore: unused_field
  final $Res Function(GSPromoteSet) _then;

  @override
  $Res call({
    Object? promotes = freezed,
  }) {
    return _then(_value.copyWith(
      promotes: promotes == freezed
          ? _value.promotes
          : promotes // ignore: cast_nullable_to_non_nullable
              as Map<int, List<GSPromote>>,
    ));
  }
}

/// @nodoc
abstract class _$PromoteSetCopyWith<$Res>
    implements $GSPromoteSetCopyWith<$Res> {
  factory _$PromoteSetCopyWith(
          _PromoteSet value, $Res Function(_PromoteSet) then) =
      __$PromoteSetCopyWithImpl<$Res>;
  @override
  $Res call({Map<int, List<GSPromote>> promotes});
}

/// @nodoc
class __$PromoteSetCopyWithImpl<$Res> extends _$GSPromoteSetCopyWithImpl<$Res>
    implements _$PromoteSetCopyWith<$Res> {
  __$PromoteSetCopyWithImpl(
      _PromoteSet _value, $Res Function(_PromoteSet) _then)
      : super(_value, (v) => _then(v as _PromoteSet));

  @override
  _PromoteSet get _value => super._value as _PromoteSet;

  @override
  $Res call({
    Object? promotes = freezed,
  }) {
    return _then(_PromoteSet(
      promotes == freezed
          ? _value.promotes
          : promotes // ignore: cast_nullable_to_non_nullable
              as Map<int, List<GSPromote>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PromoteSet extends _PromoteSet {
  _$_PromoteSet(this.promotes) : super._();

  factory _$_PromoteSet.fromJson(Map<String, dynamic> json) =>
      _$$_PromoteSetFromJson(json);

  @override
  final Map<int, List<GSPromote>> promotes;

  @override
  String toString() {
    return 'GSPromoteSet(promotes: $promotes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PromoteSet &&
            const DeepCollectionEquality().equals(other.promotes, promotes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(promotes));

  @JsonKey(ignore: true)
  @override
  _$PromoteSetCopyWith<_PromoteSet> get copyWith =>
      __$PromoteSetCopyWithImpl<_PromoteSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PromoteSetToJson(this);
  }
}

abstract class _PromoteSet extends GSPromoteSet {
  factory _PromoteSet(Map<int, List<GSPromote>> promotes) = _$_PromoteSet;
  _PromoteSet._() : super._();

  factory _PromoteSet.fromJson(Map<String, dynamic> json) =
      _$_PromoteSet.fromJson;

  @override
  Map<int, List<GSPromote>> get promotes;
  @override
  @JsonKey(ignore: true)
  _$PromoteSetCopyWith<_PromoteSet> get copyWith =>
      throw _privateConstructorUsedError;
}

GSPromote _$GSPromoteFromJson(Map<String, dynamic> json) {
  return _Promote.fromJson(json);
}

/// @nodoc
class _$GSPromoteTearOff {
  const _$GSPromoteTearOff();

  _Promote call(
      {required int unlockMaxLevel,
      required List<GSMaterialCost> materialCosts,
      required FightProps addProps}) {
    return _Promote(
      unlockMaxLevel: unlockMaxLevel,
      materialCosts: materialCosts,
      addProps: addProps,
    );
  }

  GSPromote fromJson(Map<String, Object?> json) {
    return GSPromote.fromJson(json);
  }
}

/// @nodoc
const $GSPromote = _$GSPromoteTearOff();

/// @nodoc
mixin _$GSPromote {
  int get unlockMaxLevel => throw _privateConstructorUsedError;
  List<GSMaterialCost> get materialCosts => throw _privateConstructorUsedError;
  FightProps get addProps => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSPromoteCopyWith<GSPromote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSPromoteCopyWith<$Res> {
  factory $GSPromoteCopyWith(GSPromote value, $Res Function(GSPromote) then) =
      _$GSPromoteCopyWithImpl<$Res>;
  $Res call(
      {int unlockMaxLevel,
      List<GSMaterialCost> materialCosts,
      FightProps addProps});

  $FightPropsCopyWith<$Res> get addProps;
}

/// @nodoc
class _$GSPromoteCopyWithImpl<$Res> implements $GSPromoteCopyWith<$Res> {
  _$GSPromoteCopyWithImpl(this._value, this._then);

  final GSPromote _value;
  // ignore: unused_field
  final $Res Function(GSPromote) _then;

  @override
  $Res call({
    Object? unlockMaxLevel = freezed,
    Object? materialCosts = freezed,
    Object? addProps = freezed,
  }) {
    return _then(_value.copyWith(
      unlockMaxLevel: unlockMaxLevel == freezed
          ? _value.unlockMaxLevel
          : unlockMaxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      materialCosts: materialCosts == freezed
          ? _value.materialCosts
          : materialCosts // ignore: cast_nullable_to_non_nullable
              as List<GSMaterialCost>,
      addProps: addProps == freezed
          ? _value.addProps
          : addProps // ignore: cast_nullable_to_non_nullable
              as FightProps,
    ));
  }

  @override
  $FightPropsCopyWith<$Res> get addProps {
    return $FightPropsCopyWith<$Res>(_value.addProps, (value) {
      return _then(_value.copyWith(addProps: value));
    });
  }
}

/// @nodoc
abstract class _$PromoteCopyWith<$Res> implements $GSPromoteCopyWith<$Res> {
  factory _$PromoteCopyWith(_Promote value, $Res Function(_Promote) then) =
      __$PromoteCopyWithImpl<$Res>;
  @override
  $Res call(
      {int unlockMaxLevel,
      List<GSMaterialCost> materialCosts,
      FightProps addProps});

  @override
  $FightPropsCopyWith<$Res> get addProps;
}

/// @nodoc
class __$PromoteCopyWithImpl<$Res> extends _$GSPromoteCopyWithImpl<$Res>
    implements _$PromoteCopyWith<$Res> {
  __$PromoteCopyWithImpl(_Promote _value, $Res Function(_Promote) _then)
      : super(_value, (v) => _then(v as _Promote));

  @override
  _Promote get _value => super._value as _Promote;

  @override
  $Res call({
    Object? unlockMaxLevel = freezed,
    Object? materialCosts = freezed,
    Object? addProps = freezed,
  }) {
    return _then(_Promote(
      unlockMaxLevel: unlockMaxLevel == freezed
          ? _value.unlockMaxLevel
          : unlockMaxLevel // ignore: cast_nullable_to_non_nullable
              as int,
      materialCosts: materialCosts == freezed
          ? _value.materialCosts
          : materialCosts // ignore: cast_nullable_to_non_nullable
              as List<GSMaterialCost>,
      addProps: addProps == freezed
          ? _value.addProps
          : addProps // ignore: cast_nullable_to_non_nullable
              as FightProps,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_Promote extends _Promote {
  _$_Promote(
      {required this.unlockMaxLevel,
      required this.materialCosts,
      required this.addProps})
      : super._();

  factory _$_Promote.fromJson(Map<String, dynamic> json) =>
      _$$_PromoteFromJson(json);

  @override
  final int unlockMaxLevel;
  @override
  final List<GSMaterialCost> materialCosts;
  @override
  final FightProps addProps;

  @override
  String toString() {
    return 'GSPromote(unlockMaxLevel: $unlockMaxLevel, materialCosts: $materialCosts, addProps: $addProps)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Promote &&
            const DeepCollectionEquality()
                .equals(other.unlockMaxLevel, unlockMaxLevel) &&
            const DeepCollectionEquality()
                .equals(other.materialCosts, materialCosts) &&
            const DeepCollectionEquality().equals(other.addProps, addProps));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(unlockMaxLevel),
      const DeepCollectionEquality().hash(materialCosts),
      const DeepCollectionEquality().hash(addProps));

  @JsonKey(ignore: true)
  @override
  _$PromoteCopyWith<_Promote> get copyWith =>
      __$PromoteCopyWithImpl<_Promote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PromoteToJson(this);
  }
}

abstract class _Promote extends GSPromote {
  factory _Promote(
      {required int unlockMaxLevel,
      required List<GSMaterialCost> materialCosts,
      required FightProps addProps}) = _$_Promote;
  _Promote._() : super._();

  factory _Promote.fromJson(Map<String, dynamic> json) = _$_Promote.fromJson;

  @override
  int get unlockMaxLevel;
  @override
  List<GSMaterialCost> get materialCosts;
  @override
  FightProps get addProps;
  @override
  @JsonKey(ignore: true)
  _$PromoteCopyWith<_Promote> get copyWith =>
      throw _privateConstructorUsedError;
}
