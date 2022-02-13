import 'package:flutter/material.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';
import 'package:genshintools/syncer/syncer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'gacha_state.dart';

typedef GachaStates = Map<int, GachaState>;

class BlocGacha extends HydratedCubit<GachaStates> with WebDAVSyncMixin {
  BlocGacha() : super({});

  static BlocGacha read(BuildContext context) {
    return context.read<BlocGacha>();
  }

  static BlocGacha watch(BuildContext context) {
    return context.watch<BlocGacha>();
  }

  syncGachaLogs(
    int uid,
    List<GachaLog> logs,
  ) {
    emit({...state, uid: gachaState(uid).withGachaLogs(logs)});
  }

  GachaState gachaState(int uid) {
    return state[uid] ??
        GachaState(info: UigfInfo(uid: "$uid", lang: "zh-cn"), list: []);
  }

  @override
  GachaStates fromJson(Map<String, dynamic> json) {
    return json.map(
      (key, value) => MapEntry(int.parse(key), GachaState.fromJson(value)),
    );
  }

  @override
  Map<String, dynamic> toJson(GachaStates state) {
    return state.map((key, value) => MapEntry(key.toString(), value.toJson()));
  }
}
