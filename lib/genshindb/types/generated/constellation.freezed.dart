// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../constellation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GSConstellation _$GSConstellationFromJson(Map<String, dynamic> json) {
  return _GSConstellation.fromJson(json);
}

/// @nodoc
class _$GSConstellationTearOff {
  const _$GSConstellationTearOff();

  _GSConstellation call(
      {required I18n name,
      required I18n desc,
      required FightProps addProps,
      required List<double> params}) {
    return _GSConstellation(
      name: name,
      desc: desc,
      addProps: addProps,
      params: params,
    );
  }

  GSConstellation fromJson(Map<String, Object?> json) {
    return GSConstellation.fromJson(json);
  }
}

/// @nodoc
const $GSConstellation = _$GSConstellationTearOff();

/// @nodoc
mixin _$GSConstellation {
  I18n get name => throw _privateConstructorUsedError;
  I18n get desc => throw _privateConstructorUsedError;
  FightProps get addProps => throw _privateConstructorUsedError;
  List<double> get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GSConstellationCopyWith<GSConstellation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GSConstellationCopyWith<$Res> {
  factory $GSConstellationCopyWith(
          GSConstellation value, $Res Function(GSConstellation) then) =
      _$GSConstellationCopyWithImpl<$Res>;
  $Res call({I18n name, I18n desc, FightProps addProps, List<double> params});

  $I18nCopyWith<$Res> get name;
  $I18nCopyWith<$Res> get desc;
  $FightPropsCopyWith<$Res> get addProps;
}

/// @nodoc
class _$GSConstellationCopyWithImpl<$Res>
    implements $GSConstellationCopyWith<$Res> {
  _$GSConstellationCopyWithImpl(this._value, this._then);

  final GSConstellation _value;
  // ignore: unused_field
  final $Res Function(GSConstellation) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? desc = freezed,
    Object? addProps = freezed,
    Object? params = freezed,
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
abstract class _$GSConstellationCopyWith<$Res>
    implements $GSConstellationCopyWith<$Res> {
  factory _$GSConstellationCopyWith(
          _GSConstellation value, $Res Function(_GSConstellation) then) =
      __$GSConstellationCopyWithImpl<$Res>;
  @override
  $Res call({I18n name, I18n desc, FightProps addProps, List<double> params});

  @override
  $I18nCopyWith<$Res> get name;
  @override
  $I18nCopyWith<$Res> get desc;
  @override
  $FightPropsCopyWith<$Res> get addProps;
}

/// @nodoc
class __$GSConstellationCopyWithImpl<$Res>
    extends _$GSConstellationCopyWithImpl<$Res>
    implements _$GSConstellationCopyWith<$Res> {
  __$GSConstellationCopyWithImpl(
      _GSConstellation _value, $Res Function(_GSConstellation) _then)
      : super(_value, (v) => _then(v as _GSConstellation));

  @override
  _GSConstellation get _value => super._value as _GSConstellation;

  @override
  $Res call({
    Object? name = freezed,
    Object? desc = freezed,
    Object? addProps = freezed,
    Object? params = freezed,
  }) {
    return _then(_GSConstellation(
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
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _$_GSConstellation extends _GSConstellation {
  _$_GSConstellation(
      {required this.name,
      required this.desc,
      required this.addProps,
      required this.params})
      : super._();

  factory _$_GSConstellation.fromJson(Map<String, dynamic> json) =>
      _$$_GSConstellationFromJson(json);

  @override
  final I18n name;
  @override
  final I18n desc;
  @override
  final FightProps addProps;
  @override
  final List<double> params;

  @override
  String toString() {
    return 'GSConstellation(name: $name, desc: $desc, addProps: $addProps, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GSConstellation &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.desc, desc) &&
            const DeepCollectionEquality().equals(other.addProps, addProps) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(desc),
      const DeepCollectionEquality().hash(addProps),
      const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  _$GSConstellationCopyWith<_GSConstellation> get copyWith =>
      __$GSConstellationCopyWithImpl<_GSConstellation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GSConstellationToJson(this);
  }
}

abstract class _GSConstellation extends GSConstellation {
  factory _GSConstellation(
      {required I18n name,
      required I18n desc,
      required FightProps addProps,
      required List<double> params}) = _$_GSConstellation;
  _GSConstellation._() : super._();

  factory _GSConstellation.fromJson(Map<String, dynamic> json) =
      _$_GSConstellation.fromJson;

  @override
  I18n get name;
  @override
  I18n get desc;
  @override
  FightProps get addProps;
  @override
  List<double> get params;
  @override
  @JsonKey(ignore: true)
  _$GSConstellationCopyWith<_GSConstellation> get copyWith =>
      throw _privateConstructorUsedError;
}
