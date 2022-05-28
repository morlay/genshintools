import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logr/logr.dart';
import 'package:roundtripper/roundtripbuilders.dart';
import 'package:roundtripper/roundtripper.dart';

import 'auth.dart';

export 'package:roundtripper/roundtripper.dart' show ResponseException;

part '__generated__/webdav.freezed.dart';

part '__generated__/webdav.g.dart';

@freezed
class WebDAV with _$WebDAV {
  WebDAV._();

  // ignore: invalid_annotation_target
  @JsonSerializable()
  factory WebDAV({
    required String address,
    required String username,
    required String password,
    @Default('/') String root,
    bool? valid,
  }) = _WebDAV;

  factory WebDAV.fromJson(Map<String, dynamic> json) => _WebDAV.fromJson(json);

  bool shouldSync() {
    return valid ?? false;
  }

  Client get _client {
    return Client(
      roundTripBuilders: [
        HttpBaseAuth(
          username: username,
          password: password,
        ),
        ThrowsNot2xxError(),
        RequestLog(),
      ],
    );
  }

  String _fixPath(String p) {
    if (p.startsWith('/')) {
      return p.substring(1);
    }
    return p;
  }

  String _fullURL(String p) {
    return "$address${address.endsWith("/") ? "" : "/"}${_fixPath(root)}/${_fixPath(p)}";
  }

  Future<void> ping() async {
    await _client.fetch(
      Request(
        method: 'OPTIONS',
        uri: Uri.parse(_fullURL('/')),
      ),
    );
  }

  Future<List<int>> read(String path) async {
    var resp = await _client.fetch(
      Request(
        method: 'GET',
        uri: Uri.parse(_fullURL(path)),
      ),
    );
    return resp.blob();
  }

  Future<void> write(String path, List<int> data) async {
    await _client.fetch(
      Request(
        method: 'PUT',
        uri: Uri.parse(_fullURL(path)),
        requestBody: Stream.fromIterable([data]),
      ),
    );
    return;
  }

  Future<void> writeJsonIfChanged(String file, dynamic json) async {
    final data = getPrettyJSONString(json ?? {});
    final encodedJSON = utf8.encode(data);
    final sum = md5.convert(encodedJSON).toString();
    final sumFile = '$file.sum';

    var preSum = '';
    try {
      preSum = utf8.decode(await read(sumFile));
    } catch (e, st) {
      Logger.current?.error(e, '$file not found.', stackTrace: st);
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
      Logger.current?.info('$file synced to WebDAV.');
      return;
    }
    Logger.current?.info('$file not changed.');
  }

  dynamic readJson(String file) async {
    try {
      var data = utf8.decode(await read(file));
      Logger.current?.info('$file found.');
      return jsonDecode(data);
    } catch (e, st) {
      Logger.current?.error(e, '$file read failed', stackTrace: st);
    }
    return null;
  }
}

String getPrettyJSONString(dynamic jsonObject) {
  const encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(jsonObject);
}

class ThrowsNot2xxError implements RoundTripBuilder {
  ThrowsNot2xxError();

  @override
  RoundTrip build(RoundTrip next) {
    return (request) async {
      var resp = await next(request);
      if (resp.statusCode >= HttpStatus.badRequest) {
        var bytes = await resp.blob();
        if (bytes.isNotEmpty &&
            (resp.headers['content-type']?.contains('json') ?? false)) {
          resp.body = await resp.json();
          throw ResponseException(
            resp.statusCode,
            response: resp,
          );
        } else {
          resp.body = await resp.text();
          throw ResponseException(resp.statusCode, response: resp);
        }
      }
      return resp;
    };
  }
}
