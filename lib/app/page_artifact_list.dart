import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gamedata/bloc_artifact.dart';
import 'package:genshintools/app/gamedata/bloc_game_data.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/page_artifact_add.dart';
import 'package:genshintools/app/ui/alert.dart';
import 'package:genshintools/app/view_account.dart';
import 'package:genshintools/app/view_fight_props.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

import 'auth/auth.dart';

class PageArtifactList extends HookWidget {
  static String routeName = "/artifacts";

  const PageArtifactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var blocArtifact = BlocArtifact.watch(context);
    var equipTypes = EquipType.values;

    var grouped = blocArtifact
        .playerArtifactBuild(uid)
        .allArtifacts()
        .groupListsBy((e) => e.equipType);

    return AppBarWithAccount.buildScaffold(
      context,
      DefaultTabController(
        length: equipTypes.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                ...equipTypes.map(
                  (et) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Text(et.label()),
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 1),
            Expanded(
              child: TabBarView(
                children: [
                  ...equipTypes.map((et) {
                    // blocArtifact.state.all
                    var l = grouped[et] ?? [];

                    return ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            PageArtifactAdd.show(context, et);
                          },
                          title: Row(
                            children: const [
                              AppendValueIndex(indexes: [0, 1, 2, 3]),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "表示词条个数, 颜色分别代表数值档位",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          trailing: const Icon(Icons.add),
                        ),
                        const Divider(
                          height: 1,
                        ),
                        ...l.map((pa) => PlayerArtifactListTile(pa: pa)),
                      ],
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlayerArtifactListTile extends HookWidget {
  const PlayerArtifactListTile({
    Key? key,
    required this.pa,
    this.onAvatarTap,
  }) : super(key: key);

  final PlayerArtifact pa;
  final void Function()? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;
    var a = db.artifact.find(pa.name);
    var builds = db.character.findOrNull("${pa.usedBy}")?.characterAllBuilds();

    var appendDepot = db.artifact.artifactAppendDepot(pa.name);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () => PageArtifactAdd.show(context, pa.equipType, pa),
      onLongPress: () => _remove(context, pa),
      leading: GestureDetector(
        onTap: onAvatarTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            WithLevel(
              level: pa.level,
              child: GSImage(
                domain: 'artifact',
                nameID: a.nameID,
                rarity: pa.rarity,
                size: 48,
              ),
            ),
            Positioned(
              right: -8,
              top: -8,
              child: Column(
                children: [
                  ...?db.character.findOrNull("${pa.usedBy}")?.let((c) => [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: GSImage(
                            domain: "character",
                            rarity: c.rarity,
                            nameID: c.nameID,
                            rounded: true,
                            borderSize: 2,
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ],
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(pa.name),
                ],
              ),
            ),
          ),
          ViewFightProps(
            shouldHighlight: (fp) => true,
            fightProps: FightProps({
              pa.main: db.artifact.mainFightProp(pa.main, pa.rarity, pa.level)
            }),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...pa.appends.keys.map((fp) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  bottom: -4,
                  left: 2,
                  child: AppendValueIndex(
                    indexes: appendDepot.valueIndexes(fp, pa.appends[fp]),
                  ),
                ),
                ViewFightProps(
                  shouldHighlight: (fp) {
                    return builds?.artifactAffixPropTypes?.contains(fp) ??
                        false;
                  },
                  fightProps: FightProps({
                    fp: appendDepot.valueFor(fp, pa.appends[fp]),
                  }),
                ),
              ],
            );
          })
        ],
      ),
    );
  }

  _remove(BuildContext context, PlayerArtifact pa) {
    var uid = BlocAuth.read(context).state.chosenUid();

    showAlert(
      context,
      content: Text.rich(TextSpan(children: [
        TextSpan(text: "是否删除 ${pa.name}?"),
        const TextSpan(text: "\n"),
        const TextSpan(text: "\n"),
        TextSpan(
            text: "(${pa.toString()})", style: const TextStyle(fontSize: 11)),
      ])),
      onConfirm: () {
        BlocArtifact.read(context).remove(uid, pa);
      },
    );
  }
}
