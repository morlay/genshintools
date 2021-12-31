import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/page_artifact_list.dart';
import 'package:genshintools/app/ui/select.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth/auth.dart';
import 'view_build.dart';
import 'view_fight_props.dart';
import 'view_skill.dart';

class PageCharacter extends HookWidget {
  static String routeName = "/character";

  static void show(BuildContext context, int id) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageCharacter.routeName),
        fullscreenDialog: false,
        builder: (context) => PageCharacter(id: id),
      ),
    );
  }

  final int id;

  const PageCharacter({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var blocGameData = BlocGameData.watch(context);
    var blocArtifact = BlocArtifact.watch(context);
    var db = blocGameData.db;

    var c = blocGameData.findCharacterWithState(uid, "$id");

    if (c == null) {
      return const Center(
        child: Text("NotFound"),
      );
    }

    var builds = c.character.characterAllBuilds();

    var playerArtifacts =
        blocArtifact.playerArtifactBuild(uid).artifacts(c.character.id);

    useEffect(() {
      playerArtifacts?.let((playerArtifacts) {
        Map<EquipType, PlayerArtifact> artifacts = {};

        for (var et in EquipType.values) {
          if (playerArtifacts[et] != null) {
            artifacts[et] = playerArtifacts[et]!;
            continue;
          }
          var artifactCreateFor = c.state.build.artifact(et).copyWith(
                usedBy: c.character.id,
              );

          artifacts[et] = artifactCreateFor;

          if (c.state.todo) {
            blocArtifact.equip(uid, artifactCreateFor);
          }
        }

        blocGameData.updateCharacterState(
          uid,
          c.character.id,
          (characterState) {
            var nextBuild =
                (characterState.defaultBuild ?? characterState.build).copyWith(
              artifacts: artifacts,
            );
            return characterState.copyWith(
              build: nextBuild,
              defaultBuild: nextBuild,
            );
          },
        );
      });
    }, [playerArtifacts?.values.map((e) => e.toString()).join("|")]);

    var fightProps = db.character
        .fightProps(
          id.toString(),
          c.state.level,
          c.state.activeConstellationNum,
        )
        .merge(db.weapon.fightProps(
          c.state.build.weaponID.toString(),
          c.state.build.weaponLevel,
          c.state.build.weaponAffixLevel,
        ))
        .merge(db.artifact.fightProps(
          c.state.build.artifacts,
        ))
        .compute();

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context, c),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 90,
                              child:
                                  _buildBuild(context, c, fightProps, builds),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: _buildDashboard(
                                    context, fightProps, builds),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: MarkdownBody(
                          onTapLink: (name, href, title) {
                            href?.let((it) => launch(it));
                          },
                          styleSheet: Theme.of(context).let(
                            (theme) =>
                                MarkdownStyleSheet.fromTheme(theme).copyWith(
                              p: theme.textTheme.bodyText2?.copyWith(
                                fontSize: 8,
                              ),
                            ),
                          ),
                          data: """
配装参考数据来自 [Genshin Impact Helper Team](https://heystacks.org/doc/743/genshin-impact-general-character-strats)
""",
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: _buildSkills(context, c, fightProps),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: ExpandableNotifier(
                child: ExpandablePanel(
                  collapsed: ExpandableButton(
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Center(child: Text("等级修改")),
                    ),
                  ),
                  expanded: Column(
                    children: [
                      ExpandableButton(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("等级修改")),
                        ),
                      ),
                      _buildSettings(context, c.state),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    FightProps fightProps,
    GSCharacterBuild? builds,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ViewFightProps(
        asDashboard: true,
        fightProps: fightProps,
        shouldHighlight: (FightProp fp) => [
          ...?builds?.artifactMainPropTypes?.values.expand((e) => e),
          ...?builds?.artifactAffixPropTypes,
        ].contains(fp),
      ),
    );
  }

  Widget _buildSettings(BuildContext context, CharacterState state) {
    var gbBloc = BlocGameData.read(context);
    var uid = BlocAuth.read(context).state.chosenUid();

    Map<String, Slider> sliders = {
      "角色等级": Slider(
        value: state.level.toDouble(),
        min: 1,
        max: 90,
        divisions: 90 ~/ 5,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              level: value.toInt(),
            ),
          );
        },
      ),
      "角色命座": Slider(
        value: state.activeConstellationNum.toDouble(),
        min: 0,
        max: 6,
        divisions: 6,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              activeConstellationNum: value.toInt(),
            ),
          );
        },
      ),
      "${SkillType.NORMAL_ATTACK.label()}等级": Slider(
        value: state.skillLevel(SkillType.NORMAL_ATTACK).toDouble(),
        min: 1,
        max: 10,
        divisions: 10,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              skillLevels: {
                ...state.skillLevels,
                SkillType.NORMAL_ATTACK: value.toInt(),
              },
            ),
          );
        },
      ),
      "${SkillType.ELEMENTAL_SKILL.label()}等级": Slider(
        value: state.skillLevel(SkillType.ELEMENTAL_SKILL).toDouble(),
        min: 1,
        max: 10,
        divisions: 10,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              skillLevels: {
                ...state.skillLevels,
                SkillType.ELEMENTAL_SKILL: value.toInt(),
              },
            ),
          );
        },
      ),
      "${SkillType.ELEMENTAL_BURST.label()}等级": Slider(
        value: state.skillLevel(SkillType.ELEMENTAL_BURST).toDouble(),
        min: 1,
        max: 10,
        divisions: 10,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              skillLevels: {
                ...state.skillLevels,
                SkillType.ELEMENTAL_BURST: value.toInt(),
              },
            ),
          );
        },
      ),
      "武器等级": Slider(
        value: state.build.weaponLevel.toDouble(),
        min: 1,
        max: 90,
        divisions: 90 ~/ 5,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              build: state.build.copyWith(weaponLevel: value.toInt()),
            ),
          );
        },
      ),
      "武器精炼": Slider(
        value: state.build.weaponAffixLevel.toDouble(),
        min: 1,
        max: 5,
        divisions: 5,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              build: state.build.copyWith(weaponAffixLevel: value.toInt()),
            ),
          );
        },
      ),
      "圣遗物等级": Slider(
        value: state.build.artifact(EquipType.FLOWER).level.toDouble(),
        min: 0,
        max: 20,
        divisions: 20 ~/ 4,
        onChanged: (double value) {
          gbBloc.updateCharacterState(
            uid,
            state.id,
            (state) => state.copyWith(
              build: state.build.copyWith(
                artifacts: state.build.artifacts.map(
                  (key, artifact) => MapEntry(
                    key,
                    artifact.copyWith(
                      level: value.toInt(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    };

    return DefaultTabController(
      length: sliders.keys.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
            tabs: [
              ...sliders.keys.map(
                (key) => Tab(
                  child: Text(key, style: const TextStyle(fontSize: 11)),
                  height: 24,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
            child: Center(
              child: TabBarView(
                children: [
                  ...sliders.values.map((v) => v),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuild(
    BuildContext context,
    CharacterWithState c,
    FightProps fightProps,
    GSCharacterBuild builds,
  ) {
    var uid = BlocAuth.read(context).state.chosenUid();
    var gbBloc = BlocGameData.read(context);
    var db = gbBloc.db;

    List<WeaponListTile> weapons = [
      ...?c.state.defaultBuild?.let((it) => [
            WeaponListTile(
              fightProps: fightProps,
              weapon: db.weapon.find(it.weaponID.toString()),
              level: c.state.build.weaponLevel,
              affixLevel: c.state.build.weaponAffixLevel,
              backup: "当装配装",
            )
          ]),
      ...?builds.weapons?.map((e) => WeaponListTile(
            fightProps: fightProps,
            weapon: db.weapon.find(e),
            level: c.state.build.weaponLevel,
            affixLevel: 1,
          )),
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 8,
            children: [
              Select<WeaponListTile>(
                value: weapons.firstWhereOrNull(
                  (w) => w.weapon.id == c.state.build.weaponID,
                ),
                onSelected: (w) {
                  gbBloc.updateCharacterState(
                    uid,
                    c.state.id,
                    (state) => c.state.withWeaponId(w.weapon.id),
                  );
                },
                options: weapons,
                optionBuilder: (context, item, selected) {
                  return GestureDetector(
                    onTap: () {
                      item.select();
                    },
                    child: item.value.asFull(),
                  );
                },
                tileBuilder: (context, selected) {
                  return GestureDetector(
                    child: selected.value ?? const Text(""),
                    onTap: () {
                      selected.showOptions(context);
                    },
                  );
                },
              ),
              ViewArtifactBuilder(uid: uid, c: c, fightProps: fightProps),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ViewBuildArtifacts(
              builds: builds,
              state: c.state,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSkills(
    BuildContext context,
    CharacterWithState c,
    FightProps fightProps,
  ) {
    var len = c.character.skills.length + c.character.inherentSkills.length;
    var skillPriority = c.character.characterBuild?.skillPriority ?? [];

    var skills = c.character.skills
      ..sort(
        (a, b) =>
            b.priority(skillPriority).compareTo(a.priority(skillPriority)),
      );

    return DefaultTabController(
      length: len,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(top: 12),
            unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
            tabs: [
              ...skills.map(
                (skill) => Tab(
                  child: Text(
                    [
                      skill.skillType.string() != ""
                          ? "${skill.skillType.string()}.${fightProps.fixSkillLevel(skill.skillType, c.state.skillLevel(skill.skillType))}"
                              .toString()
                          : "",
                      skill.name.text(Lang.CHS),
                    ].where((s) => s != "").join(" "),
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  height: 24,
                ),
              ),
              ...c.character.inherentSkills.map(
                (e) => Text(
                  e.name.text(Lang.CHS),
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ...skills.map(
                  (skill) => ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    children: [
                      ViewSkillValues(
                        characterWithState: c,
                        skill: skill,
                        level: fightProps.fixSkillLevel(
                          skill.skillType,
                          c.state.skillLevel(skill.skillType),
                        ),
                        fightProps: fightProps.merge(FightProps({
                          FightProp.ENEMY_LEVEL: c.state.level.toDouble(),
                          FightProp.ENEMY_RESISTANCE: 0.1,
                        })),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: DefaultTextStyle.merge(
                          style: const TextStyle(fontSize: 12),
                          child: GSDesc(desc: skill.desc),
                        ),
                      )
                    ],
                  ),
                ),
                ...c.character.inherentSkills.map(
                  (e) => ListView(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    children: [
                      GSDesc(desc: e.desc),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CharacterWithState c) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: linearGradientForRarity(c.character.rarity),
      ),
      clipBehavior: Clip.hardEdge,
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: 0,
              child: Image(
                height: 160,
                image: GSImageProvider(
                  domain: "character",
                  nameID: c.character.nameID,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: BackButton(
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 160 + 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GSImageElement(
                            size: 28,
                            element: c.character.element,
                          ),
                          GSImageWeaponType(
                            size: 28,
                            weaponType: c.character.weaponType,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            c.character.name.text(Lang.CHS),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          c.character.desc.text(Lang.CHS),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              fullscreenDialog: false,
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  backgroundColor: bgs[c.character.rarity - 1]
                                      [1],
                                ),
                                body: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 24,
                                    ),
                                    itemCount:
                                        c.character.constellations.length,
                                    itemBuilder: (context, i) {
                                      var e = c.character.constellations[i];

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16,
                                            ),
                                            child: Row(
                                              children: [
                                                GSImageConstellation(
                                                  color: Theme.of(context)
                                                          .textTheme
                                                          .headline1
                                                          ?.color ??
                                                      Colors.black,
                                                  nameID: e.nameID,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  e.name.text(Lang.CHS),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline6,
                                                )
                                              ],
                                            ),
                                          ),
                                          GSDesc(desc: e.desc)
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                ...c.character.constellations.map(
                                  (e) => Opacity(
                                    opacity: (c.state.activeConstellationNum >=
                                            c.character.constellations
                                                    .indexOf(e) +
                                                1)
                                        ? 1
                                        : 0.3,
                                    child: GSImageConstellation(
                                      nameID: e.nameID,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ViewArtifactBuilder extends HookWidget {
  const ViewArtifactBuilder({
    Key? key,
    required this.uid,
    required this.c,
    required this.fightProps,
  }) : super(key: key);

  final int uid;
  final FightProps fightProps;
  final CharacterWithState c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModal(context, uid, c.character.id);
      },
      child: ViewBuildArtifactSetPair(
        fightProps: fightProps,
        artifacts: c.state.build.artifacts,
      ),
    );
  }

  void _showModal(BuildContext context, int uid, int cid) {
    var blocGameData = BlocGameData.read(context);
    var db = blocGameData.db;
    var builds = c.character.characterAllBuilds();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List<ViewBuildArtifactSetPair> artifactSets = [
          ...?c.state.defaultBuild?.let((build) {
            return [
              ViewBuildArtifactSetPair(
                fightProps: fightProps,
                artifacts: build.artifacts,
                backup: "当前配装",
              ),
            ];
          }),
          ...?builds.artifactSetPairs?.map(
            (artifactSetPair) => ViewBuildArtifactSetPair(
              fightProps: fightProps,
              artifacts: db.artifact.buildArtifactsBySetPair(
                artifactSetPair,
                builds,
                c.state.defaultBuild?.artifacts,
              ),
            ),
          ),
        ];

        return FractionallySizedBox(
          heightFactor: 0.7,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Tab(text: "当前配装"),
                    Tab(text: "其他套装"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CurrentArtifact(uid: uid, c: c),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...artifactSets.map(
                              (artifactSet) => ListTile(
                                selected: isArtifactsEqual(
                                  artifactSet.artifacts,
                                  c.state.build.artifacts,
                                ),
                                onTap: () {
                                  blocGameData.updateCharacterState(
                                    uid,
                                    c.state.id,
                                    (state) => c.state
                                        .withArtifacts(artifactSet.artifacts),
                                  );
                                  Navigator.of(context).pop();
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                title: ViewBuildArtifactSetPair(
                                  full: true,
                                  fightProps: fightProps,
                                  backup: artifactSet.backup,
                                  artifacts: artifactSet.artifacts,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CurrentArtifact extends StatelessWidget {
  const CurrentArtifact({
    Key? key,
    required this.uid,
    required this.c,
  }) : super(key: key);

  final CharacterWithState c;
  final int uid;

  @override
  Widget build(BuildContext context) {
    var blocArtifact = BlocArtifact.watch(context);
    var playerArtifactBuild = blocArtifact.playerArtifactBuild(uid);

    return SingleChildScrollView(
      child: Column(
        children: [
          ...EquipType.values.map((et) {
            var list = playerArtifactBuild
                .allArtifacts()
                .where((a) => a.equipType == et)
                .toList();

            var v = playerArtifactBuild.artifact(
              et,
              c.character.id,
            );

            return Select<PlayerArtifact>(
              options: list,
              value: v,
              onSelected: (selected) {
                blocArtifact.equip(
                  uid,
                  selected.copyWith(
                    usedBy: c.character.id,
                  ),
                  v,
                );
              },
              optionBuilder: (context, option, selected) {
                return PlayerArtifactListTile(
                  pa: option.value,
                  onAvatarTap: () {
                    option.select();
                  },
                );
              },
              tileBuilder: (context, selected) {
                return selected.value?.let((pa) => PlayerArtifactListTile(
                        pa: pa,
                        onAvatarTap: () {
                          selected.showOptions(context);
                        })) ??
                    ListTile(
                      onTap: () {
                        selected.showOptions(context);
                      },
                      title: Text("请选择${et.label()}"),
                    );
              },
            );
          })
        ],
      ),
    );
  }
}

isArtifactsEqual(Map<EquipType, PlayerArtifact> artifacts,
    Map<EquipType, PlayerArtifact> artifacts2) {
  return artifacts.values.map((e) => e.toString()).join("/") ==
      artifacts.values.map((e) => e.toString()).join("/");
}
