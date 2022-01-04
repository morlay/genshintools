import 'package:flutter/material.dart';
import 'package:genshintools/syncer/syncer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'player_artifact_build.dart';

typedef PlayerArtifactBuilds = Map<int, PlayerArtifactBuild>;

@deprecated
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

  @override
  PlayerArtifactBuilds fromJson(Map<String, dynamic> json) {
    return json.map((key, value) =>
        MapEntry(int.parse(key), PlayerArtifactBuild.fromJson(value)));
  }

  @override
  Map<String, dynamic> toJson(PlayerArtifactBuilds state) {
    return {};
  }
}
