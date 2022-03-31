import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc_syncer.dart';

mixin WebDAVSyncMixin {
  bool webDAVSyncEnabled() {
    return true;
  }
}

class WebDAVSyncer implements BlocObserver {
  static WebDAVSyncer read(BuildContext context) {
    return context.read<WebDAVSyncer>();
  }

  BlocSyncer? blocSyncer;
  List<HydratedMixin> blocs = [];

  Provider provide(Widget child) {
    return Provider<WebDAVSyncer>.value(value: this, child: child);
  }

  @override
  void onCreate(BlocBase bloc) {
    if (bloc is BlocSyncer) {
      blocSyncer = bloc;
    }

    if (bloc is HydratedMixin && bloc is WebDAVSyncMixin) {
      blocs.add(bloc);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {}

  sync({bool? fromServer}) async {
    var c = blocSyncer!.state;
    if (c.shouldSync()) {
      if (fromServer == true) {
        for (var b in blocs) {
          var json = await c.readJson(
            "${b.runtimeType}.json",
          );
          if (json != null) {
            b.emit(b.fromJson(json));
          }
        }
        return;
      }

      for (var b in blocs) {
        await c.writeJsonIfChanged(
          "${b.runtimeType}.json",
          b.toJson(b.state),
        );
      }
    }
  }

  @override
  void onClose(BlocBase bloc) {}

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc bloc, Object? event) {}

  @override
  void onTransition(Bloc bloc, Transition transition) {}
}
