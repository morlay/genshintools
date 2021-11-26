import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/types.dart';

import 'artifact_service.dart';
import 'character_service.dart';
import 'enemy_service.dart';
import 'material_service.dart';
import 'weapon_service.dart';

class GSDB {
  ArtifactService artifact;
  CharacterService character;
  WeaponService weapon;
  EnemyService enemy;
  MaterialService material;

  GSDB({
    required this.character,
    required this.weapon,
    required this.enemy,
    required this.artifact,
    required this.material,
  });

  factory GSDB.create() => GSDB(
        character: CharacterService(),
        weapon: WeaponService(),
        enemy: EnemyService(),
        artifact: ArtifactService(),
        material: MaterialService(),
      );

  factory GSDB.fromJsons(List<Map<String, dynamic>> jsons) {
    var json = jsons.reduce((value, e) => value..addAll(e));

    return GSDB(
      character: CharacterService.fromJson(json),
      weapon: WeaponService.fromJson(json),
      enemy: EnemyService.fromJson(json),
      artifact: ArtifactService.fromJson(json),
      material: MaterialService.fromJson(json),
    );
  }

  List<LevelupPlan> characterLevelupPlans(String idOrName, int current) {
    var c = character.find(idOrName);

    if (c == null) {
      return [];
    }

    List<LevelupPlan> list = [];

    var from = current;

    for (var to in [21, 41, 51, 61, 71, 81, 86, 90]) {
      if (from < to) {
        var exp = character.levelUpCost(from, to);

        list.add(
          LevelupPlan(
            action: "Lv.$from → Lv.$to",
            costs: [
              material.find("大英雄的经验").copyWith(count: exp ~/ 10000),
              material.find("摩拉").copyWith(count: exp ~/ 5),
              ...character
                  .promoteCosts(
                    c.promoteId,
                    from,
                    to,
                  )
                  .map(
                    (e) => material
                        .find(
                          e.materialNameID,
                        )
                        .copyWith(
                          count: e.count,
                        ),
                  ),
            ],
          ),
        );
        from = to;
      }
    }

    return list;
  }

  List<LevelupPlan> characterSkillLevelupPlans(
    String idOrName,
    SkillType skillType,
    int current,
    int characterLevel,
  ) {
    var c = character.find(idOrName);

    if (c == null) {
      return [];
    }

    var skillTypeStr = const SkillTypeStringConverter().toJson(skillType);

    const maxCharacterLevels = [
      1, // 1
      40, // 2
      40, // 3
      50, // 4
      50, // 5
      50, // 6
      70, // 7
      70, // 8
      80, // 9
    ];

    List<LevelupPlan> list = [];

    var from = current;

    for (var to in List<int>.generate(9, (i) => i + 1)) {
      if (from < to) {
        var costs = c.skillLevelupMaterialCosts[from];

        var maxCharacterLevel = maxCharacterLevels[to - 1];

        list.add(
          LevelupPlan(
              always: characterLevel > maxCharacterLevel,
              action: "$skillTypeStr.$from → $skillTypeStr.$to",
              costs: costs
                  .map((e) =>
                      material.find(e.materialNameID).copyWith(count: e.count))
                  .toList()),
        );
        from = to;
      }
    }

    return list;
  }

  List<LevelupPlan> weaponLevelupPlans(String idOrName, int current) {
    var w = weapon.find(idOrName);

    if (w == null) {
      return [];
    }

    List<LevelupPlan> list = [];

    var from = current;

    for (var to in [21, 41, 51, 61, 71, 81, 90]) {
      if (from < to) {
        var exp = weapon.levelUpCost(w.rarity, from, to);

        list.add(LevelupPlan(
          action: "Lv.$from → Lv.$to",
          costs: [
            material.find("精锻用魔矿").copyWith(count: exp ~/ 10000),
            material.find("摩拉").copyWith(count: exp),
            ...weapon
                .promoteCosts(
                  w.promoteId,
                  from,
                  to,
                )
                .map(
                  (e) => material
                      .find(
                        e.materialNameID,
                      )
                      .copyWith(
                        count: e.count,
                      ),
                ),
          ],
        ));

        from = to;
      }
    }

    return list;
  }
}

class LevelupPlan {
  String action;
  List<GSMaterial> costs;
  bool always;

  LevelupPlan({
    required this.action,
    required this.costs,
    this.always = true,
  });

  @override
  String toString() {
    return "$action: ${costs.map((e) => e.toString()).join("; ")}";
  }
}
