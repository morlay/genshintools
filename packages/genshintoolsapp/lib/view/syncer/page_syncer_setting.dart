import 'dart:io';

import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/syncer.dart';
import 'package:webdav/webdav.dart';

class PageSyncSetting extends HookWidget {
  static String routeName = '/sync/settings';

  const PageSyncSetting({Key? key}) : super(key: key);

  static show(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageSyncSetting.routeName),
        builder: (context) => const PageSyncSetting(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('配置 WebDAV 数据同步'),
      ),
      body: FormSyncSetting(),
    );
  }
}

class FormSyncSetting extends HookWidget {
  final _form = GlobalKey<FormState>();

  FormSyncSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocSyncer = BlocSyncer.watch(context);

    final address = useTextEditingController(
      text: blocSyncer.state.address,
    );
    final username = useTextEditingController(
      text: blocSyncer.state.username,
    );
    final password = useTextEditingController(
      text: blocSyncer.state.password,
    );

    final showPassword = useState(false);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: address,
              decoration: const InputDecoration(
                labelText: 'WebDAV 地址 (确保创建好 /genshintools/ 目录)',
              ),
            ),
            TextFormField(
              controller: username,
              decoration: const InputDecoration(
                labelText: 'WebDAV 用户名',
              ),
            ),
            TextFormField(
              controller: password,
              obscureText: !showPassword.value,
              decoration: InputDecoration(
                labelText: 'WebDAV 密码',
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    showPassword.value = !showPassword.value;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: () {
                  _form.currentState?.validate().ifTrueOrNull(() async {
                    var wd = WebDAV.fromJson({
                      'address': address.value.text,
                      'username': username.value.text,
                      'password': password.value.text,
                    });
                    try {
                      await wd.ping();
                      blocSyncer.bind(wd.copyWith(valid: true));
                      showSnackBar(
                        context,
                        content: const Text('连接成功'),
                      );
                    } on ResponseException catch (err) {
                      blocSyncer.bind(wd.copyWith(
                        valid:
                            err.response?.statusCode != HttpStatus.unauthorized,
                      ),);
                      showSnackBar(
                        context,
                        content: Text('连接错误 ${err.statusCode} ${err.response}'),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('连接测试'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('配置成功后 5 分钟尝试同步一次（有更新才消耗同步流量）'),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: blocSyncer.state.let((it) {
                  if (it.valid == true) {
                    return () => showAlert(
                          context,
                          content: const Text('本次操作将覆盖本地数据，是否确认？'),
                          onConfirm: () async {
                            try {
                              await WebDAVSyncer.read(context)
                                  .sync(fromServer: true);
                              showSnackBar(
                                context,
                                content: const Text('同步成功'),
                              );
                            } catch (e) {
                              showSnackBar(
                                context,
                                content: Text('同步失败: $e'),
                              );
                            }
                          },
                        );
                  }
                  return null;
                }),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('从 WebDAV 同步到本地'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: blocSyncer.state.let((it) {
                  if (it.valid == true) {
                    return () => showAlert(
                          context,
                          content: const Text('本次操作将覆盖 WebDAV 数据，是否确认？'),
                          onConfirm: () async {
                            try {
                              await WebDAVSyncer.read(context).sync();
                              showSnackBar(
                                context,
                                content: const Text('同步成功'),
                              );
                            } catch (e) {
                              showSnackBar(
                                context,
                                content: Text('同步失败: $e'),
                              );
                            }
                          },
                        );
                  }
                  return null;
                }),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('从本地同步到 WebDAV'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
