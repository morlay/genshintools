import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "generated/webdav.freezed.dart";
part "generated/webdav.g.dart";

@freezed
class WebDAV with _$WebDAV {
  WebDAV._();

  @JsonSerializable()
  factory WebDAV({
    required String address,
    required String username,
    required String password,
    DateTime? syncAt,
    bool? fromServer,
    bool? valid,
  }) = _WebDAV;

  factory WebDAV.fromJson(Map<String, dynamic> json) => _WebDAV.fromJson(json);

  bool shouldSync() {
    return (valid ?? false) && syncAt != null;
  }

  Dio client() {
    return Dio(BaseOptions(
      baseUrl: "$address${address.endsWith("/") ? "" : "/"}genshintools",
      headers: {
        "accept-charset": "utf-8",
        "Authorization":
            "Basic ${base64Encode(utf8.encode("$username:$password"))}"
      },
    ));
  }

  _dioError(Response resp) {
    return DioError(
        response: resp,
        requestOptions: resp.requestOptions,
        type: DioErrorType.response,
        error: resp.statusMessage);
  }

  String _fixPath(String path) {
    if (path.startsWith("/")) {
      return path;
    }
    return "/" + path;
  }

  Future<void> ping() async {
    var resp = await client().request('/',
        options: Options(
          method: "OPTIONS",
        ));

    if (resp.statusCode != 200) {
      throw _dioError(resp);
    }
  }

  Future<Uint8List> read(String path) async {
    var resp = await client().get(
      _fixPath(path),
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    if (resp.statusCode! >= HttpStatus.badRequest) {
      throw _dioError(resp);
    }

    return resp.data;
  }

  Future<Response<void>> write(String path, Uint8List data) async {
    var resp = await client().put(
      _fixPath(path),
      data: Stream.fromIterable([data]),
      options: Options(headers: {
        "content-length": data.length,
      }),
    );
    if (resp.statusCode! >= HttpStatus.badRequest) {
      throw _dioError(resp);
    }
    return resp;
  }

  writeJsonIfChanged(String file, dynamic json) async {
    final data = getPrettyJSONString(json ?? {});
    final encodedJSON = utf8.encode(data);
    final sum = md5.convert(encodedJSON).toString();
    final sumFile = "$file.sum";

    var preSum = "";
    try {
      preSum = utf8.decode(await read(sumFile));
    } catch (e) {
      log("$file not found.");
    }

    if (sum != preSum) {
      await write(
        file,
        Uint8List.fromList(encodedJSON),
      );
      await write(
        sumFile,
        Uint8List.fromList(utf8.encode(sum)),
      );
      log("$file synced to WebDAV.");
      return;
    }
    log("$file not changed.");
  }

  dynamic readJson(String file) async {
    try {
      var data = utf8.decode(await read(file));
      log("$file found.");
      return jsonDecode(data);
    } catch (e) {
      log("$file read failed: $e");
    }
    return null;
  }
}

String getPrettyJSONString(jsonObject) {
  const encoder = JsonEncoder.withIndent("  ");
  return encoder.convert(jsonObject);
}
