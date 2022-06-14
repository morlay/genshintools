import 'package:dio/dio.dart';
import 'package:genshingameinfo/types.dart';

import 'common_client.dart';

class EnkaClient extends CommonClient {
  final Dio dio;

  EnkaClient({
    required this.dio,
    bool useProxy = true,
  }) : super(useProxy: useProxy) {}

  Future<EnkaGameData> getGameData({
    required int uid,
  }) {
    return dio
        .get(super.mayWithProxy(
          'https://enka.shinshin.moe/u/${uid}/__data.json',
        ))
        .then((value) => EnkaGameData.fromJson(value.data as Map<String, dynamic>));
  }
}
