import 'package:flutter/cupertino.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'webdav.dart';

class BlocSyncer extends HydratedCubit<WebDAV?> {
  static BlocSyncer read(BuildContext buildContext) {
    return buildContext.read<BlocSyncer>();
  }

  static BlocSyncer watch(BuildContext buildContext) {
    return buildContext.watch<BlocSyncer>();
  }

  BlocSyncer() : super(null);

  bind(WebDAV webdav) {
    emit(webdav);
  }

  sync() {
    state?.let(
      (state) => emit(
        state.copyWith(
          syncAt: DateTime.now(),
          fromServer: false,
        ),
      ),
    );
  }

  syncFromServer() {
    state?.let(
      (state) => emit(
        state.copyWith(
          syncAt: DateTime.now(),
          fromServer: true,
        ),
      ),
    );
  }

  @override
  WebDAV? fromJson(Map<String, dynamic> json) {
    return WebDAV.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(WebDAV? state) {
    return state?.toJson();
  }
}
