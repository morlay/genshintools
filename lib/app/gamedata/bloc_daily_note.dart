import 'package:flutter/material.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

typedef DailyNotes = Map<int, DailyNote>;

class BlocDailyNote extends HydratedCubit<DailyNotes> {
  BlocDailyNote() : super({});

  static BlocDailyNote read(BuildContext context) {
    return context.read<BlocDailyNote>();
  }

  static BlocDailyNote watch(BuildContext context) {
    return context.watch<BlocDailyNote>();
  }

  syncDailyNote(int uid, DailyNote data) {
    emit({
      ...state,
      uid: data,
    });
  }

  dailyNote(int uid) {
    return state[uid] ??
        DailyNote(
          currentResin: 0,
          maxResin: 160,
          resinRecoveryTime: "",
          finishedTaskNum: 0,
          totalTaskNum: 4,
          remainResinDiscountNum: 0,
          resinDiscountNumLimit: 3,
          currentExpeditionNum: 3,
          maxExpeditionNum: 5,
          expeditions: [],
        );
  }

  @override
  DailyNotes fromJson(Map<String, dynamic> json) {
    return json.map(
        (key, value) => MapEntry(int.parse(key), DailyNote.fromJson(value)));
  }

  @override
  Map<String, dynamic> toJson(DailyNotes state) {
    return state.map((key, value) => MapEntry(key.toString(), value.toJson()));
  }
}
