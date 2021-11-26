import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import "package:webdav_client/webdav_client.dart";

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

  Client client() {
    final c = newClient(
      "$address${address.endsWith("/") ? "" : "/"}genshintools",
      user: username,
      password: password,
      debug: false,
    );

    c.setHeaders({'accept-charset': 'utf-8'});

    return c;
  }

  writeJson(String file, dynamic json) async {
    final c = client();
    final data = jsonEncode(json ?? {});
    final encodedJSON = utf8.encode(data);
    final sum = md5.convert(encodedJSON).toString();
    final sumFile = "$file.sum";

    var preSum = "";
    try {
      preSum = utf8.decode(await c.read(sumFile));
    } catch (e) {
      log("W $file $e");
    }

    if (sum != preSum) {
      await c.write(
        file,
        Uint8List.fromList(encodedJSON),
      );
      await c.write(
        sumFile,
        Uint8List.fromList(utf8.encode(sum)),
      );
    }
  }

  dynamic readJson(String file) async {
    final c = client();
    try {
      var data = utf8.decode(await c.read(file));
      return jsonDecode(data);
    } catch (e) {
      log("R $file $e");
    }
    return null;
  }
}
