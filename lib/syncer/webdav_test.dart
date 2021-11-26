import 'dart:io';

import 'package:test/test.dart';

import 'webdav.dart';

void main() {
  var wd = WebDAV(
    address: Platform.environment["WEBDAV_ADDRESS"]!,
    username: Platform.environment["WEBDAV_USERNAME"]!,
    password: Platform.environment["WEBDAV_PASSWORD"]!,
  );

  var c = wd.client();

  test("client", () async {
    await c.writeFromFile("/tmp/123", "webdav.dart");
  });
}
