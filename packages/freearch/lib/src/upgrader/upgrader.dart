import 'dart:core';

import 'package:freearch/freearch.dart';
import 'package:logr/logr.dart';
import 'package:roundtripper/roundtripbuilders.dart';
import 'package:roundtripper/roundtripper.dart';

import 'release.dart';

class Upgrader {
  checkVersion({
    required String currentVersion,
    required String currentBuildNumber,
    required Function(Release r) onUpdate,
  }) async {
    try {
      var lr = await latestRelease();

      if (currentBuildNumber == currentVersion) {
        currentBuildNumber = "0";
      }

      if (lr.shouldUpgrade(currentVersion, currentBuildNumber)) {
        onUpdate(lr);
      }
    } catch (e, st) {
      Logger.current?.error(
        e,
        "check version failed",
        stackTrace: st,
      );
    }
  }

  final Github github;

  Upgrader(this.github);

  Client get _client => Client(roundTripBuilders: [
        ThrowsNot2xxError(),
      ]);

  Future<Release> latestRelease() async {
    var req = Request(
      method: "GET",
      uri: Uri.parse(github.rawURL("android/latest.json", nocache: true)),
    );

    var resp = await _client.fetch(req);

    var json = await resp.json();

    var release = Release.fromJson(json);

    return release.downloadURL.startsWith('/')
        ? release.copyWith(
            downloadURL: github.rawURL(release.downloadURL),
          )
        : release;
  }
}
