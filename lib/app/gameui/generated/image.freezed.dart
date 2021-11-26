// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$GSImageTearOff {
  const _$GSImageTearOff();

  _GSImage call(
      {required String domain,
      required String nameID,
      int rarity = 1,
      int size = 56,
      int borderSize = 0,
      bool rounded = false}) {
    return _GSImage(
      domain: domain,
      nameID: nameID,
      rarity: rarity,
      size: size,
      borderSize: borderSize,
      rounded: rounded,
    );
  }
}

/// @nodoc
const $GSImage = _$GSImageTearOff();

/// @nodoc
mixin _$GSImage {
  String get domain => throw _privateConstructorUsedError;
  String get nameID => throw _privateConstructorUsedError;
  int get rarity => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  int get borderSize => throw _privateConstructorUsedError;
  bool get rounded => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GSImageCopyWith<GSImage> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSImageCopyWith<$Res> {
  factory $GSImageCopyWith(GSImage value, $Res Function(GSImage) then) =
      _$GSImageCopyWithImpl<$Res>;
  $Res call(
      {String domain,
      String nameID,
      int rarity,
      int size,
      int borderSize,
      bool rounded});
}

/// @nodoc
class _$GSImageCopyWithImpl<$Res> implements $GSImageCopyWith<$Res> {
  _$GSImageCopyWithImpl(this._value, this._then);

  final GSImage _value;
  // ignore: unused_field
  final $Res Function(GSImage) _then;

  @override
  $Res call({
    Object? domain = freezed,
    Object? nameID = freezed,
    Object? rarity = freezed,
    Object? size = freezed,
    Object? borderSize = freezed,
    Object? rounded = freezed,
  }) {
    return _then(_value.copyWith(
      domain: domain == freezed
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nameID: nameID == freezed
          ? _value.nameID
          : nameID // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      borderSize: borderSize == freezed
          ? _value.borderSize
          : borderSize // ignore: cast_nullable_to_non_nullable
              as int,
      rounded: rounded == freezed
          ? _value.rounded
          : rounded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$GSImageCopyWith<$Res> implements $GSImageCopyWith<$Res> {
  factory _$GSImageCopyWith(_GSImage value, $Res Function(_GSImage) then) =
      __$GSImageCopyWithImpl<$Res>;
  @override
  $Res call(
      {String domain,
      String nameID,
      int rarity,
      int size,
      int borderSize,
      bool rounded});
}

/// @nodoc
class __$GSImageCopyWithImpl<$Res> extends _$GSImageCopyWithImpl<$Res>
    implements _$GSImageCopyWith<$Res> {
  __$GSImageCopyWithImpl(_GSImage _value, $Res Function(_GSImage) _then)
      : super(_value, (v) => _then(v as _GSImage));

  @override
  _GSImage get _value => super._value as _GSImage;

  @override
  $Res call({
    Object? domain = freezed,
    Object? nameID = freezed,
    Object? rarity = freezed,
    Object? size = freezed,
    Object? borderSize = freezed,
    Object? rounded = freezed,
  }) {
    return _then(_GSImage(
      domain: domain == freezed
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nameID: nameID == freezed
          ? _value.nameID
          : nameID // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: rarity == freezed
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as int,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      borderSize: borderSize == freezed
          ? _value.borderSize
          : borderSize // ignore: cast_nullable_to_non_nullable
              as int,
      rounded: rounded == freezed
          ? _value.rounded
          : rounded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_GSImage extends _GSImage {
  _$_GSImage(
      {required this.domain,
      required this.nameID,
      this.rarity = 1,
      this.size = 56,
      this.borderSize = 0,
      this.rounded = false})
      : super._();

  @override
  final String domain;
  @override
  final String nameID;
  @JsonKey()
  @override
  final int rarity;
  @JsonKey()
  @override
  final int size;
  @JsonKey()
  @override
  final int borderSize;
  @JsonKey()
  @override
  final bool rounded;

  @JsonKey(ignore: true)
  @override
  _$GSImageCopyWith<_GSImage> get copyWith =>
      __$GSImageCopyWithImpl<_GSImage>(this, _$identity);
}

abstract class _GSImage extends GSImage {
  factory _GSImage(
      {required String domain,
      required String nameID,
      int rarity,
      int size,
      int borderSize,
      bool rounded}) = _$_GSImage;
  _GSImage._() : super._();

  @override
  String get domain;
  @override
  String get nameID;
  @override
  int get rarity;
  @override
  int get size;
  @override
  int get borderSize;
  @override
  bool get rounded;
  @override
  @JsonKey(ignore: true)
  _$GSImageCopyWith<_GSImage> get copyWith =>
      throw _privateConstructorUsedError;
}
