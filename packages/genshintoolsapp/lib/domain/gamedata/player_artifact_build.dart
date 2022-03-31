import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/genshindb.dart';

part '__generated__/player_artifact_build.freezed.dart';

@freezed
class PlayerArtifactBuild with _$PlayerArtifactBuild {
  PlayerArtifactBuild._();

  factory PlayerArtifactBuild({
    required HashMap<PlayerArtifact, int> builds,
  }) = _PlayerArtifactBuild;

  factory PlayerArtifactBuild.fromJson(Map<String, dynamic> json) {
    var v = {
      // "魔女常燃之羽!5!羽!10000049|ATK+!20|EM+19?1|ER.104?2|Crit.105?3|DEF+63?3": 0,
      // "角斗士的希冀!5!沙!10000049|ATK!20|HP+448?2|ER.117?2|CritDMG.194?3|Crit.078?2":
      //     0,
      // "角斗士的留恋!5!花!10000049|HP+!20|Crit.035?1|ATK.053?1|ATK+68?4|CritDMG.194?3":
      //     0,
      // "绯花之壶!5!杯!10000049|PyroDMG!20|ATK+39?2|ATK.058?1|Crit.101?3|DEF.109?2": 0,
      // "焦灼的魔女帽!5!头!10000049|CritDMG!20|ATK+18?1|ATK.181?4|ER.110?2|EM+21?1": 0,
      // "羁缠之花!5!花!10000042|HP+!20|ATK.099?2|CritDMG.210?3|ER.052?1|DEF.117?2": 0,
      // "雷灾的孑遗!5!羽!10000042|ATK+!20|ATK.163?3|Crit.070?2|ER.065?1|HP.093?2": 0,
      // "吟游者之壶!5!杯!10000042|ElectroDMG!20|CritDMG.132?2|EM+42?2|DEF+23?1|Crit.097?3":
      //     0,
      // "指挥的礼帽!5!头!10000042|Crit!20|EM+44?2|ATK.105?2|ATK+18?1|DEF+56?3": 0,
      // "雷霆的时计!5!沙!10000042|ATK!20|EM+54?3|ATK+16?1|HP.099?2|Crit.066?2": 0,
      // "魔女的炎之花!5!花!10000046|HP+!20|CritDMG.148?2|ATK.105?2|EM+42?2|ER.162?3": 0,
      // "琴师的箭羽!5!羽!10000046|ATK+!20|CritDMG.062?1|HP+568?2|HP.047?1|Crit.117?3": 0
    };

    return PlayerArtifactBuild(
      builds: HashMap.of(({...?(json["builds"] as Map<String, dynamic>?), ...v})
          .map((key, value) {
        var pa = PlayerArtifact.fromJson(key);
        var usedBy = pa.usedBy != 0 ? pa.usedBy : value;

        return MapEntry(pa.copyWith(usedBy: usedBy), usedBy);
      })),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "builds": builds.map((key, value) => MapEntry(key.toJson(), value))
    };
  }

  factory PlayerArtifactBuild.empty() => PlayerArtifactBuild(
        builds: HashMap(),
      );

  Iterable<PlayerArtifact> allArtifacts() {
    List<PlayerArtifact> list = [];

    for (var pa in builds.keys) {
      list.add(pa.copyWith(usedBy: builds[pa]!));
    }

    return list;
  }

  PlayerArtifactBuild equip(PlayerArtifact newPa, [PlayerArtifact? fromPa]) {
    var usedBy = builds[newPa] ?? 0;

    builds[newPa] = newPa.usedBy;

    if (fromPa != null) {
      if ((builds[fromPa] ?? 0) == newPa.usedBy) {
        builds.remove(fromPa);
      } else {
        builds[fromPa] = usedBy;
      }
    }

    for (var pa in builds.keys) {
      if (pa != newPa &&
          builds[pa] == newPa.usedBy &&
          pa.equipType == newPa.equipType) {
        builds[pa] = 0;
      }
    }

    return copyWith(
      builds: builds,
    );
  }
}
