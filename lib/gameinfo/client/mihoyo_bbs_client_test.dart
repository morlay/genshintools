import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:test/test.dart';

void main() {
  var cookie = File('./assets/cookie.txt').readAsStringSync();
  var dio = Dio();

  dio.interceptors
      .add(PrettyDioLogger(requestHeader: true, responseHeader: true));

  var c = MiHoYoBBSClient(dio: dio, encodedCookie: cookie, useProxy: false);

  test('listMyGameRole', () async {
    var value = await c.listMyGameRole();
    expect(value.length, equals(1));
  });

  test('dailyNote', () async {
    var value = await c.dailyNote(194435467);
    print(jsonEncode(value));
  });

  test('getAvatarDetail', () async {
    var value = await c.getAvatarDetail(194435467, 10000049);
    print(jsonEncode(value));
  });

  test('getUserInfo', () async {
    var value = await c.getUserInfo(194435467);

    var ids = value.avatars?.map<int>((e) => e.id).toList() ?? [];

    if (ids.isNotEmpty) {
      var ret = await c.getAllCharacters(194435467, ids);
      print(ret.toJson());
    }
  });
}
