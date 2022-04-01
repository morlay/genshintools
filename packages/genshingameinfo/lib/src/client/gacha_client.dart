import 'package:dio/dio.dart';
import 'package:genshingameinfo/types.dart';

import 'common_client.dart';

class GachaClient extends CommonClient {
  final Dio dio;
  late Uri parsedGachaLogURL;

  GachaClient({
    required this.dio,
    required String gachaLogURL,
    bool useProxy = false,
  }) : super(useProxy: useProxy) {
    parsedGachaLogURL = Uri.parse(gachaLogURL);
  }

  Future<List<GachaType>> listGachaType() {
    return dio
        .get(
          super.mayWithProxy(
            'https://hk4e-api.mihoyo.com/event/gacha_info/api/getConfigList',
          ),
          queryParameters: {
            ...parsedGachaLogURL.queryParameters,
            "lang": "zh-cn",
          },
        )
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((value) => (value["gacha_type_list"] as List<dynamic>))
        .then((list) => list
            .map((item) => GachaType.fromJson(item as Map<String, dynamic>))
            .toList());
  }

  Future<List<GachaLog>> listAllGachaLog({
    required GachaType gachaType,
    int size = 20,
    String untilId = "0",
  }) async {
    List<GachaLog> data = [];

    var endId = "0";
    var forceDone = false;
    Iterable<GachaLog> list = [];

    while (true) {
      list = await listGachaLog(gachaType: gachaType, endId: endId, size: size);
      endId = list.isNotEmpty ? list.last.id : "0";

      for (var item in list) {
        if (untilId != "0" && untilId == item.id) {
          forceDone = true;
          break;
        }
        data.add(item);
      }

      if (forceDone) {
        break;
      }

      if (list.isEmpty) {
        break;
      }

      await Future.delayed(const Duration(milliseconds: 300));
    }

    return data;
  }

  Future<List<GachaLog>> listGachaLog({
    required GachaType gachaType,
    required String endId,
    int size = 20,
  }) {
    return dio
        .get(
          super.mayWithProxy(
            'https://hk4e-api.mihoyo.com/event/gacha_info/api/getGachaLog',
          ),
          queryParameters: {
            ...parsedGachaLogURL.queryParameters,
            "lang": "zh-cn",
            "gacha_type": gachaType.key,
            "size": size,
            "end_id": endId,
          },
        )
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((value) => (value["list"] as List<dynamic>))
        .then((list) => list
            .map((item) => GachaLog.fromJson(item as Map<String, dynamic>))
            .toList());
  }
}
