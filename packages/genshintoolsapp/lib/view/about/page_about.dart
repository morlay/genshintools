import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/flutter/flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PageAbout extends HookWidget {
  final PackageInfo packageInfo;

  static String routeName = "/about";

  const PageAbout({required this.packageInfo, Key? key}) : super(key: key);

  static void show(BuildContext context) async {
    var pi = await PackageInfo.fromPlatform();

    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageAbout.routeName),
        fullscreenDialog: false,
        builder: (context) => PageAbout(
          packageInfo: pi,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Wrap(
          runSpacing: 8,
          children: [
            ...[
              Text(
                packageInfo.appName,
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              Text(
                "版本: ${packageInfo.version}(build ${packageInfo.buildNumber})",
              ),
              BlocBuilder<BlocAuth, AuthState>(builder: (context, state) {
                var blocAuth = BlocAuth.watch(context);

                return GestureDetector(
                  onTap: () {
                    blocAuth.switchChannel(
                      blocAuth.state.currentChannel == "stable"
                          ? "beta"
                          : "stable",
                    );
                  },
                  child: Text("更新通道: ${blocAuth.state.currentChannel}"),
                );
              }),
              const Text(""),
              const Text(""),
              Text("${packageInfo.appName} 与米哈游无关。"),
              const Text("原神的游戏内容和各种素材与商标的版权都属于米哈游。"),
            ].map(
              (e) => Row(
                children: [
                  Expanded(child: e),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
