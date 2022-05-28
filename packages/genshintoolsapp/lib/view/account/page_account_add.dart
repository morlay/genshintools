import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageAddAccount extends HookWidget {
  const PageAddAccount({Key? key}) : super(key: key);

  static String routeName = '/accounts/add';

  static show(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageAddAccount.routeName),
        builder: (context) => const PageAddAccount(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var selected = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('添加游戏账号'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cookie),
            label: '通过 Cookie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '通过 米游社 Web',
          ),
        ],
        currentIndex: selected.value,
        onTap: (int index) => selected.value = index,
      ),
      body: [
        FormAddAccounts(),
        const AddAccountFromMiYoBBS(),
      ][selected.value],
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
      padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: const Text('登录并添加游戏账号'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  addAccount(context, _encodedCookie.text.trim());
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: MarkdownBody(
                selectable: true,
                data: '''
**Base64 Encoded Cookie**

需要访问 https://bbs.mihoyo.com/ys 并登录

在控制台通过运行 `btoa(document.cookie)` 获得 (不带引号的字符串),

或者在浏览器创建书签 `javascript:document.write(btoa(document.cookie))`, 登录后运行书签。

**免责声明**

本 Cookie 仅用于 mihoyo bbs 相关 api 的请求，本地存储，也会通过 WebDAV 同步，请妥善保管。
''',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAccountFromMiYoBBS extends HookWidget {
  const AddAccountFromMiYoBBS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var webViewCtrlRef = useRef<WebViewController?>(null);

    return Column(
      children: [
        Expanded(
          child: WebView(
            onWebViewCreated: (ctrl) {
              webViewCtrlRef.value = ctrl;
            },
            initialUrl: 'https://bbs.mihoyo.com/ys/',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
        const Divider(height: 1),
        ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: const Text('登录成功后点击右侧按钮'),
          subtitle: const Text(
            '这个区域只是个 WebView / 浏览器，如果账户密码泄露一定不是本 APP 的问题',
            style: TextStyle(fontSize: 10),
          ),
          trailing: IconButton(
            onPressed: () {
              webViewCtrlRef.value?.let((ctrl) {
                ctrl.runJavascriptReturningResult('btoa(document.cookie)').then(
                  (encodedCookie) {
                    if (encodedCookie.startsWith('"')) {
                      encodedCookie =
                          encodedCookie.substring(1, encodedCookie.length - 1);
                    }
                    addAccount(context, encodedCookie);
                  },
                );
              });
            },
            icon: const Icon(Icons.login),
          ),
        ),
      ],
    );
  }
}

Future<dynamic> addAccount(BuildContext context, String encodedCookie) async {
  var blocAuth = BlocAuth.read(context);

  try {
    var gameRoles = await blocAuth.state.client(encodedCookie).listMyGameRole();

    blocAuth.addAccounts(
      gameRoles: gameRoles,
      encodedCookie: encodedCookie,
    );

    Navigator.of(context).pop();
  } catch (err) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$err')),
    );
  }

  return;
}
