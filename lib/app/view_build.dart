import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/view_fight_props.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';

import 'gamedata/gamedata.dart';
import 'page_artifact_add.dart';

class WeaponListTile extends HookWidget {
  final GSWeapon weapon;
  final int refinement;
  final FightProps fightProps;
  final int level;
  final String? backup;
  final bool? full;

  const WeaponListTile({
    required this.weapon,
    required this.fightProps,
    required this.refinement,
    required this.level,
    this.backup,
    this.full,
    Key? key,
  }) : super(key: key);

  WeaponListTile asFull() {
    return WeaponListTile(
      weapon: weapon,
      fightProps: fightProps,
      refinement: refinement,
      level: level,
      backup: backup,
      full: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;

    if (full ?? false) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAvatar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: _buildInfo(context),
                    ),
                    const SizedBox(
                      height: 80,
                      child: VerticalDivider(
                        width: 16,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ViewFightProps(
                        fightProps: fightProps.fightPropsConvert(db.weapon
                            .fightProps(weapon.key, level, refinement)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return _buildAvatar();
  }

  Widget _buildAvatar() {
    return WithLevel(
      level: level,
      child: WithCount(
        prefix: "R",
        count: refinement,
        child: GSImage(
          size: 52,
          domain: "weapon",
          rarity: weapon.rarity,
          nameID: weapon.key,
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            "${weapon.name.text(Lang.CHS)}${backup?.let((v) => " [$v]") ?? ""}",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...weapon.weaponAffixes(refinement).map(
                    (e) => ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        iconPadding: EdgeInsets.zero,
                      ),
                      header: SelectableText(
                        e.name.text(Lang.CHS),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).hintColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      collapsed: Text(
                        e.desc.text(Lang.CHS),
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: GSDesc(
                        desc: e.desc,
                      ),
                    ),
                  ),
            ],
          ),
        )
      ],
    );
  }
}

class ViewBuildArtifactSetPair extends HookWidget {
  final FightProps fightProps;
  final List<GOODArtifact> artifacts;
  final String? backup;
  final bool? full;

  const ViewBuildArtifactSetPair({
    required this.fightProps,
    required this.artifacts,
    this.backup,
    this.full,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;

    var sets = db.artifact.resolveArtifactSets(artifacts);

    var fightPropsForSets =
        sets.fold<FightProps>(FightProps({}), (fightPropsForSets, artifactSet) {
      for (var ea in artifactSet.equipAffixes) {
        if ((artifactSet.activeNum ?? 0) >= ea.activeWhenNum!) {
          fightPropsForSets = fightPropsForSets
              .merge(fightProps.fightPropsConvert(ea.patchedFightProps()));
        }
      }
      return fightPropsForSets;
    });

    if (full ?? false) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImages(sets),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildInfo(context, sets),
                  ),
                  const SizedBox(
                    height: 80,
                    child: VerticalDivider(
                      width: 32,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ViewFightProps(
                      fightProps: fightPropsForSets,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return _buildImages(sets);
  }

  Widget _buildImages(List<GSArtifactSet> sets) {
    return SizedBox(
      width: 52,
      height: 52,
      child: Stack(
        children: [
          ...sets.mapIndexed((i, as) {
            var a = as.artifact(EquipType.BRACER);

            var img = GSImage(
              size: 52,
              domain: "artifact",
              rarity: a.rarity,
              nameID: a.key,
            );

            return sets.length == 1
                ? img
                : ClipPath(
                    clipper: i % 2 == 0
                        ? TopLeftTrianglePath()
                        : BottomRightTrianglePath(),
                    child: img,
                  );
          })
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, List<GSArtifactSet> sets) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyText2,
      child: Wrap(
        runSpacing: 4,
        children: [
          ...?backup?.let((it) => [
                Text("[$it]",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ))
              ]),
          Wrap(
            children: [
              ...sets.expand(
                (s) => s.equipAffixes
                    .where(
                      (ea) => (s.activeNum ?? 0) >= (ea.activeWhenNum ?? 0),
                    )
                    .map(
                      (e) => ExpandablePanel(
                        theme: const ExpandableThemeData(
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.center,
                          iconPadding: EdgeInsets.zero,
                        ),
                        header: Text(
                          "${e.name.text(Lang.CHS)} * ${e.activeWhenNum}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Theme.of(context).hintColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        collapsed: Text(
                          e.desc.text(Lang.CHS),
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: GSDesc(
                          desc: e.desc,
                        ),
                      ),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ViewBuildArtifacts extends HookWidget {
  final GSCharacterBuild builds;
  final CharacterWithState current;
  final FightProps fightProps;
  final ValueNotifier<CharacterWithState> state;

  const ViewBuildArtifacts({
    required this.builds,
    required this.current,
    required this.fightProps,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 4,
        children: [
          ...current.artifacts.map((a) {
            return Wrap(
              runSpacing: 4,
              children: [
                _buildHeader(
                    context,
                    state.value.artifacts
                        .firstWhere((e) => e.slotKey == a.slotKey)),
                _buildMainProp(context, a),
              ],
            );
          }),
          _buildAppendProps(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GOODArtifact currentArtifact) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            currentArtifact.slotKey.asEquipType().label(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "＋",
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "${currentArtifact.level}",
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainProp(BuildContext context, GOODArtifact currentArtifact) {
    var dataState = BlocGameData.read(context);
    var db = dataState.db;
    var artifact = state.value.artifacts
        .firstWhereOrNull((a) => a.slotKey == currentArtifact.slotKey);

    return Wrap(
      runSpacing: 2,
      children: [
        ...{
          currentArtifact.mainStatKey.asFightProp(),
          ...?builds
              .artifactMainPropTypes?[currentArtifact.slotKey.asEquipType()],
        }.map((fp) => Container(
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                width: 1,
                color: (fp == artifact?.mainStatKey.asFightProp())
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
              ))),
              padding: const EdgeInsets.only(left: 4),
              child: GestureDetector(
                onTap: () {
                  state.value = state.value.copyWith(
                    artifacts: [
                      ...state.value.artifacts.map((artifact) =>
                          artifact.slotKey == currentArtifact.slotKey
                              ? artifact.copyWith(
                                  mainStatKey:
                                      GOODArtifact.statKeyFromFightProp(fp),
                                )
                              : artifact)
                    ],
                  );
                },
                child: ViewFightProps(
                  shouldHighlight: (fightProp) =>
                      builds.artifactMainPropTypes?[
                              currentArtifact.slotKey.asEquipType()]
                          ?.contains(fightProp) ??
                      false,
                  fightProps: FightProps({
                    fp: db.artifact.mainFightProp(
                      fp,
                      currentArtifact.rarity,
                      artifact?.level ?? currentArtifact.level,
                    ),
                  }),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildAppendProps(BuildContext context) {
    var blocGameData = BlocGameData.read(context);
    var as = blocGameData.db.artifact;

    var ranks = current.appendPropsRanks(as, builds, fightProps, details: true);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AppendPropsRank(ranks: ranks),
    );
  }
}

class AppendPropsRank extends StatelessWidget {
  const AppendPropsRank({
    Key? key,
    required this.ranks,
  }) : super(key: key);

  final Map<String, Rank> ranks;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 6,
      children: [
        ...ranks.keys.map((key) => DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
              child: Opacity(
                opacity: ranks[key]!.used ? 1 : 0.6,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(fontSize: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(key, style: const TextStyle(fontSize: 7)),
                            Text(ranks[key]!.value.toStringAsFixed(1))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: AppendValueIndex(
                          indexes: ranks[key]!.indexes,
                        ))
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

class TopLeftTrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width / 5 * 2 - 1, size.height);
    path.lineTo(size.width / 5 * 3 - 1, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BottomRightTrianglePath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(size.width / 5 * 2, size.height);
    path.lineTo(size.width / 5 * 3, 0);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
