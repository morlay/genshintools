import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';

part 'generated/gacha_state.freezed.dart';
part 'generated/gacha_state.g.dart';

// https://github.com/DGP-Studio/Snap.Genshin/wiki/StandardFormat
@freezed
class UigfInfo with _$UigfInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory UigfInfo({
    required String uid,
    required String lang,
    @Default("v2.2") String uigfVersion,
  }) = _UigfInfo;

  factory UigfInfo.fromJson(Map<String, dynamic> json) =>
      _UigfInfo.fromJson(json);
}

@freezed
class GachaState with _$GachaState {
  GachaState._();

  factory GachaState({
    required List<GachaLog> list,
    UigfInfo? info,
  }) = _GachaState;

  static Map<String, dynamic> migrateFromOldStruct(Map<String, dynamic> json) {
    if (json["list"] == null) {
      var logs = ((json["logs"] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as List))).values;
      return {
        "list": logs.expand((l) => l).toList(),
      };
    }
    return json;
  }

  factory GachaState.fromJson(Map<String, dynamic> json) =>
      _GachaState.fromJson(migrateFromOldStruct(json)).withGachaLogs([]);

  GachaState withGachaLogs(List<GachaLog> gachaLogs) {
    var nextList = {
      ...list,
      ...gachaLogs,
    }
        .map(
          (e) => e.copyWith(
            uigfGachaType: e.gachaType == "400" ? "301" : e.gachaType,
          ),
        )
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));

    var finalInfo = nextList.isNotEmpty
        ? UigfInfo(
            uid: nextList.first.uid,
            lang: nextList.first.lang,
          )
        : info;

    return copyWith(
      info: finalInfo,
      list: nextList,
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

  List<GachaLog> listFor(String type) {
    return list.where((a) => a.uigfGachaType == type).toList();
  }
}
