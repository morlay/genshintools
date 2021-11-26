import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:genshintools/gameinfo/types.dart';

class MiHoYoBBSClient {
  Dio dio;
  String encodedCookie;
  bool useProxy;

  String apiEndpoint = "api-takumi.mihoyo.com/game_record/app/genshin/api";
  String hoyolabVersion = "2.17.1";

  MiHoYoBBSClient(this.dio, this.encodedCookie, this.useProxy);

  String path(String p) {
    if (useProxy) {
      return "https://now-proxy-3.vercel.app/https:/$apiEndpoint$p";
    }
    return "https://$apiEndpoint$p";
  }

  Future<UserInfo> getUserInfo(int uid) {
    Map<String, dynamic> params = {
      "role_id": uid,
      "server": serverFromUID(uid)
    };

    return dio
        .get(path('/index'),
            queryParameters: params,
            options: Options(headers: withHeaders(params, {})))
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((data) => UserInfo.fromJson(data));
  }

  Future<UserInfo> getAllCharacters(int uid, List<int> characterIDs) {
    Map<String, dynamic> requestBody = {
      "role_id": uid,
      "server": serverFromUID(uid),
      "character_ids": characterIDs,
    };

    return dio
        .post(path('/character'),
            data: requestBody,
            options: Options(
              headers: withHeaders({}, requestBody),
            ))
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((data) => UserInfo.fromJson(data));
  }

  Map<String, dynamic> pickDataOrError(Map<String, dynamic> data) {
    if (data.containsKey("message") && (data["retcode"] as int) != 0) {
      throw "[${data["retcode"]}] ${data["message"]}";
    }
    return data["data"];
  }

  String getCookie() {
    return utf8.fuse(base64).decode(encodedCookie);
  }

  Map<String, String> withHeaders(
      Map<String, dynamic> query, Map<String, dynamic> body) {
    var headers = {
      "Accept": "application/json, text/plain, */*",
      "Accept-Language": "zh-CN,en-US;q=0.8",
      "x-rpc-app_version": hoyolabVersion,
      "x-rpc-client_type": "5",
      "X-Requested-With": "com.mihoyo.hypexrion",
      "Origin": "https://webstatic.mihoyo.com",
      "Referer":
          "https://webstatic.mihoyo.com/app/community-game-records/index.html?v=6",
      "User-Agent":
          "Mozilla/5.0 (Linux; Android 9; Unspecified Device) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/39.0.0.0 Mobile Safari/537.36 miHoYoBBS/$hoyolabVersion",
      "DS": calcDS(query, body),
      "Cookie": getCookie(),
    };

    if (useProxy) {
      return headers.map((key, value) {
        if (["Origin", "Referer", "User-Agent"].contains(key)) {
          return MapEntry("X-Proxy-Forward-$key", value);
        }
        return MapEntry(key, value);
      });
    }

    return headers;
  }
}

String serverFromUID(int uid) {
  switch ('$uid'[0]) {
    case '1':
      return 'cn_gf01';
    case '2':
      return 'cn_gf01';
    case '5':
      return 'cn_qd01';
    case '6':
      return 'os_usa';
    case '7':
      return 'os_euro';
    case '8':
      return 'os_asia';
    case '9':
      return 'os_cht';
    default:
      return '';
  }
}

String salt = "xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs";

String calcDS(Map<String, dynamic> query, Map<String, dynamic> body) {
  var t = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  // Integer between 100000 - 200000
  var random = (Random()).nextInt(100000) + 100000;

  var b = '';
  var q = '';

  if (body.isNotEmpty) {
    b = jsonEncode(body);
  }

  if (query.isNotEmpty) {
    var count = 0;

    for (var item in query.entries) {
      q +=
          "${count > 0 ? '&' : ''}${item.key}=${Uri.encodeQueryComponent("${item.value}").toString()}";
      count++;
    }
  }

  var s = generateMd5("salt=$salt&t=$t&r=$random&b=$b&q=$q");

  return '$t,$random,$s';
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
