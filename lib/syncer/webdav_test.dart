import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:test/test.dart';

import 'webdav.dart';

void main() {
  var wd = WebDAV(
    address: Platform.environment["WEBDAV_ADDRESS"]!,
    username: Platform.environment["WEBDAV_USERNAME"]!,
    password: Platform.environment["WEBDAV_PASSWORD"]!,
  );

  test("client", () async {
    var now = DateTime.now().toString();

    await wd.write(
      "/tmp.txt",
      Uint8List.fromList(utf8.encode(now)),
    );

    var data = utf8.decode(await wd.read("/tmp.txt"));

    print(data);

    expect(data, now);
  });
}
