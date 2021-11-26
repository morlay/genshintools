import 'dart:io';

import 'package:dio/dio.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';
import 'package:test/test.dart';

void main() {
  group("GachaClient", () {
    var gachalogurl = File('./assets/gachalogurl.txt').readAsStringSync();
    var dio = Dio();
    var c = GachaClient(dio: dio, gachaLogURL: gachalogurl);

    test('listGachaType', () async {
      var value = await c.listGachaType();
      print(value);
    });

    test('listAllGachaLog', () async {
      var value = await c.listAllGachaLog(
        gachaType: GachaType(key: "100", name: ""),
        size: 10,
        untilId: "1628316360000125362",
      );
      print(value.last);
      print(value.map((e) => e.id));
    });
  });
}
