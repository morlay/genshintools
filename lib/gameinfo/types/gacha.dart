import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/gacha.freezed.dart';
part 'generated/gacha.g.dart';

@freezed
class GachaType with _$GachaType {
  factory GachaType({
    required String key,
    required String name,
    String? id,
  }) = _GachaType;

  factory GachaType.fromJson(Map<String, dynamic> json) =>
      _GachaType.fromJson(json);
}

@freezed
class GachaLog with _$GachaLog {
  GachaLog._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory GachaLog({
    required String gachaType,
    required String id,
    required String uid,
    required String name,
    required String lang,
    required String itemType,
    required String rankType,
    required DateTime time,
    @JsonKey(ignore: true) @Default(0) int countSinceLastGold,
    @JsonKey(ignore: true) @Default(0) int countSinceLastPurple,
    String? uigfGachaType,
  }) = _GachaLog;

  factory GachaLog.fromJson(Map<String, dynamic> json) =>
      _GachaLog.fromJson(json);

  @override
  bool operator ==(Object other) {
    return other is GachaLog && hashCode == other.hashCode;
  }

  @override
  int get hashCode => int.parse(id);
}
