import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/syncer/syncer.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_main.dart';
import 'app/auth/auth.dart';
import 'app/gacha/gacha.dart';
import 'genshindb/genshindb.dart';
import 'theme.dart';

// https://firebase.flutter.dev/docs/overview/#initialization
void main() async {
  FlutterServicesBinding.ensureInitialized();

  try {
    var d = kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory();

    var s = await HydratedStorage.build(
      storageDirectory: d,
    );

    var syncer = WebDAVSyncer();

    HydratedBlocOverrides.runZoned(
      () => runApp(
        AppRoot(
          syncer: syncer,
        ),
      ),
      storage: s,
      blocObserver: syncer,
    );
  } catch (e) {
    log("$e");
  }
}

class AppRoot extends HookWidget {
  final WebDAVSyncer syncer;

  const AppRoot({
    required this.syncer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GSDB>(
      future: BlocGameData.dbFromAssetBundle(DefaultAssetBundle.of(context)),
      builder: (context, blocGameData) {
        if (!blocGameData.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider<BlocSyncer>(
              lazy: false,
              create: (_) => BlocSyncer(),
            ),
            BlocProvider<BlocAuth>(
              lazy: false,
              create: (_) => BlocAuth(),
            ),
            BlocProvider<BlocGacha>(
              lazy: false,
              create: (_) => BlocGacha(),
            ),
            BlocProvider<BlocDailyNote>(
              lazy: false,
              create: (_) => BlocDailyNote(),
            ),
            BlocProvider<BlocArtifact>(
              lazy: false,
              create: (_) => BlocArtifact(),
            ),
            BlocProvider<BlocGameData>(
                lazy: false,
                create: (_) => BlocGameData(blocGameData.requireData)),
          ],
          child: syncer.provide(MaterialApp(
            title: '原神工具箱',
            theme: theme,
            home: AppMain(),
          )),
        );
      },
    );
  }
}
