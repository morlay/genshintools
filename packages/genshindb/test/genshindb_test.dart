import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:genshindb/genshindb.dart';
import 'package:test/test.dart';

void main() async {
  var jsons = await Future.wait([
    '../../assets/genshindb/characters.json',
    '../../assets/genshindb/materials.json',
    '../../assets/genshindb/enemies.json',
    '../../assets/genshindb/artifacts.json',
    '../../assets/genshindb/weapons.json',
  ].map(
    (e) => File(e)
        .readAsString()
        .then((s) => jsonDecode(s) as Map<String, dynamic>),
  ),);

  var db = GSDB.fromJsons(jsons);
  //
  // test("#weaponNextLevelupPlan", () {
  //   for (var i in [70, 80, 86]) {
  //     db.weaponLevelupPlans("祭礼弓", i).forEach((element) {
  //       log(element.action);
  //       for (var element in element.costs) {
  //         log("${element.name.text(Lang.CHS)} x ${element.count!}");
  //       }
  //     });
  //   }
  // });
  //
  // test("#findSet", () {
  //   log(db.artifact.findSet("炽烈的炎之魔女").toString());
  // });
  //

  test('#fightProps', () {
    log(db.character.fightProps('胡桃', 90, 0).toString());
    log(db.weapon.fightProps('决斗之枪', 90, 0).toString());
  });

  test('buildPlayerArtifact', () {
    var list = [
      [
        '角斗士的留恋',
        'HP+!20',
        'Crit.035',
        'ATK.053',
        'ATK+68',
        'CritDMG.194',
      ].join('|'),
      [
        '魔女常燃之羽',
        'ATK+!20',
        'EM+19',
        'ER.104',
        'Crit.105',
        'DEF+63',
      ].join('|'),
      [
        '角斗士的希冀',
        'ATK!20',
        'HP+448',
        'ER.117',
        'CritDMG.194',
        'Crit.078',
      ].join('|'),
      [
        '绯花之壶',
        'PyroDMG!20',
        'ATK+39',
        'ATK.058',
        'Crit.101',
        'DEF.109',
      ].join('|'),
      [
        '焦灼的魔女帽',
        'CritDMG!20',
        'ATK+18',
        'ATK.181',
        'ER.110',
        'EM+21',
      ].join('|'),
    ];

    for (final t in list) {
      print(t);
      var a = PlayerArtifact.fromJson(t);
      print(a);
    }
  });
}
