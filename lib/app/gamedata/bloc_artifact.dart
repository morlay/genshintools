import 'package:flutter/material.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/syncer/syncer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'player_artifact_build.dart';

typedef PlayerArtifactBuilds = Map<int, PlayerArtifactBuild>;

class BlocArtifact extends HydratedCubit<PlayerArtifactBuilds>
    with WebDAVSyncMixin {
  BlocArtifact() : super({});

  static BlocArtifact read(BuildContext context) {
    return context.read<BlocArtifact>();
  }

  static BlocArtifact watch(BuildContext context) {
    return context.watch<BlocArtifact>();
  }

  PlayerArtifactBuild playerArtifactBuild(int uid) {
    return state[uid] ?? PlayerArtifactBuild.empty();
  }

  equip(int uid, PlayerArtifact pa, [PlayerArtifact? from]) {
    emit({...state, uid: playerArtifactBuild(uid).equip(pa, from)});
  }

  remove(int uid, PlayerArtifact pa) {
    emit({
      ...state,
      uid: playerArtifactBuild(uid).remove(pa),
    });
  }

  @override
  PlayerArtifactBuilds fromJson(Map<String, dynamic> json) {
    return json.map((key, value) =>
        MapEntry(int.parse(key), PlayerArtifactBuild.fromJson(value)));
  }

  @override
  Map<String, dynamic> toJson(PlayerArtifactBuilds state) {
    return state.map((key, value) => MapEntry(key.toString(), value.toJson()));
  }
}
