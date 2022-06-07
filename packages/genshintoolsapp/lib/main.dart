import 'dart:developer';

import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gacha.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/domain/syncer.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'app_main.dart';
import 'theme.dart';

void main() async {
  try {
    var syncer = DataSyncer();

    HydratedBlocOverrides.runZoned(
      () => runApp(
        AppRoot(
          syncer: syncer,
        ),
      ),
      blocObserver: syncer,
      createStorage: () async {
        WidgetsFlutterBinding.ensureInitialized();

        var d = kIsWeb
            ? HydratedStorage.webStorageDirectory
            : await getTemporaryDirectory();

        return HydratedStorage.build(
          storageDirectory: d,
        );
      },
    );
  } catch (e) {
    log('$e');
  }
}

class AppRoot extends HookWidget {
  final DataSyncer syncer;

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
            BlocProvider<BlocGameData>(
              lazy: false,
              create: (_) => BlocGameData(blocGameData.requireData),
            ),
          ],
          child: syncer.provide(
            MaterialApp(
              title: '原神工具箱',
              theme: theme,
              home: AppMain(),
            ),
          ),
        );
      },
    );
  }
}
