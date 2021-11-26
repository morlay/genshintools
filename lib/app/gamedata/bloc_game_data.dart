import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'player_state.dart';

typedef PlayerStates = Map<int, PlayerState>;

class BlocGameData extends HydratedCubit<PlayerStates> {
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

  syncGameInfo(MiHoYoBBSClient client, int uid) async {
    var data = await client.getUserInfo(uid);

    var ids = data.avatars?.map<int>((e) => e.id).toList() ?? [];

    if (ids.isNotEmpty) {
      Map<int, bool> owns = {};

      var ret = await client.getAllCharacters(uid, ids);

      var ps = playerState(uid);

      for (var avatar in ret.avatars!) {
        var cs = _characterStateFrom(uid, ps, avatar);

        if (cs != null) {
          owns[cs.id] = true;
          ps = ps.mergeCharacterState(cs);
        }
      }

      db.character.characters?.forEach((i, c) {
        if (!(owns[c.id] ?? false)) {
          ps = ps.mergeCharacterState(
            ps.getCharacterOrInitial(db, c).copyWith(
                  own: false,
                  todo: false,
                ),
          );
        }
      });

      emit({
        ...state,
        uid: ps,
      });

      for (var c in ps.characters.values) {
        if (c.own && c.id.toString()[0] != "9") {
          syncCharacterSkillLevels(client, uid, c.id);
        }
      }
    }
  }

  syncCharacterSkillLevels(MiHoYoBBSClient client, int uid, int cid) async {
    var character = db.character.find("$cid");
    var ps = playerState(uid);
    var c = ps.getCharacterOrInitial(db, character);

    if (c.todo && (c.id.toString()[0] != "9")) {
      if (c.skillLevelsLastSyncAt
              ?.add(const Duration(minutes: 10))
              .isBefore(DateTime.now()) ??
          true) {
        log("[$uid] syncing skill levels of ${character.name.text(Lang.CHS)}");

        try {
          await Future.delayed(const Duration(milliseconds: 500));
          var d = await client.getAvatarDetail(uid, c.id);
          var skillLevelsLastSyncAt = DateTime.now();

          var skillLevels = {
            SkillType.NORMAL_ATTACK: d.skillList[0].levelCurrent,
            SkillType.ELEMENTAL_SKILL: d.skillList[1].levelCurrent,
            SkillType.ELEMENTAL_BURST: d.skillList[2].levelCurrent,
          };

          updateCharacterState(uid, c.id, (CharacterState state) {
            return state.copyWith(
              skillLevelsLastSyncAt: skillLevelsLastSyncAt,
              skillLevels: skillLevels,
            );
          });
        } catch (err) {
          log("[$uid] syncing skill levels of ${db.character.find("${c.id}").name.text(Lang.CHS)} failed: $err");
        }
      }
    }
  }

  updateCharacterState(
    int uid,
    int cid,
    CharacterState Function(CharacterState characterState) updateState,
  ) {
    final ps = playerState(uid);
    final prevState = ps.getCharacterOrInitial(db, db.character.find("$cid"));
    emit({...state, uid: ps.mergeCharacterState(updateState(prevState))});
  }

  CharacterWithState? findCharacterWithState(int uid, String id) {
    final c = db.character.find(id);
    return CharacterWithState(
      c,
      playerState(uid).getCharacterOrInitial(db, db.character.find(id)),
    );
  }

  List<CharacterWithState> listCharacterWithState(int uid) {
    return db.character
        .toList()
        .map((c) => CharacterWithState(
            c, playerState(uid).getCharacterOrInitial(db, c)))
        .toList()
      ..sort((a, b) => a.weight() > b.weight() ? -1 : 1);
  }

  CharacterState? _characterStateFrom(
    int uid,
    PlayerState state,
    Avatar avatar,
  ) {
    var weapon = avatar.weapon;

    Map<SkillType, int> skillLevels = {};

    var avatarName = avatar.name;

    if (avatarName == "旅行者") {
      for (var element in ElementType.values) {
        if (element.string() == avatar.element) {
          avatarName = element.label() + avatarName;
        }
      }
    }

    var c = findCharacterWithState(uid, avatarName);

    if (c == null) {
      return null;
    }

    var artifacts = avatar.reliquaries?.asMap().map(
      (i, e) {
        var equipType = EquipType.values[e.pos - 1];

        var builds = c.character.characterAllBuilds();

        return MapEntry(
          equipType,
          PlayerArtifact(
            name: e.name,
            equipType: equipType,
            rarity: e.rarity,
            level: e.level,
            main: builds.artifactMainPropTypes?[equipType]?[0] ?? FightProp.HP,
            usedBy: 0,
            appends: {},
          ),
        );
      },
    );

    var buildState = CharacterBuildState(
      weaponID: weapon?.id ?? 0,
      weaponLevel: weapon?.level ?? 0,
      weaponAffixLevel: weapon?.affixLevel ?? 1,
      artifacts: artifacts ?? {},
    );

    return c.state.copyWith(
      own: true,
      todo: avatar.reliquaries?.length == 5,
      id: c.character.id,
      level: avatar.level,
      activeConstellationNum: avatar.activedConstellationNum,
      skillLevels: skillLevels,
      build: buildState,
      defaultBuild: buildState,
    );
  }

  PlayerState playerState(int uid) {
    return state[uid] ?? PlayerState(characters: {});
  }

  @override
  PlayerStates fromJson(Map<String, dynamic> json) {
    return json.map(
        (key, value) => MapEntry(int.parse(key), PlayerState.fromJson(value)));
  }

  @override
  Map<String, dynamic>? toJson(PlayerStates state) {
    return state.map((key, value) => MapEntry(key.toString(), value.toJson()));
  }
}

class CharacterWithState {
  GSCharacter character;
  CharacterState state;

  CharacterWithState(
    this.character,
    this.state,
  );

  double weight() {
    var i = state.level / 90.0 * 100 + character.rarity / 5 * 100;
    if (!state.own) {
      return -1000 + i;
    }
    if (!state.todo) {
      return -500 + i;
    }
    return i;
  }
}
