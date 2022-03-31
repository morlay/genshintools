import 'package:flutter/cupertino.dart';
import 'package:genshingameinfo/genshingameinfo.dart';
import 'package:genshintoolsapp/domain/syncer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'auth_state.dart';

class BlocAuth extends HydratedCubit<AuthState> with WebDAVSyncMixin {
  static BlocAuth read(BuildContext context) {
    return context.read<BlocAuth>();
  }

  static BlocAuth watch(BuildContext context) {
    return context.watch<BlocAuth>();
  }

  BlocAuth()
      : super(AuthState(
          currentUID: "",
        ));

  addAccounts({
    required List<GameRole> gameRoles,
    required String encodedCookie,
  }) {
    emit(state.mergeFrom(gameRoles, encodedCookie));
  }

  removeAccount(String uid) {
    emit(state.remove(uid));
  }

  switchAccount(String uid) {
    emit(state.copyWith(
      currentUID: uid,
    ));
  }

  switchChannel(String channel) {
    emit(state.copyWith(
      channel: channel,
    ));
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    if (json["encodedCookie"] != null) {
      return AuthStateV1.fromJson(json).convertToNew();
    }
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
