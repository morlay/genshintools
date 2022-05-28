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
                                      indexes: [-4, -3, -2, -1, 1, 2, 3, 4],),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 16,
                              children: [
                                ...l.map((artifact) =>
                                    GOODArtifactCard(artifact: artifact),),
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
  }) : super(key: key);

  final GOODArtifact artifact;
  final void Function()? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var bloc = BlocGameData.read(context);
    var db = BlocGameData.read(context).db;

    var a = db.artifact
        .findSet(artifact.setKey)
        .artifact(artifact.slotKey.asEquipType());

    var builds = db.character.findOrNull(artifact.location)?.let(
          (c) => c.characterBuildFor(
              bloc.playerState(uid).character(artifact.location).role,),
        );

    var fightProps = db.character.findOrNull(artifact.location)?.let((cc) {
          var c = bloc.findCharacterWithState(uid, cc.key);

          return db.character
              .fightProps(
                c.c.key,
                c.c.level,
                c.c.constellation,
              )
              .merge(db.weapon.fightProps(
                c.w.key,
                c.w.level,
                c.w.refinement,
              ),);
        }) ??
        FightProps({});

    var appendDepot = db.artifact.artifactAppendDepot(a.key);

    double infoWidth = 50;

    return InkWell(
      onTap: () => PageArtifactAdd.show(
          context, artifact.slotKey.asEquipType(), artifact,),
      onLongPress: () => _remove(context, artifact),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
        ),
        child: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 0,
                    left: -10,
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          a.name.text(Lang.CHS),
                          style: const TextStyle(fontSize: 7),
                        ),),
                  ),
                  Positioned(
                    left: 0,
                    bottom: -16,
                    right: 0,
                    child: FightPropView(
                        highlight: builds?.artifactAffixPropTypes
                            ?.contains(artifact.mainStatKey.asFightProp()),
                        fightProp: artifact.mainStatKey.asFightProp(),
                        value: db.artifact.mainFightProp(
                          artifact.mainStatKey.asFightProp(),
                          artifact.rarity,
                          artifact.level,
                        ),),
                  ),
                  _buildAvatar(a, db, infoWidth),
                ],
              ),
            ),
            SizedBox(
              width: infoWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...artifact.substats.map((ss) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: -1,
                          left: 0,
                          child: Stack(
                            children: [
                              Positioned(
                                child: AppendValueIndex(
                                  reverse: true,
                                  indexes: appendDepot.valueNs(
                                    ss.key.asFightProp(),
                                    ss.stringValue(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: infoWidth,
                                height: 1,
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
                              calcValue: (fp, value) {
                                if (fp == FightProp.ATTACK_PERCENT) {
                                  return fightProps.get(FightProp.BASE_ATTACK) *
                                      value;
                                }
                                if (fp == FightProp.HP_PERCENT) {
                                  return fightProps.get(FightProp.BASE_HP) *
                                      value;
                                }
                                if (fp == FightProp.DEFENSE_PERCENT) {
                                  return fightProps
                                          .get(FightProp.BASE_DEFENSE) *
                                      value;
                                }
                                return null;
                              },),
                        ),
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

  GestureDetector _buildAvatar(GSArtifact a, GSDB db, double size) {
    return GestureDetector(
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
          Positioned(
            left: -8,
            top: -8,
            child: Column(
              children: [
                ...?db.character.findOrNull(artifact.location)?.let((c) => [
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
                    ],),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _remove(BuildContext context, GOODArtifact pa) {
    var uid = BlocAuth.read(context).state.chosenUid();

    showAlert(
      context,
      content: Text.rich(TextSpan(children: [
        TextSpan(text: '是否删除 $pa?'),
        const TextSpan(text: '\n'),
        const TextSpan(text: '\n'),
        TextSpan(
            text: '(${pa.toString()})', style: const TextStyle(fontSize: 11),),
      ],),),
      onConfirm: () {
        BlocGameData.read(context).removeArtifact(uid, pa);
      },
    );
  }
}

class FightPropView extends HookWidget {
  const FightPropView({
    Key? key,
    required this.fightProp,
    required this.value,
    this.highlight,
    this.calcValue,
  }) : super(key: key);

  final FightProp fightProp;
  final double value;
  final double? Function(FightProp fp, double value)? calcValue;
  final bool? highlight;

  @override
  Widget build(BuildContext context) {
    final formatValue = format(value, fightProp.format());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLabel(),
          DefaultTextStyle.merge(
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: highlight?.ifTrueOrNull(() => FontWeight.bold),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -2,
                  right: -7,
                  child: Text(
                    formatValue.contains('%') ? '%' : '',
                    style: const TextStyle(
                      fontSize: 6,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5,
                  right: 0,
                  child: Text(
                    calcValue
                            ?.let((calc) => calc(fightProp, value))
                            ?.let((v) => '${v.toInt()}') ??
                        '',
                    style: const TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.normal,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                Text(
                  formatValue.replaceAll('%', ''),
                  style: const TextStyle(
                    fontSize: 11,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLabel() {
    var n = _shortName;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Text(
            n[n.length - 1],
            style: const TextStyle(
              textBaseline: TextBaseline.ideographic,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...?(n.length > 1).ifTrueOrNull(
          () => [
            Positioned(
              top: -2,
              right: -4,
              child: SizedBox(
                width: 7,
                child: Center(
                  child: Text(
                    n[0],
                    style: const TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [FontFeature.tabularFigures()],),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  String get _shortName {
    switch (fightProp) {
      case FightProp.CHARGE_EFFICIENCY:
        return '充';
      case FightProp.ELEMENT_MASTERY:
        return '精';
      case FightProp.CRITICAL:
        return '%暴';
      case FightProp.CRITICAL_HURT:
        return '*暴';
      default:
        if (fightProp.name.contains('HURT_ADD')) {
          return '+${fightProp.label()[0]}';
        }
        if (fightProp.name.contains('PERCENT')) {
          return '%${fightProp.label()[0]}';
        }
        return fightProp.label()[0];
    }
  }
}
