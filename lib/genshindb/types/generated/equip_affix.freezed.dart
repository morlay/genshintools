// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../equip_affix.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EquipAffix _$EquipAffixFromJson(Map<String, dynamic> json) {
  return _EquipAffix.fromJson(json);
}

/// @nodoc
class _$EquipAffixTearOff {
  const _$EquipAffixTearOff();

  _EquipAffix call(
      {required I18n name,
      required I18n desc,
      required FightProps addProps,
      required List<double> params,
      int? level,
      int? activeWhenNum}) {
    return _EquipAffix(
      name: name,
      desc: desc,
      addProps: addProps,
      params: params,
      level: level,
      activeWhenNum: activeWhenNum,
    );
  }

  EquipAffix fromJson(Map<String, Object?> json) {
    return EquipAffix.fromJson(json);
  }
}

/// @nodoc
const $EquipAffix = _$EquipAffixTearOff();

/// @nodoc
mixin _$EquipAffix {
  I18n get name => throw _privateConstructorUsedError;
  I18n get desc => throw _privateConstructorUsedError;
  FightProps get addProps => throw _privateConstructorUsedError;
  List<double> get params => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;
  int? get activeWhenNum => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EquipAffixCopyWith<EquipAffix> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EquipAffixCopyWith<$Res> {
  factory $EquipAffixCopyWith(
          EquipAffix value, $Res Function(EquipAffix) then) =
      _$EquipAffixCopyWithImpl<$Res>;
  $Res call(
      {I18n name,
      I18n desc,
      FightProps addProps,
      List<double> params,
      int? level,
      int? activeWhenNum});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get desc;
  $FightPropsCopyWith<$Res> get addProps;
}

/// @nodoc
class _$EquipAffixCopyWithImpl<$Res> implements $EquipAffixCopyWith<$Res> {
  _$EquipAffixCopyWithImpl(this._value, this._then);

  final EquipAffix _value;
  // ignore: unused_field
  final $Res Function(EquipAffix) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? desc = freezed,
    Object? addProps = freezed,
    Object? params = freezed,
    Object? level = freezed,
    Object? activeWhenNum = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as I18n,
      addProps: addProps == freezed
          ? _value.addProps
          : addProps // ignore: cast_nullable_to_non_nullable
              as FightProps,
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as List<double>,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      activeWhenNum: activeWhenNum == freezed
          ? _value.activeWhenNum
          : activeWhenNum // ignore: cast_nullable_to_non_nullable
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
  $FightPropsCopyWith<$Res> get addProps {
    return $FightPropsCopyWith<$Res>(_value.addProps, (value) {
      return _then(_value.copyWith(addProps: value));
    });
  }
}

/// @nodoc
abstract class _$EquipAffixCopyWith<$Res> implements $EquipAffixCopyWith<$Res> {
  factory _$EquipAffixCopyWith(
          _EquipAffix value, $Res Function(_EquipAffix) then) =
      __$EquipAffixCopyWithImpl<$Res>;
  @override
  $Res call(
      {I18n name,
      I18n desc,
      FightProps addProps,
      List<double> params,
      int? level,
      int? activeWhenNum});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get desc;
  @override
  $FightPropsCopyWith<$Res> get addProps;
}

/// @nodoc
class __$EquipAffixCopyWithImpl<$Res> extends _$EquipAffixCopyWithImpl<$Res>
    implements _$EquipAffixCopyWith<$Res> {
  __$EquipAffixCopyWithImpl(
      _EquipAffix _value, $Res Function(_EquipAffix) _then)
      : super(_value, (v) => _then(v as _EquipAffix));

  @override
  _EquipAffix get _value => super._value as _EquipAffix;

  @override
  $Res call({
    Object? name = freezed,
    Object? desc = freezed,
    Object? addProps = freezed,
    Object? params = freezed,
    Object? level = freezed,
    Object? activeWhenNum = freezed,
  }) {
    return _then(_EquipAffix(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as I18n,
      desc: desc == freezed
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as I18n,
      addProps: addProps == freezed
          ? _value.addProps
          : addProps // ignore: cast_nullable_to_non_nullable
              as FightProps,
      params: params == freezed
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as List<double>,
      level: level == freezed
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
      activeWhenNum: activeWhenNum == freezed
          ? _value.activeWhenNum
          : activeWhenNum // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_EquipAffix extends _EquipAffix {
  _$_EquipAffix(
      {required this.name,
      required this.desc,
      required this.addProps,
      required this.params,
      this.level,
      this.activeWhenNum})
      : super._();

  factory _$_EquipAffix.fromJson(Map<String, dynamic> json) =>
      _$$_EquipAffixFromJson(json);

  @override
  final I18n name;
  @override
  final I18n desc;
  @override
  final FightProps addProps;
  @override
  final List<double> params;
  @override
  final int? level;
  @override
  final int? activeWhenNum;

  @override
  String toString() {
    return 'EquipAffix(name: $name, desc: $desc, addProps: $addProps, params: $params, level: $level, activeWhenNum: $activeWhenNum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EquipAffix &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.addProps, addProps) &&
            const DeepCollectionEquality().equals(other.params, params) &&
            const DeepCollectionEquality().equals(other.level, level) &&
            const DeepCollectionEquality()
                .equals(other.activeWhenNum, activeWhenNum));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(addProps),
      const DeepCollectionEquality().hash(params),
      const DeepCollectionEquality().hash(level),
      const DeepCollectionEquality().hash(activeWhenNum));

  @JsonKey(ignore: true)
  @override
  _$EquipAffixCopyWith<_EquipAffix> get copyWith =>
      __$EquipAffixCopyWithImpl<_EquipAffix>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EquipAffixToJson(this);
  }
}

abstract class _EquipAffix extends EquipAffix {
  factory _EquipAffix(
      {required I18n name,
      required I18n desc,
      required FightProps addProps,
      required List<double> params,
      int? level,
      int? activeWhenNum}) = _$_EquipAffix;
  _EquipAffix._() : super._();

  factory _EquipAffix.fromJson(Map<String, dynamic> json) =
      _$_EquipAffix.fromJson;

  @override
  I18n get name;
  @override
  I18n get desc;
  @override
  FightProps get addProps;
  @override
  List<double> get params;
  @override
  int? get level;
  @override
  int? get activeWhenNum;
  @override
  @JsonKey(ignore: true)
  _$EquipAffixCopyWith<_EquipAffix> get copyWith =>
      throw _privateConstructorUsedError;
}
