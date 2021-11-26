import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';

part 'generated/gacha_state.freezed.dart';
part 'generated/gacha_state.g.dart';

@freezed
class GachaState with _$GachaState {
  GachaState._();

  factory GachaState({
    @Default({}) Map<String, List<GachaLog>> logs,
  }) = _GachaState;

  factory GachaState.fromJson(Map<String, dynamic> json) =>
      _GachaState.fromJson(json);

  GachaState withGachaLogs(GachaType type, List<GachaLog> gachaLogs) {
    return copyWith(
      logs: {
        ...logs,
        type.name: gachaLogs.toSet().toList()
          ..sort((a, b) => a.id.compareTo(b.id)),
      },
    );
  }

  List<GachaLog> sortAndCount(List<GachaLog> logs) {
    var gachaLogs = [...logs]..sort((a, b) => a.id.compareTo(b.id));

    var countSinceLastPurple = 0;
    var countSinceLastGold = 0;
    var index = 0;

    for (var i in gachaLogs) {
      countSinceLastGold++;
      countSinceLastPurple++;

      gachaLogs[index] = i.copyWith(
        countSinceLastPurple: countSinceLastPurple,
        countSinceLastGold: countSinceLastGold,
      );

      if (i.rankType == "4") {
        countSinceLastPurple = 0;
      }

      if (i.rankType == "5") {
        countSinceLastPurple = 0;
        countSinceLastGold = 0;
      }

      index++;
    }

    return gachaLogs;
  }
}
