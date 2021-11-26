// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of '../release.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Release _$ReleaseFromJson(Map<String, dynamic> json) {
  return _Release.fromJson(json);
}

/// @nodoc
class _$ReleaseTearOff {
  const _$ReleaseTearOff();

  _Release call(
      {required String packageName,
      required String version,
      required String buildNumber,
      required String downloadURL,
      String? description}) {
    return _Release(
      packageName: packageName,
      version: version,
      buildNumber: buildNumber,
      downloadURL: downloadURL,
      description: description,
    );
  }

  Release fromJson(Map<String, Object?> json) {
    return Release.fromJson(json);
  }
}

/// @nodoc
const $Release = _$ReleaseTearOff();

/// @nodoc
mixin _$Release {
  String get packageName => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get buildNumber => throw _privateConstructorUsedError;
  String get downloadURL => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReleaseCopyWith<Release> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReleaseCopyWith<$Res> {
  factory $ReleaseCopyWith(Release value, $Res Function(Release) then) =
      _$ReleaseCopyWithImpl<$Res>;
  $Res call(
      {String packageName,
      String version,
      String buildNumber,
      String downloadURL,
      String? description});
}

/// @nodoc
class _$ReleaseCopyWithImpl<$Res> implements $ReleaseCopyWith<$Res> {
  _$ReleaseCopyWithImpl(this._value, this._then);

  final Release _value;
  // ignore: unused_field
  final $Res Function(Release) _then;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? version = freezed,
    Object? buildNumber = freezed,
    Object? downloadURL = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      buildNumber: buildNumber == freezed
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as String,
      downloadURL: downloadURL == freezed
          ? _value.downloadURL
          : downloadURL // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ReleaseCopyWith<$Res> implements $ReleaseCopyWith<$Res> {
  factory _$ReleaseCopyWith(_Release value, $Res Function(_Release) then) =
      __$ReleaseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String packageName,
      String version,
      String buildNumber,
      String downloadURL,
      String? description});
}

/// @nodoc
class __$ReleaseCopyWithImpl<$Res> extends _$ReleaseCopyWithImpl<$Res>
    implements _$ReleaseCopyWith<$Res> {
  __$ReleaseCopyWithImpl(_Release _value, $Res Function(_Release) _then)
      : super(_value, (v) => _then(v as _Release));

  @override
  _Release get _value => super._value as _Release;

  @override
  $Res call({
    Object? packageName = freezed,
    Object? version = freezed,
    Object? buildNumber = freezed,
    Object? downloadURL = freezed,
    Object? description = freezed,
  }) {
    return _then(_Release(
      packageName: packageName == freezed
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      version: version == freezed
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      buildNumber: buildNumber == freezed
          ? _value.buildNumber
          : buildNumber // ignore: cast_nullable_to_non_nullable
              as String,
      downloadURL: downloadURL == freezed
          ? _value.downloadURL
          : downloadURL // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_Release extends _Release {
  _$_Release(
      {required this.packageName,
      required this.version,
      required this.buildNumber,
      required this.downloadURL,
      this.description})
      : super._();

  factory _$_Release.fromJson(Map<String, dynamic> json) =>
      _$$_ReleaseFromJson(json);

  @override
  final String packageName;
  @override
  final String version;
  @override
  final String buildNumber;
  @override
  final String downloadURL;
  @override
  final String? description;

  @override
  String toString() {
    return 'Release(packageName: $packageName, version: $version, buildNumber: $buildNumber, downloadURL: $downloadURL, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Release &&
            const DeepCollectionEquality()
                .equals(other.packageName, packageName) &&
            const DeepCollectionEquality().equals(other.version, version) &&
            const DeepCollectionEquality()
                .equals(other.buildNumber, buildNumber) &&
            const DeepCollectionEquality()
                .equals(other.downloadURL, downloadURL) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(packageName),
      const DeepCollectionEquality().hash(version),
      const DeepCollectionEquality().hash(buildNumber),
      const DeepCollectionEquality().hash(downloadURL),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$ReleaseCopyWith<_Release> get copyWith =>
      __$ReleaseCopyWithImpl<_Release>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReleaseToJson(this);
  }
}

abstract class _Release extends Release {
  factory _Release(
      {required String packageName,
      required String version,
      required String buildNumber,
      required String downloadURL,
      String? description}) = _$_Release;
  _Release._() : super._();

  factory _Release.fromJson(Map<String, dynamic> json) = _$_Release.fromJson;

  @override
  String get packageName;
  @override
  String get version;
  @override
  String get buildNumber;
  @override
  String get downloadURL;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$ReleaseCopyWith<_Release> get copyWith =>
      throw _privateConstructorUsedError;
}
