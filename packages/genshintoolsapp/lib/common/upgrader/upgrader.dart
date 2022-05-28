import 'dart:core';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:freearch/freearch.dart';
import 'package:freearch/upgrader.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

void useUpgrader(BuildContext context, String channel) {
  useObservableEffect(() {
    return Stream.fromFuture(PackageInfo.fromPlatform()).doOnData((info) {
      Upgrader(Github('morlay/genshintools', 'release-$channel')).checkVersion(
          currentVersion: info.version,
          currentBuildNumber: info.buildNumber,
          onUpdate: (lr) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16,),
                        child: DefaultTextStyle.merge(
                          style: Theme.of(context).textTheme.headline6,
                          child: const Text('是否更新应用？'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8,),
                        child: MarkdownBody(
                          data: """
新版本 ${lr.version}(build ${lr.buildNumber}) 已发布

**更新日志**

${lr.description?.let((description) => description) ?? "无"}
""",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('取消'),
                            ),
                            TextButton(
                              onPressed: () {
                                launchUrl(Uri.parse(lr.downloadURL), mode: LaunchMode.externalApplication);
                              },
                              child: const Text('确认'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          },);
    });
  }, [],);
}
