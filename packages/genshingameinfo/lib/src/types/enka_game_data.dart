import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/genshindb.dart';

part '__generated__/enka_game_data.freezed.dart';

part '__generated__/enka_game_data.g.dart';

@freezed
class EnkaGameData with _$EnkaGameData {
  factory EnkaGameData({
    required List<EnkaAvatarInfo> avatarInfoList,
  }) = _EnkaGameData;

  factory EnkaGameData.fromJson(Map<String, dynamic> json) =>
      _EnkaGameData.fromJson(json);
}

@freezed
class EnkaAvatarInfo with _$EnkaAvatarInfo {
  factory EnkaAvatarInfo({
    required int avatarId,
    required List<EnkaEquip> equipList,
  }) = _EnkaAvatarInfo;

  factory EnkaAvatarInfo.fromJson(Map<String, dynamic> json) =>
      _EnkaAvatarInfo.fromJson(json);
}

@freezed
class EnkaEquip with _$EnkaEquip {
  EnkaEquip._();

  factory EnkaEquip({
    required Map<String, dynamic> flat,
    required Map<String, dynamic>? reliquary,
  }) = _EnkaEquip;

  factory EnkaEquip.fromJson(Map<String, dynamic> json) =>
      _EnkaEquip.fromJson(json);

  bool isReliquary() {
    return flat["reliquaryMainstat"] != null;
  }

  String setID() {
    return (flat["icon"] as String).split("_")[2];
  }

  GOODArtifact toGOODArtifact(String location, String setKey) {
    return GOODArtifact(
      location: location,
      rarity: flat["rankLevel"].toInt(),
      level: (reliquary?["level"] ?? 1).toInt() - 1,
      setKey: setKey,
      slotKey: SlotKey
          .values[EquipTypeStringConverter().fromJson(flat["equipType"]).index],
      mainStatKey: GOODArtifact.statKeyFromFightProp(FightPropStringConverter()
          .fromJson(flat["reliquaryMainstat"]?["mainPropId"] ?? "")),
      substats: (flat["reliquarySubstats"] as List<dynamic>)
          .map((item) => GOODSubStat(
                key: GOODArtifact.statKeyFromFightProp(
                    FightPropStringConverter().fromJson(item["appendPropId"])),
                value: item["statValue"].toDouble(),
              ))
          .toList(),
    );
  }
}
