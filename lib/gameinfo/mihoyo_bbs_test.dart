import 'dart:io';
import 'package:dio/dio.dart';
import 'package:test/test.dart';
import 'mihoyo_bbs.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  var cookie = new File('assets/cookie.txt').readAsStringSync();
  var dio = Dio();

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    responseBody: true,
    responseHeader: false,
  ));

  var c = MiHoYoBBSClient(dio, cookie, true);

  test('debug', () async {
    var value = await c.getUserInfo(194435467);

    print(value.toJson());

    var ids = value.avatars?.map<int>((e) => e.id!).toList();

    if (ids != null) {
      var ret = await c.getAllCharacters(194435467, ids);
      print(ret.toJson());
    }
  });
}
