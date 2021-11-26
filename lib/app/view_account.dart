import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/page_account_add.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';

import 'auth/auth.dart';
import 'page_about.dart';
import 'page_syncer_setting.dart';

class AppBarWithAccount extends AppBar {
  static buildScaffold(
    BuildContext context,
    Widget body, {
    List<Widget>? actions,
  }) {
    return Scaffold(
      drawer: const Drawer(
        child: CommonDrawer(),
      ),
      appBar: AppBarWithAccount(
        actions: actions,
      ),
      body: body,
    );
  }

  AppBarWithAccount({
    Key? key,
    List<Widget>? actions,
  }) : super(
          key: key,
          centerTitle: false,
          actions: actions,
          titleSpacing: 0,
          title: BlocBuilder<BlocAuth, AuthState>(builder: (context, state) {
            return Row(
              children: [
                state.hasLogon()
                    ? ViewGameRole(gameRole: state.currentGameRole)
                    : const Text("请添加游戏账号"),
              ],
            );
          }),
        );
}

class ViewGameRole extends HookWidget {
  final GameRole gameRole;

  const ViewGameRole({
    Key? key,
    required this.gameRole,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              gameRole.nickname,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(text: "${gameRole.regionName} / ${gameRole.gameUid}"),
          ]),
          style: const TextStyle(
            fontSize: 10,
          ),
        )
      ],
    );
  }
}

class CommonDrawer extends HookWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocAuth, AuthState>(builder: (context, state) {
      var blocAuth = BlocAuth.read(context);

      return ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: linearGradientForRarity(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: Text("")),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    "原神工具箱",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                )
              ],
            ),
          ),
          ...state.roles.values.map(
            (role) => ListTile(
              leading: const Icon(Icons.remove),
              title: ViewGameRole(
                gameRole: role,
              ),
              tileColor: (state.currentUID == role.gameUid)
                  .ifTrueOrNull(() => Theme.of(context).focusColor),
              onTap: () => blocAuth.switchAccount(role.gameUid),
              onLongPress: () => _removeAccount(context, role),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('添加游戏账号'),
            onTap: () {
              PageAddAccount.show(context);
            },
          ),
          const Divider(
            height: 0,
          ),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('WebDAV 数据同步'),
            onTap: () {
              PageSyncSetting.show(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('关于'),
            onTap: () {
              PageAbout.show(context);
            },
          ),
        ],
      );
    });
  }

  _removeAccount(BuildContext context, GameRole role) {
    var blocAuth = BlocAuth.read(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("是否解除游戏账户 ${role.nickname}(${role.gameUid}) 的关联?"),
          actions: [
            TextButton(
              child: const Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("确定"),
              onPressed: () {
                blocAuth.removeAccount(role.gameUid);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
