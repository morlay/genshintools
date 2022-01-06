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
import 'package:genshintools/genshindb/good/good.dart';
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
    var db = blocGameData.db;

    var current = blocGameData.findCharacterWithState(uid, "$id");
    var builds = current.character.characterAllBuilds();

    current = current.copyWith(
      artifacts: current.artifacts.length == 5
          ? current.artifacts
          : db.artifact
              .buildArtifactsBySetPair(
                builds.artifactSetPairs?[0] ?? ["角斗士的终幕礼"],
                builds,
              )
              .map((a) =>
                  current.artifacts
                      .firstWhereOrNull((e) => e.slotKey == a.slotKey) ??
                  a)
              .toList(),
    );

    var characterValueNotifier = useState(current.copyWith(
      c: current.c.copyWith(
        level: current.c.level > 0 ? current.c.level : 1,
      ),
    ));

    useEffect(() {
      characterValueNotifier.value = characterValueNotifier.value.copyWith(
        artifacts: current.artifacts,
      );
    }, [current.artifacts.map((e) => e.toString()).join("|")]);

    var c = characterValueNotifier.value;

    var fightProps = db.character
        .fightProps(
          id.toString(),
          c.c.level,
          c.c.constellation,
        )
        .merge(db.weapon.fightProps(
          c.w.key,
          c.w.level,
          c.w.refinement,
        ))
        .merge(db.artifact.fightProps(
          c.artifacts,
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
                              child: _buildBuild(
                                context,
                                db,
                                current,
                                characterValueNotifier,
                                fightProps,
                                builds,
                              ),
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
                      _buildSettings(context, characterValueNotifier),
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

  Widget _buildSettings(
    BuildContext context,
    ValueNotifier<CharacterWithState> cvn,
  ) {
    var s = cvn.value;

    Map<String, Slider> sliders = {
      "角色等级": Slider(
        value: s.c.level.toDouble(),
        min: 1,
        max: 90,
        divisions: 9,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            c: s.c.copyWith(
              level: value.toInt(),
            ),
          );
        },
      ),
      "角色命座": Slider(
        value: s.c.constellation.toDouble(),
        min: 0,
        max: 6,
        divisions: 6,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            c: s.c.copyWith(
              constellation: value.toInt(),
            ),
          );
        },
      ),
      "${SkillType.NORMAL_ATTACK.label()}等级": Slider(
        value: s.c.skillLevel(SkillType.NORMAL_ATTACK).toDouble(),
        min: 1,
        max: 10,
        divisions: 10,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            c: s.c.copyWith(
              talent: {
                ...s.c.talent,
                TalentType.auto: value.toInt(),
              },
            ),
          );
        },
      ),
      "${SkillType.ELEMENTAL_SKILL.label()}等级": Slider(
        value: s.c.skillLevel(SkillType.ELEMENTAL_SKILL).toDouble(),
        min: 1,
        max: 10,
        divisions: 10,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            c: s.c.copyWith(
              talent: {
                ...s.c.talent,
                TalentType.skill: value.toInt(),
              },
            ),
          );
        },
      ),
      "${SkillType.ELEMENTAL_BURST.label()}等级": Slider(
        value: s.c.skillLevel(SkillType.ELEMENTAL_BURST).toDouble(),
        min: 1,
        max: 10,
        divisions: 10,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            c: s.c.copyWith(
              talent: {
                ...s.c.talent,
                TalentType.burst: value.toInt(),
              },
            ),
          );
        },
      ),
      "武器等级": Slider(
        value: s.w.level.toDouble(),
        min: 1,
        max: 90,
        divisions: 9,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            w: s.w.copyWith(
              level: value.toInt(),
            ),
          );
        },
      ),
      "武器精炼": Slider(
        value: s.w.refinement.toDouble(),
        min: 1,
        max: 5,
        divisions: 5,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            w: s.w.copyWith(
              refinement: value.toInt(),
            ),
          );
        },
      ),
      "圣遗物等级": Slider(
        value: s.artifacts.getOrNull(0)?.level.toDouble() ?? 0,
        min: 0,
        max: 20,
        divisions: 5,
        onChanged: (double value) {
          cvn.value = s.copyWith(
            artifacts: [
              ...s.artifacts.map(
                (artifact) => artifact.copyWith(
                  level: value.toInt(),
                ),
              ),
            ],
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
    GSDB db,
    CharacterWithState current,
    ValueNotifier<CharacterWithState> state,
    FightProps fightProps,
    GSCharacterBuild builds,
  ) {
    var c = state.value;

    List<WeaponListTile> weapons = [
      WeaponListTile(
        fightProps: fightProps,
        weapon: db.weapon.find(current.w.key),
        level: c.w.level,
        refinement: c.w.refinement,
      ),
      ...?builds.weapons?.map((e) => WeaponListTile(
            fightProps: fightProps,
            weapon: db.weapon.find(e),
            level: c.w.level,
            refinement: 1,
          )),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            runSpacing: 8,
            children: [
              Select<WeaponListTile>(
                value: weapons.firstWhereOrNull((w) => w.weapon.key == c.w.key),
                onSelected: (w) {
                  state.value = c.copyWith(
                    w: c.w.copyWith(
                      key: w.weapon.key,
                    ),
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
              ViewArtifactBuilder(
                current: current,
                state: state,
                fightProps: fightProps,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ViewBuildArtifacts(
              current: current,
              builds: builds,
              state: state,
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
                          ? "${skill.skillType.string()}.${fightProps.fixSkillLevel(skill.skillType, c.c.skillLevel(skill.skillType))}"
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
                          c.c.skillLevel(skill.skillType),
                        ),
                        fightProps: fightProps.merge(FightProps({
                          FightProp.ENEMY_LEVEL: c.c.level.toDouble(),
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
                  nameID: c.character.key,
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
                                    opacity: (c.c.constellation >=
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
    required this.current,
    required this.state,
    required this.fightProps,
  }) : super(key: key);

  final CharacterWithState current;
  final ValueNotifier<CharacterWithState> state;
  final FightProps fightProps;

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.read(context).state.chosenUid();
    var c = state.value;

    return GestureDetector(
      onTap: () {
        _showModal(context, uid, state);
      },
      child: ViewBuildArtifactSetPair(
        fightProps: fightProps,
        artifacts: c.artifacts,
      ),
    );
  }

  void _showModal(
    BuildContext context,
    int uid,
    ValueNotifier<CharacterWithState> state,
  ) {
    var db = BlocGameData.read(context).db;
    var builds = current.character.characterAllBuilds();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List<ViewBuildArtifactSetPair> artifactSets = [
          ViewBuildArtifactSetPair(
            fightProps: fightProps,
            artifacts: current.artifacts,
            backup: "当前配装",
          ),
          ...?builds.artifactSetPairs?.map(
            (artifactSetPair) => ViewBuildArtifactSetPair(
              fightProps: fightProps,
              artifacts: db.artifact.buildArtifactsBySetPair(
                artifactSetPair,
                builds,
                current.artifacts,
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
                      CurrentArtifact(uid: uid, c: current),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...artifactSets.map(
                              (artifactSet) => ListTile(
                                selected: false,
                                onTap: () {
                                  state.value = state.value.copyWith(
                                    artifacts: artifactSet.artifacts,
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
    var blocGameData = BlocGameData.watch(context);
    var state = blocGameData.playerState(uid);
    var current = state.artifactsOn(c.character.key);

    return SingleChildScrollView(
      child: Column(
        children: [
          ...EquipType.values.map((et) {
            var list = state.artifacts
                .where((a) => a.slotKey.asEquipType() == et)
                .toList();

            var currentArtifact =
                current.firstWhereOrNull((a) => a.slotKey.asEquipType() == et);

            return Select<GOODArtifact>(
              options: list,
              value: currentArtifact,
              onSelected: (selected) {
                if (currentArtifact == null) {
                  blocGameData.equipArtifact(
                    uid,
                    selected.copyWith(
                      location: c.character.key,
                    ),
                  );
                } else {
                  blocGameData.equipArtifact(
                    uid,
                    selected,
                    currentArtifact,
                  );
                }
              },
              optionBuilder: (context, option, selected) {
                return GOODArtifactListTile(
                  artifact: option.value,
                  onAvatarTap: () {
                    option.select();
                  },
                );
              },
              tileBuilder: (context, selected) {
                return selected.value?.let((pa) => GOODArtifactListTile(
                        artifact: pa,
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

isArtifactsEqual(
  Map<EquipType, PlayerArtifact> artifacts,
  Map<EquipType, PlayerArtifact> artifacts2,
) {
  return artifacts.values.map((e) => e.toString()).join("/") ==
      artifacts.values.map((e) => e.toString()).join("/");
}
