import 'package:collection/collection.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/account.dart';
import 'package:genshintoolsapp/view/gameui.dart';

import 'page_artifact_add.dart';

class PageArtifactList extends HookWidget {
  static String routeName = '/artifacts';

  const PageArtifactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth
        .watch(context)
        .state
        .chosenUid();
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
              labelColor: Theme
                  .of(context)
                  .primaryColor,
              indicatorColor: Theme
                  .of(context)
                  .primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                ...equipTypes.map(
                      (et) =>
                      Tab(
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

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            onTap: () {
                              PageArtifactAdd.show(context, et);
                            },
                            title: Row(
                              children: const [
                                SizedBox(
                                  width: 24 * 2,
                                  child: AppendValueIndex(
                                    indexes: [-4, -3, -2, -1, 1, 2, 3, 4],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '表示词条个数, 颜色分别代表数值档位',
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 16, left: 14, right: 10),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 24,
                              runSpacing: 16,
                              children: [
                                ...l.map(
                                      (artifact) =>
                                      GOODArtifactCard(artifact: artifact),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
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

class GOODArtifactCard extends HookWidget {
  const GOODArtifactCard({
    Key? key,
    required this.artifact,
    this.onAvatarTap,
    this.noHead,
    this.noDelete,
    this.mainProps,
  }) : super(key: key);

  final Widget? mainProps;
  final bool? noHead;
  final bool? noDelete;
  final GOODArtifact artifact;
  final void Function()? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth
        .watch(context)
        .state
        .chosenUid();
    var bloc = BlocGameData.read(context);
    var db = BlocGameData
        .read(context)
        .db;

    var a = db.artifact
        .findSet(artifact.setKey)
        .artifact(artifact.slotKey.asEquipType());

    var builds = db.character.findOrNull(artifact.location)?.let(
          (c) =>
          c.characterBuildFor(
            bloc
                .playerState(uid)
                .character(artifact.location)
                .role,
          ),
    );

    var fightProps = db.character.findOrNull(artifact.location)?.let((cc) {
      var c = bloc.findCharacterWithState(uid, cc.key);

      return db.character
          .fightProps(
        c.c.key,
        c.c.level,
        c.c.constellation,
      )
          .merge(
        db.weapon.fightProps(
          c.w.key,
          c.w.level,
          c.w.refinement,
        ),
      );
    }) ??
        FightProps({});

    var appendDepot = db.artifact.artifactAppendDepot(a.key);

    double infoWidth = 48;

    return EquipCard(
      onTap: () =>
          PageArtifactAdd.show(
              context, artifact.slotKey.asEquipType(), artifact),
      onLongPress: () {
        if (!(noDelete ?? false)) {
          _remove(context, artifact);
        }
      },
      name: a.name.text(Lang.CHS),
      avatar: _buildAvatar(a, db, infoWidth),
      title: mainProps ?? _buildMainProp(builds, db, infoWidth),
      info: SizedBox(
        width: infoWidth,
        child: _buildAppendProps(appendDepot, infoWidth, builds, fightProps),
      ),
    );
  }

  Widget _buildMainProp(GSCharacterBuild? builds, GSDB db, double infoWidth) {
    return SizedBox(
      width: infoWidth,
      child: FightPropView(
        highlight: builds?.artifactAffixPropTypes
            ?.contains(artifact.mainStatKey.asFightProp()),
        fightProp: artifact.mainStatKey.asFightProp(),
        value: db.artifact.mainFightProp(
          artifact.mainStatKey.asFightProp(),
          artifact.rarity,
          artifact.level,
        ),
      ),
    );
  }

  Column _buildAppendProps(GSArtifactAppendDepot appendDepot, double infoWidth,
      GSCharacterBuild? builds, FightProps fightProps) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...artifact.substats.map((ss) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 17,
                right: 0,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: -1,
                      child: Opacity(
                        opacity: 0.5,
                        child: AppendValueIndex(
                          reverse: true,
                          indexes: appendDepot.valueNs(
                            ss.key.asFightProp(),
                            ss.stringValue(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: infoWidth,
                      height: 2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: FightPropView(
                  highlight: builds?.artifactAffixPropTypes
                      ?.contains(ss.key.asFightProp()),
                  fightProp: ss.key.asFightProp(),
                  value: appendDepot.valueFor(
                    ss.key.asFightProp(),
                    ss.stringValue(),
                  ),
                  calcValue: fightProps.calcValue,
                ),
              ),
            ],
          );
        })
      ],
    );
  }

  Widget _buildAvatar(GSArtifact a, GSDB db, double size) {
    return InkWell(
      onTap: onAvatarTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          WithLevel(
            level: artifact.level,
            child: GSImage(
              domain: 'artifact',
              icon: a.icon,
              rarity: artifact.rarity,
              size: size.toInt(),
            ),
          ),
          ...(noHead ?? false)
              ? []
              : [
            Positioned(
              left: -8,
              top: -8,
              child: Column(
                children: [
                  ...?db.character.findOrNull(artifact.location)?.let(
                        (c) =>
                    [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: GSImage(
                          domain: 'character',
                          rarity: c.rarity,
                          icon: c.icon,
                          rounded: true,
                          borderSize: 2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }

  _remove(BuildContext context, GOODArtifact pa) {
    var uid = BlocAuth
        .read(context)
        .state
        .chosenUid();

    showAlert(
      context,
      content: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '是否删除 $pa?'),
            const TextSpan(text: '\n'),
            const TextSpan(text: '\n'),
            TextSpan(
              text: '(${pa.toString()})',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
      onConfirm: () {
        BlocGameData.read(context).removeArtifact(uid, pa);
      },
    );
  }
}
