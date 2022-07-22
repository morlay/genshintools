import 'dart:convert';
import 'dart:io';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/domain/syncer.dart';
import 'package:url_launcher/url_launcher.dart';
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
    var selected = useState(0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('配置数据同步'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: '通过 JSON',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: '通过 WebDAV',
          ),
        ],
        currentIndex: selected.value,
        onTap: (int index) => selected.value = index,
      ),
      body: [
        FormJsonSetting(),
        FormSyncSetting(),
      ][selected.value],
    );
  }
}

class FormJsonSetting extends HookWidget {
  final _form = GlobalKey<FormState>();

  FormJsonSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _decodeJson = useTextEditingController();
    final _visible = useState(false);
    final _addCharacters = useState(0);
    final _addArtifacts = useState(0);
    final _addWeapons = useState(0);

    useEffect(() {
      _decodeJson.addListener(() {
        try {
          var json = jsonDecode(_decodeJson.text);
          if (json != null) {
            if (json.containsKey('characters'))
              _addCharacters.value = json['characters']!.length ?? 0;
            if (json.containsKey('artifacts'))
              _addArtifacts.value = json['artifacts']!.length ?? 0;
            if (json.containsKey('weapons'))
              _addWeapons.value = json['weapons']!.length ?? 0;
            _visible.value = true;
          }
        } catch (e) {
          _visible.value = false;
        }
      });
      return null;
    }, [_decodeJson]);

    final blocSyncer = BlocSyncer.watch(context);

    final uid = BlocAuth.watch(context).state.chosenUid();
    final blocGameData = BlocGameData.watch(context).playerState(uid);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _form,
        child: Column(
          children: <Widget>[
            Text(
              '数据导出',
              style: const TextStyle(fontSize: 15),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runSpacing: 8,
                children: [
                  CurrentNumber(
                    label: const Text('当前角色数'),
                    current: Text('${blocGameData.characters.length}'),
                  ),
                  CurrentNumber(
                    label: const Text('当前圣遗物数'),
                    current: Text('${blocGameData.artifacts.length}'),
                  ),
                  CurrentNumber(
                    label: const Text('当前武器数'),
                    current: Text('${blocGameData.weapons.length}'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: blocSyncer.state.let((it) {
                  if (it.valid == true) {
                    return () => showAlert(
                          context,
                          content: const Text('本次操作将导出当前用户数据，是否确认？'),
                          onConfirm: () async {
                            try {
                              await DataSyncer.read(context).sync(toJson: true);
                              showSnackBar(
                                context,
                                content: const Text('当前用户数据已复制到剪贴板'),
                              );
                            } catch (e) {
                              showSnackBar(
                                context,
                                content: Text('导出失败: $e'),
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
                child: const Text('从本地数据导出到 JSON '),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: MarkdownBody(
                onTapLink: (name, href, title) {
                  href?.let((h) => launchUrl(Uri.parse(h)));
                },
                selectable: true,
                data: '''
**导出的JSON数据为GOOD格式**

`GOOD`具体格式详见[文档](https://frzyc.github.io/genshin-optimizer/#/doc)

- 支持导入[genshin-optimizer](https://frzyc.github.io/genshin-optimizer/#/)(圣遗物配装及角色面板计算)

- 支持导入[artifact](https://ideless.github.io/artifact/)(圣遗物词条计算评分)

- 支持导入[gcsim](https://gcsim.app)(队伍DPS模拟计算)

''',
              ),
            ),
            Divider(),
            Text(
              '数据导入',
              style: const TextStyle(fontSize: 15),
            ),
            TextFormField(
              controller: _decodeJson,
              minLines: 5,
              maxLines: 5,
              decoration: const InputDecoration(hintText: '粘贴JSON内容到这里'),
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return '请先粘贴JSON内容';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Visibility(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 8,
                  children: [
                    CurrentNumber(
                      label: const Text('导入角色数'),
                      current: Text('${_addCharacters.value}'),
                    ),
                    CurrentNumber(
                      label: const Text('导入圣遗物数'),
                      current: Text('${_addArtifacts.value}'),
                    ),
                    CurrentNumber(
                      label: const Text('导入武器数'),
                      current: Text('${_addWeapons.value}'),
                    ),
                  ],
                ),
                visible: _visible.value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: _visible.value
                    ? () {
                        showAlert(
                          context,
                          content: const Text('本次操作将覆盖本地数据，是否确认？'),
                          onConfirm: () async {
                            if (_form.currentState!.validate()) {
                              try {
                                await DataSyncer.read(context).sync(
                                  fromJson: _decodeJson.text,
                                );
                                showSnackBar(
                                  context,
                                  content: const Text('导入成功'),
                                );
                              } catch (e) {
                                showSnackBar(
                                  context,
                                  content: Text('导入失败: $e'),
                                );
                              }
                            }
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(40),
                ),
                child: const Text('从 JSON 导入数据到本地'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: MarkdownBody(
                onTapLink: (name, href, title) {
                  href?.let((h) => launchUrl(Uri.parse(h)));
                },
                selectable: true,
                data: '''
**目前只支持导入GOOD格式圣遗物数据**

- 可用[Amenoma](https://github.com/daydreaming666/Amenoma)扫描导出

- 可用[yas-lock](https://github.com/ideless/yas-lock)扫描导出

- **可用修改版[Iridium](https://github.com/Escheee/Iridium)抓包导出(抓包方法参考[教程](https://ideless.github.io/artifact/tutorial/#11-抓包))**

''',
              ),
            ),
          ],
        ),
      ),
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
                      blocSyncer.bind(
                        wd.copyWith(
                          valid: err.response?.statusCode !=
                              HttpStatus.unauthorized,
                        ),
                      );
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
                              await DataSyncer.read(context)
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
                              await DataSyncer.read(context).sync();
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

class CurrentNumber extends HookWidget {
  final Widget label;
  final Widget current;

  const CurrentNumber({
    required this.label,
    required this.current,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 96),
      child: Column(
        children: [
          DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 11),
            child: Opacity(
              opacity: 0.7,
              child: label,
            ),
          ),
          DefaultTextStyle.merge(
            style: const TextStyle(
              fontSize: 18,
              height: 1.4,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
            child: current,
          ),
        ],
      ),
    );
  }
}
