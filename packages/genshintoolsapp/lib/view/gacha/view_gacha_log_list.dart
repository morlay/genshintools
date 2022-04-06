import 'package:collection/collection.dart';
import 'package:genshingameinfo/genshingameinfo.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/gacha.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/gameui.dart';

const types = {
  "301": "限",
  "302": "武",
  "200": "常",
  "100": "新",
};

class ViewGachaLogList extends HookWidget {
  final int uid;

  const ViewGachaLogList({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = BlocGacha.watch(context).gachaState(uid);

    var logs = types.map((type, _) =>
        MapEntry(type, state.sortAndCount(state.listFor(type)).reversed));

    var gachaLogs = logs.values.expand((l) => l);

    if (gachaLogs.isEmpty) {
      return const Center(
        child: Text("没有抽卡记录"),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            ...types.keys.take(3).expandIndexed((i, type) {
              var logsOfType = (logs[type] ?? []);

              return [
                Expanded(
                  flex: 1,
                  child: _withListOnTap(
                    context,
                    noCount: true,
                    list: logsOfType
                        .where((l) => l.rankType == "5" || l.rankType == "4"),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("${types[type]}"),
                                Text(
                                  "${logsOfType.length} 抽",
                                ),
                              ],
                            ),
                          ),
                          DefaultTextStyle.merge(
                            style: TextStyle(fontSize: 18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: logsOfType.firstOrNull?.let((l) => [
                                        DefaultTextStyle.merge(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: linearGradientForRarity(5)
                                                .colors
                                                .first,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  "${l.rankType == "5" ? 0 : l.countSinceLastGold}"),
                                              Text(
                                                " / ${(type == "302" ? 80 : 90)}",
                                                style: TextStyle(fontSize: 9),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DefaultTextStyle.merge(
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: linearGradientForRarity(4)
                                                .colors
                                                .first,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${l.rankType == "4" ? 0 : l.countSinceLastPurple}",
                                              ),
                                              Text(" / ${10}",
                                                  style:
                                                      TextStyle(fontSize: 9)),
                                            ],
                                          ),
                                        ),
                                      ]) ??
                                  [],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ];
            }),
          ],
        ),
        const Divider(height: 0),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 4,
                runSpacing: 4,
                children: [
                  ..._renderLogs(
                      context,
                      gachaLogs
                          .where((l) => l.rankType == "5" || l.rankType == "4")
                          .toList()
                        ..sort((a, b) {
                          if (b.rankType == a.rankType) {
                            return b.id.compareTo(a.id);
                          }
                          return b.rankType.compareTo(a.rankType);
                        }))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _withListOnTap(
    BuildContext context, {
    required Iterable<GachaLog> list,
    required Widget child,
    bool noCount = false,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (c) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        ...list.mapIndexed(
                          (i, log) => ListTile(
                            leading: _renderLogAvatar(
                                context, log, noCount ? -1 : (list.length - i)),
                            title: Text(log.id),
                            subtitle: Text(log.time.toLocal().toString()),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: child,
    );
  }

  List<Widget> _renderLogs(BuildContext context, Iterable<GachaLog> logs) {
    var groups = logs.groupListsBy((e) => e.name);

    return [
      ...groups.values.map((list) {
        var first = list.first;

        return _withListOnTap(
          context,
          list: list,
          child: _renderLogAvatar(context, first, list.length),
        );
      })
    ];
  }

  Widget _renderLogAvatar(BuildContext context, GachaLog log, int count) {
    var db = BlocGameData.read(context).db;

    var isCharacter = log.itemType.contains("角色");

    var fixedCount = (isCharacter ? count - 1 : count) +
        ([
          "香菱",
          "安柏",
          "凯亚",
          "丽莎",
        ].contains(log.name)
            ? 1
            : 0);

    return WithType(
      type: log.uigfGachaType,
      child: WithCount(
        alignment: Alignment.topLeft,
        prefix: "[",
        count: log.rankType == "5"
            ? log.countSinceLastGold
            : log.countSinceLastPurple,
        suffix: "]",
        child: WithCount(
          count: fixedCount,
          prefix: "${isCharacter ? "C" : "R"}",
          active: isCharacter ? fixedCount >= 6 : fixedCount >= 5,
          child: isCharacter
              ? db.character.find(log.name).let((c) => GSImage(
                    domain: "character",
                    nameID: c.key,
                    rarity: c.rarity,
                  ))
              : db.weapon.find(log.name).let(
                    (w) => GSImage(
                      domain: "weapon",
                      nameID: w.key,
                      rarity: w.rarity,
                    ),
                  ),
        ),
      ),
    );
  }
}

class WithType extends HookWidget {
  final String? type;
  final Widget child;

  const WithType({
    required this.child,
    this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        color: typeColors[type]?.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: DefaultTextStyle.merge(
                  style: TextStyle(fontSize: 8, color: Colors.white),
                  child: Text(types[type] ?? "-"),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: BorderRadius.circular(30).bottomRight,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

const typeColors = {
  "301": Colors.pinkAccent,
  "302": Colors.purpleAccent,
  "200": Colors.blue,
  "100": Colors.deepOrangeAccent,
};
