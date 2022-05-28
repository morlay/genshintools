import 'package:dio/dio.dart';
import 'package:genshingameinfo/genshingameinfo.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gacha.dart';
import 'package:genshintoolsapp/common/flutter.dart';

class PageGachaSync extends HookWidget {
  static String routeName = '/gacha/sync';

  static show(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageGachaSync.routeName),
        builder: (context) => const PageGachaSync(),
      ),
    );
  }

  const PageGachaSync({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('同步抽卡记录'),
      ),
      body: FormGachaSync(),
    );
  }
}

class FormGachaSync extends HookWidget {
  FormGachaSync({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final logURL = useTextEditingController();
    final info = useState('');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: logURL,
              minLines: 4,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'https://webstatic.mihoyo.com/....#/log',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请填入抽卡记录链接';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              child: const Text('同步抽卡记录'),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _startSync(context, logURL.text.trim(), info);
                }
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(info.value),
            )
          ],
        ),
      ),
    );
  }

  _startSync(
    BuildContext context,
    String gachaLogURL,
    ValueNotifier info,
  ) async {
    var client = GachaClient(
      dio: Dio(),
      gachaLogURL: gachaLogURL,
      useProxy: kIsWeb,
    );

    var uid = BlocAuth.read(context).state.chosenUid();
    var blocGacha = BlocGacha.read(context);

    var state = blocGacha.gachaState(uid);

    var types = await client.listGachaType();

    for (final gachaType in types) {
      List<GachaLog> logs = state.listFor(gachaType.key);

      var untilId = logs.isNotEmpty ? logs.last.id : '0';
      var noNextPage = false;
      var page = 0;

      var endId = '0';

      while (true) {
        page++;

        info.value = '开始同步${gachaType.name} 第 $page 页';

        await Future.delayed(const Duration(seconds: 1));

        try {
          var list =
              await client.listGachaLog(gachaType: gachaType, endId: endId);

          endId = list.isNotEmpty ? list.last.id : '0';

          for (final item in list.reversed) {
            if (item.uid != '$uid') {
              noNextPage = true;
              break;
            }
            if (untilId != '0' && untilId == item.id) {
              noNextPage = true;
            }
            logs.add(item);
          }

          if (list.isEmpty || noNextPage) {
            break;
          }
        } catch (e) {
          info.value = '同步异常 $e';
        }
      }

      blocGacha.syncGachaLogs(uid, logs);
    }

    info.value = '完成全部同步';
    safePop(context);
  }
}
