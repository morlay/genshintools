import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshintools/app/auth/auth.dart';

class PageAddAccount extends HookWidget {
  const PageAddAccount({Key? key}) : super(key: key);

  static String routeName = "/accounts/add";

  static show(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageAddAccount.routeName),
        fullscreenDialog: false,
        builder: (context) => const PageAddAccount(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加游戏账号"),
      ),
      body: FormAddAccounts(),
    );
  }
}

class FormAddAccounts extends HookWidget {
  FormAddAccounts({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _encodedCookie = useTextEditingController();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _encodedCookie,
              minLines: 5,
              maxLines: 5,
              decoration:
                  const InputDecoration(hintText: 'Base64 Encoded Cookie *'),
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return '请输入 Cookie';
                }
                return null;
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: const Text('登录并添加游戏账号'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _addAccount(context, _encodedCookie);
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: MarkdownBody(
                selectable: true,
                data: """
**Base64 Encoded Cookie**

需要访问 https://bbs.mihoyo.com/ys 并登录

在控制台通过运行 `btoa(document.cookie)` 获得 (不带引号的字符串),

或者在浏览器地址栏输入 `javascript:document.write(btoa(document.cookie))`           
""",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _addAccount(
      BuildContext context, TextEditingController _encodedCookie) async {
    var blocAuth = BlocAuth.read(context);

    try {
      var encodedCookie = _encodedCookie.text.trim();
      var gameRoles =
          await blocAuth.state.client(encodedCookie).listMyGameRole();

      blocAuth.addAccounts(
        gameRoles: gameRoles,
        encodedCookie: encodedCookie,
      );

      Navigator.of(context).pop();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$err")),
      );
    }

    return;
  }
}
