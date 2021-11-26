// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../prop_grow_curve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PropGrowCurveAndInitial _$$_PropGrowCurveAndInitialFromJson(
        Map<String, dynamic> json) =>
    _$_PropGrowCurveAndInitial(
      growCurve: json['GrowCurve'] as String,
      initial: (json['Initial'] as num).toDouble(),
    );

Map<String, dynamic> _$$_PropGrowCurveAndInitialToJson(
        _$_PropGrowCurveAndInitial instance) =>
    <String, dynamic>{
      'GrowCurve': instance.growCurve,
      'Initial': instance.initial,
    };

_$_PropGrowCurveValueSet _$$_PropGrowCurveValueSetFromJson(
        Map<String, dynamic> json) =>
    _$_PropGrowCurveValueSet(
      (json['values'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k, (e as List<dynamic>).map((e) => (e as num).toDouble()).toList()),
      ),
    );

Map<String, dynamic> _$$_PropGrowCurveValueSetToJson(
        _$_PropGrowCurveValueSet instance) =>
    <String, dynamic>{
      'values': instance.values,
    };
