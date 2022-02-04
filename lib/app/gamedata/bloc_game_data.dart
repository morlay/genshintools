import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genshintools/app/gamedata/player_state.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';
import 'package:genshintools/syncer/syncer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

typedef PlayerStates = Map<int, GOOD>;

class BlocGameData extends HydratedCubit<PlayerStates> with WebDAVSyncMixin {
  GSDB db;

  BlocGameData(this.db) : super({});

  static BlocGameData read(BuildContext context) {
    return context.read<BlocGameData>();
  }

  static BlocGameData watch(BuildContext context) {
    return context.watch<BlocGameData>();
  }

  static Future<GSDB> dbFromAssetBundle(AssetBundle assetBundle) async {
    try {
      final jsons = await Future.wait([
        'assets/genshindb/artifacts.json',
        'assets/genshindb/characters.json',
        'assets/genshindb/enemies.json',
        'assets/genshindb/materials.json',
        'assets/genshindb/weapons.json',
      ].map(
        (e) => assetBundle
            .loadString(e)
            .then((v) => jsonDecode(v) as Map<String, dynamic>),
      ));

      return GSDB.fromJsons(jsons);
    } catch (err) {
      log("$err");
      return GSDB.create();
    }
  }

  syncGameInfo(MiHoYoBBSClient client, int uid,
      [Iterable<PlayerArtifact>? playerArtifacts]) async {
    var data = await client.getUserInfo(uid);

    var ids = data.avatars?.map<int>((e) => e.id).toList() ?? [];

    if (ids.isNotEmpty) {
      var ret = await client.getAllCharacters(uid, ids);

      var next = _patchGOODFromMiYoBBS(
        uid,
        playerState(uid),
        ret.avatars ?? [],
        playerArtifacts,
      );

      emit({
        ...state,
        uid: next,
      });

      for (var c in next.characters) {
        if (c.level > 0) {
          _syncCharacterSkillLevels(client, uid, c.key);
        }
      }
    }
  }

  final Map<String, DateTime> _talentLastSyncAts = {};

  _syncCharacterSkillLevels(MiHoYoBBSClient client, int uid, String key) async {
    var c = db.character.find(key);

    if (!key.contains("Traveler")) {
      if (_talentLastSyncAts["$key@$uid"]
              ?.add(const Duration(minutes: 10))
              .isBefore(DateTime.now()) ??
          true) {
        log("[$uid] syncing skill levels of ${c.name.text(Lang.CHS)}");

        _talentLastSyncAts["$key@$uid"] = DateTime.now();

        try {
          await Future.delayed(const Duration(milliseconds: 500));

          var d = await client.getAvatarDetail(uid, c.id);

          var skillList = d.skillList.where((e) => e.maxLevel == 10).toList();

          var talent = {
            TalentType.auto: skillList[0].levelCurrent,
            TalentType.skill: skillList[1].levelCurrent,
            TalentType.burst: skillList[2].levelCurrent,
          };

          updateCharacter(uid, key, (GOODCharacter c) {
            return c.copyWith(
              talent: talent,
            );
          });
        } catch (err) {
          log("[$uid] syncing skill levels of ${db.character.find("${c.id}").name.text(Lang.CHS)} failed: $err");
        }
      }
    }
  }

  void equipArtifact(int uid, GOODArtifact artifact, [GOODArtifact? value]) {
    emit({...state, uid: playerState(uid).equipArtifact(artifact, value)});
  }

  void removeArtifact(int uid, GOODArtifact artifact) {
    emit({
      ...state,
      uid: playerState(uid).removeArtifact(artifact),
    });
  }

  updateCharacter(
    int uid,
    String key,
    GOODCharacter Function(GOODCharacter c) updateState,
  ) {
    emit({...state, uid: playerState(uid).updateCharacter(key, updateState)});
  }

  CharacterWithState findCharacterWithState(int uid, String id) {
    final ps = playerState(uid);
    final c = db.character.find(id);

    return CharacterWithState(
      character: c,
      c: ps.character(c.key),
      w: ps.weaponOn(c.key, c.initialWeaponKey),
      artifacts: ps.artifactsOn(c.key),
    );
  }

  List<CharacterWithState> listCharacterWithState(int uid) {
    final ps = playerState(uid);

    return db.character
        .toList()
        .map((c) => CharacterWithState(
              character: c,
              c: ps.character(c.key),
              w: ps.weaponOn(
                c.key,
                c.initialWeaponKey,
              ),
              artifacts: ps.artifactsOn(c.key),
            ))
        .toList()
      ..sort((a, b) => a.weight() > b.weight() ? -1 : 1);
  }

  GOOD _patchGOODFromMiYoBBS(int uid, GOOD good, List<Avatar> avatars,
      [Iterable<PlayerArtifact>? playerArtifacts]) {
    playerArtifacts?.forEach((pa) {
      db.character.findOrNull("${pa.usedBy}")?.let((c) {
        final location = c.key;

        db.artifact.findOrNull(pa.name)?.let((a) {
          good = good.updateArtifact(
            SlotKey.values[a.equipType.index],
            location,
            (artifact) => artifact.copyWith(
              setKey: a.setKey,
              mainStatKey: GOODArtifact.statKeyFromFightProp(pa.main),
              substats: [
                ...pa.appends.keys.map((fp) {
                  return GOODSubStat(key: GOODArtifact.statKeyFromFightProp(fp))
                      .withStringValue(pa.appends[fp]!);
                })
              ],
            ),
          );
        });
      });
    });

    Map<String, bool> owned = {};

    for (var avatar in avatars) {
      var avatarName = avatar.name;

      if (avatarName == "旅行者") {
        for (var element in ElementType.values) {
          if (element.string() == avatar.element) {
            avatarName = element.label() + avatarName;
          }
        }
      }

      db.character.findOrNull(avatarName)?.let((c) {
        final location = c.key;

        good = good.updateCharacter(
            location,
            (gc) => gc.copyWith(
                  role: c.defaultCharacterBuildRole(gc.role),
                  level: avatar.level,
                  constellation: avatar.activedConstellationNum,
                  ascension: GOODCharacter.ascensionByLevel(avatar.level),
                ));

        owned[location] = true;

        avatar.weapon?.let((weapon) {
          db.weapon.findOrNull(weapon.name)?.let((w) {
            good = good.updateWeapon(
              location,
              (gw) => gw.copyWith(
                key: w.key,
                level: weapon.level,
                refinement: weapon.affixLevel,
                ascension: weapon.promoteLevel,
              ),
              w.key,
            );
          });
        });

        avatar.reliquaries?.let((rs) {
          for (var r in rs) {
            db.artifact.findOrNull(r.name)?.let((a) {
              good = good.updateArtifact(
                SlotKey.values[a.equipType.index],
                location,
                (artifact) => artifact.copyWith(
                  setKey: a.setKey,
                  level: r.level,
                  rarity: r.rarity,
                ),
              );
            });
          }
        });
      });
    }

    return good.copyWith(
      characters: good.characters.where((e) => owned[e.key] ?? false).toList(),
    );
  }

  GOOD playerState(int uid) {
    return state[uid] ?? GOOD.empty();
  }

  @override
  PlayerStates fromJson(Map<String, dynamic> json) {
    return json
        .map((key, value) => MapEntry(int.parse(key), GOOD.fromJson(value)));
  }

  @override
  Map<String, dynamic>? toJson(PlayerStates state) {
    return state.map((key, value) => MapEntry(key.toString(), value.toJson()));
  }
}
