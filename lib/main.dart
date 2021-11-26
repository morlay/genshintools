import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:genshintools/auth/auth.dart';
import 'package:flutter_services_binding/flutter_services_binding.dart';
import 'package:genshintools/components/characters.dart' as characters;

void main() async {
  FlutterServicesBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const GenshinTools()),
    storage: storage,
  );
}

class GenshinTools extends StatelessWidget {
  const GenshinTools({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: const MaterialApp(
        title: '原神工具箱',
        home: characters.CharactersContainer(),
      ),
    );
  }
}
