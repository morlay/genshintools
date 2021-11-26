import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'bloc_syncer.dart';
import 'webdav.dart';

mixin WebDAVSyncMixin {
  bool webDAVSyncEnabled() {
    return true;
  }
}

class WebDAVSyncer implements BlocObserver {
  BlocSyncer? blocSyncer;
  List<HydratedMixin> blocs = [];

  @override
  void onCreate(BlocBase bloc) {
    if (bloc is BlocSyncer && bloc.state != null) {
      blocSyncer = bloc;
    }

    if (bloc is HydratedMixin && bloc is WebDAVSyncMixin) {
      blocs.add(bloc);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    if (bloc is BlocSyncer &&
        change.nextState != null &&
        change.nextState is WebDAV) {
      _sync(change.nextState);
    }
  }

  _sync(WebDAV c) async {
    if (c.shouldSync()) {
      if (c.fromServer == true) {
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
        await c.writeJson(
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
