import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/view_fight_props.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

import 'gamedata/gamedata.dart';

class WeaponListTile extends HookWidget {
  final Weapon weapon;
  final int affixLevel;
  final FightProps fightProps;
  final int level;
  final String? backup;
  final bool? full;

  const WeaponListTile({
    required this.weapon,
    required this.fightProps,
    required this.affixLevel,
    required this.level,
    this.backup,
    this.full,
    Key? key,
  }) : super(key: key);

  WeaponListTile asFull() {
    return WeaponListTile(
      weapon: weapon,
      fightProps: fightProps,
      affixLevel: affixLevel,
      level: level,
      backup: backup,
      full: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var gdb = BlocGameData.read(context);
    var db = gdb.db;

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
                            .fightProps(weapon.nameID, level, affixLevel)),
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
        count: affixLevel,
        child: GSImage(
          size: 52,
          domain: "weapon",
          rarity: weapon.rarity,
          nameID: weapon.nameID,
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
              ...weapon.weaponAffixes(affixLevel).map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: SelectableText(
                                e.name.text(Lang.CHS),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Theme.of(context).hintColor,
                                ),
                                textAlign: TextAlign.left,
                              )),
                          GSDesc(
                            desc: e.desc,
                          ),
                        ],
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
  final Map<EquipType, PlayerArtifact> artifacts;
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
                    child: _buildInfo(sets),
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
            var a = as.artifact(EquipType.FLOWER);

            var img = GSImage(
              size: 52,
              domain: "artifact",
              rarity: a.rarity,
              nameID: a.nameID,
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

  Widget _buildInfo(List<GSArtifactSet> sets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "${sets.map((s) => s.name.text(Lang.CHS)).join(" / ")}${backup?.let((it) => " [$it]") ?? ""}",
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              children: [
                ...sets.expand(
                  (s) => s.equipAffixes
                      .where(
                        (ea) => (s.activeNum ?? 0) >= (ea.activeWhenNum ?? 0),
                      )
                      .map(
                        (e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GSDesc(
                              desc: e.desc,
                            ),
                          ],
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ViewBuildArtifacts extends HookWidget {
  final GSCharacterBuild builds;
  final CharacterState state;

  const ViewBuildArtifacts({
    required this.state,
    required this.builds,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        runSpacing: 4,
        children: [
          ...EquipType.values.map((et) {
            return Wrap(
              runSpacing: 4,
              children: [
                _buildHeader(context, et),
                _buildMainProp(context, et),
              ],
            );
          })
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, EquipType et) {
    var a = state.build.artifact(et);

    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            et.label(),
            style: TextStyle(
              fontSize: 12,
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
                  text: "${a.level}",
                  style: const TextStyle(
                    fontSize: 10,
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

  Widget _buildMainProp(BuildContext context, EquipType et) {
    var a = state.build.artifact(et);

    var dataState = BlocGameData.read(context);
    var db = dataState.db;

    return Wrap(
      runSpacing: 2,
      children: [
        ...{
          ...?state.defaultBuild?.artifact(et).let((a) => [a.main]),
          ...?builds.artifactMainPropTypes?[et],
        }.map((fp) => Opacity(
              opacity: fp == a.main ? 1 : 0.5,
              child: GestureDetector(
                onTap: () {
                  dataState.updateCharacterState(
                    BlocAuth.read(context).state.chosenUid(),
                    state.id,
                    (state) => state.withMainProp(builds, et, fp),
                  );
                },
                child: ViewFightProps(
                  shouldHighlight: (fightProp) =>
                      builds.artifactMainPropTypes?[et]?.contains(fightProp) ??
                      false,
                  fightProps: FightProps({
                    fp: db.artifact.mainFightProp(fp, a.rarity, a.level),
                  }),
                ),
              ),
            )),
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
    path.lineTo(size.width / 5 * 2, size.height);
    path.lineTo(size.width / 5 * 3, 0);
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
