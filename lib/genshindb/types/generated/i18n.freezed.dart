// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../i18n.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

I18n _$I18nFromJson(Map<String, dynamic> json) {
  return _I18n.fromJson(json);
}

/// @nodoc
class _$I18nTearOff {
  const _$I18nTearOff();

  _I18n call(Map<Lang, String> values) {
    return _I18n(
      values,
    );
  }

  I18n fromJson(Map<String, Object?> json) {
    return I18n.fromJson(json);
  }
}

/// @nodoc
const $I18n = _$I18nTearOff();

/// @nodoc
mixin _$I18n {
  Map<Lang, String> get values => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $I18nCopyWith<I18n> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $I18nCopyWith<$Res> {
  factory $I18nCopyWith(I18n value, $Res Function(I18n) then) =
      _$I18nCopyWithImpl<$Res>;
  $Res call({Map<Lang, String> values});
}

/// @nodoc
class _$I18nCopyWithImpl<$Res> implements $I18nCopyWith<$Res> {
  _$I18nCopyWithImpl(this._value, this._then);

  final I18n _value;
  // ignore: unused_field
  final $Res Function(I18n) _then;

  @override
  $Res call({
    Object? values = freezed,
  }) {
    return _then(_value.copyWith(
      values: values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<Lang, String>,
    ));
  }
}

/// @nodoc
abstract class _$I18nCopyWith<$Res> implements $I18nCopyWith<$Res> {
  factory _$I18nCopyWith(_I18n value, $Res Function(_I18n) then) =
      __$I18nCopyWithImpl<$Res>;
  @override
  $Res call({Map<Lang, String> values});
}

/// @nodoc
class __$I18nCopyWithImpl<$Res> extends _$I18nCopyWithImpl<$Res>
    implements _$I18nCopyWith<$Res> {
  __$I18nCopyWithImpl(_I18n _value, $Res Function(_I18n) _then)
      : super(_value, (v) => _then(v as _I18n));

  @override
  _I18n get _value => super._value as _I18n;

  @override
  $Res call({
    Object? values = freezed,
  }) {
    return _then(_I18n(
      values == freezed
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as Map<Lang, String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@LangStringConverter()
class _$_I18n extends _I18n {
  _$_I18n(this.values) : super._();

  factory _$_I18n.fromJson(Map<String, dynamic> json) => _$$_I18nFromJson(json);

  @override
  final Map<Lang, String> values;

  @override
  String toString() {
    return 'I18n(values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _I18n &&
            const DeepCollectionEquality().equals(other.values, values));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(values));

  @JsonKey(ignore: true)
  @override
  _$I18nCopyWith<_I18n> get copyWith =>
      __$I18nCopyWithImpl<_I18n>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_I18nToJson(this);
  }
}

abstract class _I18n extends I18n {
  factory _I18n(Map<Lang, String> values) = _$_I18n;
  _I18n._() : super._();

  factory _I18n.fromJson(Map<String, dynamic> json) = _$_I18n.fromJson;

  @override
  Map<Lang, String> get values;
  @override
  @JsonKey(ignore: true)
  _$I18nCopyWith<_I18n> get copyWith => throw _privateConstructorUsedError;
}
