import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:genshintools/auth/auth.dart';
import 'package:genshintools/auth/page_auth.dart';

@immutable
class AppScaffold extends StatelessWidget {
  Widget? title;
  Widget? child;

  AppScaffold({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hasLogin = context.watch<AuthCubit>().hasLogon();

    return Scaffold(
      appBar: AppBar(title: title, actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.person),
            tooltip: hasLogin ? "我的角色" : '登录',
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute<void>(
                builder: (BuildContext context) {
                  return const PageAuth();
                },
              ));
            })
      ]),
      body: child,
    );
  }
}
