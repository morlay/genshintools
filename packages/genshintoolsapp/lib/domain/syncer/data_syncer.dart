import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'bloc_syncer.dart';

mixin DataSyncMixin {
  bool dataSyncEnabled() {
    return true;
  }
}

class DataSyncer implements BlocObserver {
  static DataSyncer read(BuildContext context) {
    return context.read<DataSyncer>();
  }

  BlocSyncer? blocSyncer;
  List<HydratedMixin> blocs = [];

  Provider provide(Widget child) {
    return Provider<DataSyncer>.value(value: this, child: child);
  }

  @override
  void onCreate(BlocBase bloc) {
    if (bloc is BlocSyncer) {
      blocSyncer = bloc;
    }

    if (bloc is HydratedMixin && bloc is DataSyncMixin) {
      blocs.add(bloc);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {}

  Future<void> sync({bool? fromServer, String? fromJson, bool? toJson}) async {
    if (fromJson != null) {
      final uid = blocs[0].state.chosenUid();
      final blocGameData = blocs[2];
      var old = jsonDecode(jsonEncode(blocGameData.toJson(blocGameData.state)));
      var json = jsonDecode(fromJson);

      if (json.containsKey('format') && json['format'] == 'GOOD') {
        json['source'] = 'dev.morlay.genshintools';
        old![uid.toString()]['artifacts'] = json['artifacts'];
        // need to this for loaded json from webadv
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        blocGameData.emit(blocGameData.fromJson(old));
      }
      return;
    }

    if (toJson == true) {
      final uid = blocs[0].state.chosenUid();
      final blocGameData = blocs[2];
      var old = jsonDecode(jsonEncode(blocGameData.toJson(blocGameData.state)));
      var json = old[uid.toString()].toString();
      Clipboard.setData(ClipboardData(text: json));
      return;
    }

    var c = blocSyncer!.state;
    if (c.shouldSync()) {
      if (fromServer == true) {
        for (final b in blocs) {
          var json = await c.readJson(
            '${b.runtimeType}.json',
          );
          if (json != null) {
            // need to this for loaded json from webadv
            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
            b.emit(b.fromJson(json));
          }
        }
        return;
      } else {
        for (final b in blocs) {
          await c.writeJsonIfChanged(
            '${b.runtimeType}.json',
            b.toJson(b.state),
          );
        }
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
