import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
import 'firebase_options.dart';
import 'genshindb/genshindb.dart';
import 'theme.dart';

// https://firebase.flutter.dev/docs/overview/#initialization
void main() async {
  FlutterServicesBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    var d = kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory();

    var s = await HydratedStorage.build(
      storageDirectory: d,
    );

    HydratedBlocOverrides.runZoned(
      () => runApp(const AppRoot()),
      storage: s,
      blocObserver: WebDAVSyncer(),
    );
  } catch (e) {
    log("$e");
  }
}

class AppRoot extends HookWidget {
  const AppRoot({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

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
          child: MaterialApp(
            title: '原神工具箱',
            theme: theme,
            navigatorObservers: <NavigatorObserver>[observer],
            home: AppMain(),
          ),
        );
      },
    );
  }
}
