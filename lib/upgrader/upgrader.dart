import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'release.dart';

var gitRawBase = "https://gitee.com/morlay/genshintools-release/raw";

class Upgrader {
  static checkVersion(BuildContext context) async {
    var channel = BlocAuth.read(context).state.currentChannel;

    var pi = await PackageInfo.fromPlatform();

    try {
      var lr = await Upgrader(channel: channel).latestRelease();

      var buildNumber = pi.buildNumber;

      if (buildNumber == pi.version) {
        buildNumber = "0";
      }

      if (lr.shouldUpgrade(pi.version, buildNumber)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("是否更新应用"),
              content: SingleChildScrollView(
                child: MarkdownBody(
                  data: """
新版本 ${lr.version}(build ${lr.buildNumber}) 已发布

**更新日志**：
${lr.description?.let((description) => description) ?? "无"}
""",
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("取消"),
                ),
                TextButton(
                  onPressed: () {
                    launch(lr.downloadURL);
                  },
                  child: const Text("确认"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      log("check version failed", error: e);
    }
  }

  final String channel;
  final dio = Dio();

  Upgrader({
    required this.channel,
  });

  Future<Release> latestRelease() {
    return dio
        .get(
          "$gitRawBase/$channel/android/latest.json",
        )
        .then((value) => jsonDecode(value.data))
        .then((data) => Release.fromJson(data));
  }
}
