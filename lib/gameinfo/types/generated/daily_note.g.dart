// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../daily_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DailyNote _$$_DailyNoteFromJson(Map<String, dynamic> json) => _$_DailyNote(
      currentResin: json['current_resin'] as int,
      maxResin: json['max_resin'] as int,
      resinRecoveryTime: json['resin_recovery_time'] as String,
      finishedTaskNum: json['finished_task_num'] as int,
      totalTaskNum: json['total_task_num'] as int,
      remainResinDiscountNum: json['remain_resin_discount_num'] as int,
      resinDiscountNumLimit: json['resin_discount_num_limit'] as int,
      currentExpeditionNum: json['current_expedition_num'] as int,
      maxExpeditionNum: json['max_expedition_num'] as int,
      expeditions: (json['expeditions'] as List<dynamic>)
          .map((e) => DailyNoteExpedition.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DailyNoteToJson(_$_DailyNote instance) =>
    <String, dynamic>{
      'current_resin': instance.currentResin,
      'max_resin': instance.maxResin,
      'resin_recovery_time': instance.resinRecoveryTime,
      'finished_task_num': instance.finishedTaskNum,
      'total_task_num': instance.totalTaskNum,
      'remain_resin_discount_num': instance.remainResinDiscountNum,
      'resin_discount_num_limit': instance.resinDiscountNumLimit,
      'current_expedition_num': instance.currentExpeditionNum,
      'max_expedition_num': instance.maxExpeditionNum,
      'expeditions': instance.expeditions,
    };

_$_DailyNoteExpedition _$$_DailyNoteExpeditionFromJson(
        Map<String, dynamic> json) =>
    _$_DailyNoteExpedition(
      status: json['status'] as String,
      remainedTime: json['remained_time'] as String,
    );

Map<String, dynamic> _$$_DailyNoteExpeditionToJson(
        _$_DailyNoteExpedition instance) =>
    <String, dynamic>{
      'status': instance.status,
      'remained_time': instance.remainedTime,
    };
