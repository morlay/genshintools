import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:contextdart/contextdart.dart';
import 'package:logr/logr.dart';
import 'package:logr/stdlogr.dart';
import 'package:test/test.dart';
import 'package:webdav/webdav.dart';

void main() {
  var ctx = Logger.withLogger(Logger(StdLogSink("webdav")));

  var wd = WebDAV(
    address: Platform.environment["WEBDAV_ADDRESS"]!,
    username: Platform.environment["WEBDAV_USERNAME"]!,
    password: Platform.environment["WEBDAV_PASSWORD"]!,
    root: "genshintools",
  );

  test(
    "client",
    runWith(ctx, () async {
      var now = DateTime.now().toString();

      await wd.write(
        "/tmp.txt",
        Uint8List.fromList(utf8.encode(now)),
      );

      var data = utf8.decode(await wd.read("/tmp.txt"));

      expect(data, now);
    }),
  );
}

R Function() runWith<R>(Context ctx, R Function() action) {
  return () {
    return ctx.run(action);
  };
}
