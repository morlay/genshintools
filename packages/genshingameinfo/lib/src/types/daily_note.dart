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
    required List<DailyNoteExpedition> expeditions,
    required int currentHomeCoin,
    required int maxHomeCoin,
    required String homeCoinRecoveryTime,
  }) = _DailyNote;

  factory DailyNote.fromJson(Map<String, dynamic> json) =>
      _DailyNote.fromJson(json);
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
