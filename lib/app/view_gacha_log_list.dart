import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gacha/gacha.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/gameinfo/gameinfo.dart';

class ViewGachaLogList extends HookWidget {
  final int uid;

  const ViewGachaLogList({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = BlocGacha.watch(context).gachaState(uid);

    var logs = state.logs;
    var types = (logs.keys.toList()..sort()).reversed;

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
            ...types.map(
              (type) => Tab(
                child: Text(type),
              ),
            )
          ],
        ),
        Expanded(
          child: TabBarView(children: [
            ...types.map((type) {
              var gachaLogs = state.sortAndCount(logs[type]!);

              if (gachaLogs.isEmpty) {
                return const Center(
                  child: Text("没有抽卡记录"),
                );
              }

              return SingleChildScrollView(
                child: Column(
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
                    ExpansionTile(
                      title: const Text("五星保底"),
                      subtitle: Text("保底上限 ${type.contains("武器") ? 80 : 90}"),
                      childrenPadding: const EdgeInsets.all(8),
                      trailing: Text(
                        "${gachaLogs.last.rankType == "5" ? 0 : gachaLogs.last.countSinceLastGold}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: linearGradientForRarity(5).colors[0],
                        ),
                      ),
                      children: [
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: _renderLog(context,
                              gachaLogs.where((e) => e.rankType == "5")),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: const Text("四星保底"),
                      subtitle: const Text("保底上限 10"),
                      childrenPadding: const EdgeInsets.all(8),
                      trailing: Text(
                        "${gachaLogs.last.rankType == "4" ? 0 : gachaLogs.last.countSinceLastPurple}",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: linearGradientForRarity(4).colors[0],
                        ),
                      ),
                      children: [
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: _renderLog(
                            context,
                            gachaLogs.where((e) => e.rankType == "4"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
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
            nameID: c.nameID,
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
          nameID: w.nameID,
          rarity: w.rarity,
        ),
      );
    }).toList();
  }
}
