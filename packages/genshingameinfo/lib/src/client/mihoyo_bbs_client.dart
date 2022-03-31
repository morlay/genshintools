import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:genshingameinfo/types.dart';

import 'common_client.dart';

typedef GetMiHoYoBBSClient = MiHoYoBBSClient Function();

class MiHoYoBBSClient extends CommonClient {
  final Dio dio;

  String encodedCookie;
  late String _cookie;

  MiHoYoBBSClient({
    required this.encodedCookie,
    required this.dio,
    bool useProxy = false,
  }) : super(useProxy: useProxy) {
    _cookie = utf8.fuse(base64).decode(encodedCookie);
  }

  Future<List<GameRole>> listMyGameRole() {
    Map<String, dynamic> params = {
      "game_biz": "hk4e_cn",
    };

    return dio
        .get(
            mayWithProxy(
                'https://api-takumi.mihoyo.com/binding/api/getUserGameRolesByCookie'),
            queryParameters: params,
            options: Options(headers: withHeaders(ds: calcDS(params, {}))))
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((value) => (value["list"] as List<dynamic>))
        .then((list) => list
            .map((item) => GameRole.fromJson(item as Map<String, dynamic>))
            .toList());
  }

  FutureOr<DailyNote> dailyNote(int uid) async {
    Map<String, dynamic> params = {
      "role_id": uid,
      "server": serverFromUID(uid)
    };

    return dio
        .get(
            mayWithProxy(
              'https://api-takumi-record.mihoyo.com/game_record/app/genshin/api/dailyNote',
            ),
            queryParameters: params,
            options: Options(headers: withHeaders(ds: calcDS(params, {}))))
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((value) => DailyNote.fromJson(value));
  }

  Future<AvatarDetail> getAvatarDetail(int uid, int avatarId) {
    Map<String, dynamic> params = {
      "avatar_id": avatarId,
      "uid": uid,
      "region": serverFromUID(uid),
    };

    return dio
        .get(
            mayWithProxy(
                'https://api-takumi.mihoyo.com/event/e20200928calculate/v1/sync/avatar/detail'),
            queryParameters: params,
            options: Options(
              headers: withHeaders(
                referer:
                    "https://webstatic.mihoyo.com/ys/event/e20200923adopt_calculator/index.html?bbs_presentation_style=fullscreen&bbs_auth_required=true&mys_source=GameRecord",
              ),
            ))
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((value) => AvatarDetail.fromJson(value));
  }

  Future<UserInfo> getUserInfo(int uid) {
    Map<String, dynamic> params = {
      "role_id": uid,
      "server": serverFromUID(uid)
    };

    return dio
        .get(
            mayWithProxy(
                'https://api-takumi-record.mihoyo.com/game_record/app/genshin/api/index'),
            queryParameters: params,
            options: Options(headers: withHeaders(ds: calcDS(params, {}))))
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
        .post(
            mayWithProxy(
                'https://api-takumi-record.mihoyo.com/game_record/app/genshin/api/character'),
            data: requestBody,
            options: Options(
              headers: withHeaders(ds: calcDS({}, requestBody)),
            ))
        .then((value) => pickDataOrError(value.data as Map<String, dynamic>))
        .then((data) => UserInfo.fromJson(data));
  }

  String getCookie() {
    return _cookie;
  }

  Map<String, String> withHeaders({
    String ds = "",
    String referer =
        "https://webstatic.mihoyo.com/app/community-game-records/index.html?v=6",
  }) {
    String version = "2.19.1";
    String hyperion = "com.mihoyo.hyperion";
    String ua =
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.55 Safari/537.36 miHoYoBBS/$version";

    var headers = {
      "Accept": "application/json, text/plain, */*",
      "Accept-Language": "zh-CN,en-US;q=0.8",
      "X-Requested-With": hyperion,
      "User-Agent": ua,
      "Cookie": getCookie(),
    };

    if (ds != "") {
      headers["DS"] = ds;
      headers["x-rpc-app_version"] = "2.19.1";
      headers["x-rpc-client_type"] = "5";
    }

    if (referer != "") {
      headers["Referer"] = referer;
      headers["Origin"] = Uri.parse(referer).origin;
    }

    if (useProxy) {
      return headers.map((key, value) {
        if ([
          "X-Requested-With", // avoid android failed
          "Origin", "Referer", "User-Agent", "Cookie",
        ].contains(key)) {
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
  var t = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
  // Integer between 100000 - 200000
  var random = (Random()).nextInt(100000) + 100000;

  var b = '';
  var q = '';

  if (body.isNotEmpty) {
    b = jsonEncode(body);
  }

  if (query.isNotEmpty) {
    var count = 0;
    var keys = query.keys.toList();
    keys.sort();

    for (var key in keys) {
      q +=
          "${count > 0 ? '&' : ''}$key=${Uri.encodeQueryComponent("${query[key]}").toString()}";
      count++;
    }
  }

  var s = generateMd5("salt=$salt&t=$t&r=$random&b=$b&q=$q");

  return '$t,$random,$s';
}

String generateMd5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}
