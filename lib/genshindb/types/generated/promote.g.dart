// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../promote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PromoteSet _$$_PromoteSetFromJson(Map<String, dynamic> json) =>
    _$_PromoteSet(
      (json['promotes'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            int.parse(k),
            (e as List<dynamic>)
                .map((e) => GSPromote.fromJson(e as Map<String, dynamic>))
                .toList()),
      ),
    );

Map<String, dynamic> _$$_PromoteSetToJson(_$_PromoteSet instance) =>
    <String, dynamic>{
      'promotes': instance.promotes.map((k, e) => MapEntry(k.toString(), e)),
    };

_$_Promote _$$_PromoteFromJson(Map<String, dynamic> json) => _$_Promote(
      unlockMaxLevel: json['UnlockMaxLevel'] as int,
      materialCosts: (json['MaterialCosts'] as List<dynamic>)
          .map((e) => GSMaterialCost.fromJson(e as Map<String, dynamic>))
          .toList(),
      addProps: FightProps.fromJson(json['AddProps'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PromoteToJson(_$_Promote instance) =>
    <String, dynamic>{
      'UnlockMaxLevel': instance.unlockMaxLevel,
      'MaterialCosts': instance.materialCosts,
      'AddProps': instance.addProps,
    };
