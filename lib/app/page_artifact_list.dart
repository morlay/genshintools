import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gamedata/bloc_game_data.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/page_artifact_add.dart';
import 'package:genshintools/app/ui/alert.dart';
import 'package:genshintools/app/view_account.dart';
import 'package:genshintools/app/view_fight_props.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';

import 'auth/auth.dart';

class PageArtifactList extends HookWidget {
  static String routeName = "/artifacts";

  const PageArtifactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var blocGameData = BlocGameData.watch(context);
    var equipTypes = EquipType.values;

    var grouped = blocGameData
        .playerState(uid)
        .artifacts
        .groupListsBy((e) => e.slotKey.asEquipType());

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
                        ...l.map((artifact) =>
                            GOODArtifactListTile(artifact: artifact)),
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

class GOODArtifactListTile extends HookWidget {
  const GOODArtifactListTile({
    Key? key,
    required this.artifact,
    this.onAvatarTap,
  }) : super(key: key);

  final GOODArtifact artifact;
  final void Function()? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;
    var a = db.artifact
        .findSet(artifact.setKey)
        .artifact(artifact.slotKey.asEquipType());

    var builds =
        db.character.findOrNull(artifact.location)?.characterAllBuilds();

    var appendDepot = db.artifact.artifactAppendDepot(a.key);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      onTap: () => PageArtifactAdd.show(
          context, artifact.slotKey.asEquipType(), artifact),
      onLongPress: () => _remove(context, artifact),
      leading: GestureDetector(
        onTap: onAvatarTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            WithLevel(
              level: artifact.level,
              child: GSImage(
                domain: 'artifact',
                nameID: a.key,
                rarity: artifact.rarity,
                size: 48,
              ),
            ),
            Positioned(
              right: -8,
              top: -8,
              child: Column(
                children: [
                  ...?db.character.findOrNull(artifact.location)?.let((c) => [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: GSImage(
                            domain: "character",
                            rarity: c.rarity,
                            nameID: c.key,
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
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a.name.text(Lang.CHS)),
                ViewFightProps(
                  shouldHighlight: (fp) => true,
                  fightProps: FightProps({
                    artifact.mainStatKey.asFightProp():
                        db.artifact.mainFightProp(
                      artifact.mainStatKey.asFightProp(),
                      artifact.rarity,
                      artifact.level,
                    )
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 56,
            width: 32,
            child: VerticalDivider(),
          ),
          Expanded(
            flex: 3,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...artifact.substats.map((ss) {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: -4,
                        left: 2,
                        child: AppendValueIndex(
                          indexes: appendDepot.valueIndexes(
                            ss.key.asFightProp(),
                            ss.stringValue(),
                          ),
                        ),
                      ),
                      ViewFightProps(
                        shouldHighlight: (fp) {
                          return builds?.artifactAffixPropTypes?.contains(fp) ??
                              false;
                        },
                        fightProps: FightProps({
                          ss.key.asFightProp(): appendDepot.valueFor(
                            ss.key.asFightProp(),
                            ss.stringValue(),
                          ),
                        }),
                      ),
                    ],
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }

  _remove(BuildContext context, GOODArtifact pa) {
    var uid = BlocAuth.read(context).state.chosenUid();

    showAlert(
      context,
      content: Text.rich(TextSpan(children: [
        TextSpan(text: "是否删除 $pa?"),
        const TextSpan(text: "\n"),
        const TextSpan(text: "\n"),
        TextSpan(
            text: "(${pa.toString()})", style: const TextStyle(fontSize: 11)),
      ])),
      onConfirm: () {
        BlocGameData.read(context).removeArtifact(uid, pa);
      },
    );
  }
}
