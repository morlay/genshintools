import 'package:genshingameinfo/genshingameinfo.dart';
import 'package:genshintoolsapp/domain/gacha.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/flutter/flutter.dart';
import 'package:genshintoolsapp/view/gameui.dart';

class ViewGachaLogList extends HookWidget {
  final int uid;

  const ViewGachaLogList({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = BlocGacha.watch(context).gachaState(uid);

    var types = {
      "301": "角色活动祈愿",
      "302": "武器活动祈愿",
      "200": "常驻祈愿",
      "100": "新手祈愿",
    };

    return DefaultTabController(
      length: types.length,
      child: Column(children: [
        TabBar(
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
          tabs: [
            ...types.values.map(
              (type) => Tab(
                child: Text(type),
              ),
            )
          ],
        ),
        Expanded(
          child: TabBarView(children: [
            ...types.keys.map((type) {
              var gachaLogs = state.sortAndCount(state.listFor(type));

              if (gachaLogs.isEmpty) {
                return const Center(
                  child: Text("没有抽卡记录"),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: const Text("总抽卡数"),
                    subtitle: Text("原石消耗 ${gachaLogs.length * 160}"),
                    trailing: Text(
                      "${gachaLogs.length}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text("五星保底"),
                    subtitle: Text("保底上限 ${type.contains("武器") ? 80 : 90}"),
                    trailing: Text(
                      "${gachaLogs.last.rankType == "5" ? 0 : gachaLogs.last.countSinceLastGold}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: linearGradientForRarity(5).colors[0],
                      ),
                    ),
                  ),
                  ...?gachaLogs.where((e) => e.rankType == "5").let((logs) {
                    return logs.isNotEmpty.ifTrueOrNull(() => [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: _renderLog(context, logs),
                                ),
                              ),
                            ),
                          )
                        ]);
                  }),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text("四星保底"),
                    subtitle: const Text("保底上限 10"),
                    trailing: Text(
                      "${gachaLogs.last.rankType == "4" ? 0 : gachaLogs.last.countSinceLastPurple}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: linearGradientForRarity(4).colors[0],
                      ),
                    ),
                  ),
                  ...?gachaLogs.where((e) => e.rankType == "4").let((logs) {
                    return logs.isNotEmpty.ifTrueOrNull(() => [
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: _renderLog(context, logs),
                                ),
                              ),
                            ),
                          )
                        ]);
                  }),
                ],
              );
            })
          ]),
        ),
      ]),
    );
  }

  List<Widget> _renderLog(BuildContext context, Iterable<GachaLog> logs) {
    var db = BlocGameData.read(context).db;

    return logs.map((e) {
      if (e.itemType.contains("角色")) {
        var c = db.character.find(e.name);

        return WithCount(
          suffix: " 抽",
          count: c.rarity == 4 ? e.countSinceLastPurple : e.countSinceLastGold,
          child: GSImage(
            domain: "character",
            nameID: c.key,
            rarity: c.rarity,
          ),
        );
      }

      var w = db.weapon.find(e.name);

      return WithCount(
        suffix: " 抽",
        count: w.rarity == 4 ? e.countSinceLastPurple : e.countSinceLastGold,
        child: GSImage(
          domain: "weapon",
          nameID: w.key,
          rarity: w.rarity,
        ),
      );
    }).toList();
  }
}
