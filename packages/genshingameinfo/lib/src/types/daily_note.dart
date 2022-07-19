import 'package:freezed_annotation/freezed_annotation.dart';

part '__generated__/daily_note.freezed.dart';

part '__generated__/daily_note.g.dart';

@freezed
class DailyNote with _$DailyNote {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DailyNote({
    required int currentResin,
    required int maxResin,
    required String resinRecoveryTime,
    required int finishedTaskNum,
    required int totalTaskNum,
    required int remainResinDiscountNum,
    required int resinDiscountNumLimit,
    required int currentExpeditionNum,
    required int maxExpeditionNum,
    required int currentHomeCoin,
    required int maxHomeCoin,
    required String homeCoinRecoveryTime,
    required Transformer transformer,
    required List<DailyNoteExpedition> expeditions,
  }) = _DailyNote;

  factory DailyNote.fromJson(Map<String, dynamic> json) =>
      _DailyNote.fromJson(json);
}

@freezed
class Transformer with _$Transformer {
  Transformer._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Transformer({
    required bool obtained,
    // {Day: 1, Hour: 0, Minute: 0, Second: 0, reached: false}
    Map<String, dynamic>? recoveryTime,
  }) = _Transformer;

  factory Transformer.fromJson(Map<String, dynamic> json) =>
      _Transformer.fromJson(json);

  int get(String prop) {
    return recoveryTime?[prop] ?? 0;
  }

  String cd() {
    return get('Day') != 0
        ? "${get('Day')}d"
        : get('Hour') != 0
            ? "${get('Hour')}h"
            : "${0}";
  }
}

@freezed
class DailyNoteExpedition with _$DailyNoteExpedition {
  DailyNoteExpedition._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory DailyNoteExpedition({
    required String status,
    required String remainedTime,
  }) = _DailyNoteExpedition;

  factory DailyNoteExpedition.fromJson(Map<String, dynamic> json) =>
      _DailyNoteExpedition.fromJson(json);
}
