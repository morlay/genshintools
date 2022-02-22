import 'package:freezed_annotation/freezed_annotation.dart';

part '__generated__/game_role.freezed.dart';
part '__generated__/game_role.g.dart';

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
