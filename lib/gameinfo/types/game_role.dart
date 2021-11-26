import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/game_role.freezed.dart';
part 'generated/game_role.g.dart';

@freezed
class GameRole with _$GameRole {
  GameRole._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  factory GameRole({
    required String gameBiz,
    required String gameUid,
    required String regionName,
    required bool isChosen,
    required String region,
    required String nickname,
    required int level,
  }) = _GameRole;

  factory GameRole.fromJson(Map<String, dynamic> json) =>
      _GameRole.fromJson(json);
}
