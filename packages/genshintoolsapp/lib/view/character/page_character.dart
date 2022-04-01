import 'package:collection/collection.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/flutter/flutter.dart';
import 'package:genshintoolsapp/flutter/ui.dart';
import 'package:genshintoolsapp/view/artifact.dart';
import 'package:genshintoolsapp/view/gameui.dart';
import 'package:url_launcher/url_launcher.dart';

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

    var builds = current.character.characterBuildFor(current.c.role);

    current = current.copyWith(
      buffs: [],
      c: current.c.own
          ? current.c
          : current.c.copyWith(
              level: 90,
              talent: {
                TalentType.auto: 9,
                TalentType.skill: 9,
                TalentType.burst: 9,
              },
              constellation: current.character.rarity == 4 ? 6 : 0),
      w: current.c.own
          ? current.w
          : current.w.copyWith(
              level: 90,
              key: db.weapon.findOrNull(builds.weapons?.first ?? "")?.key ??
                  current.w.key,
            ),
      artifacts: current.artifacts.length == 5
          ? current.artifacts
          : current.graduatedArtifacts(db.artifact, defaultArtifacts: [
              ...db.artifact
                  .buildArtifactsBySetPair(
                    builds.artifactSetPairs?[0] ?? ["角斗士的终幕礼"],
                    builds,
                  )
                  .map((a) =>
                      current.artifacts
                          .firstWhereOrNull((e) => e.slotKey == a.slotKey) ??
                      a)
                  .map((a) => a.copyWith(level: 20))
            ]),
    );

    var characterValueNotifier = useState(current);

    useEffect(() {
      characterValueNotifier.value = characterValueNotifier.value.copyWith(
        artifacts: current.artifacts,
      );
    }, [current.artifacts.map((e) => e.toString()).join("|")]);

    useEffect(() {
      characterValueNotifier.value = characterValueNotifier.value.copyWith(
          c: characterValueNotifier.value.c.copyWith(
        role: current.c.role,
      ));
    }, [current.c.role]);

    var c = characterValueNotifier.value;

    var fightProps = c.computeFightProps(db);

    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context, c),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: _buildBuild(
                                context,
                                db,
                                uid,
                                current,
                                characterValueNotifier,
                                fightProps,
                                builds,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: SingleChildScrollView(
                                child: _buildDashboard(
                                  context,
                                  fightProps,
                                  builds,
                                ),
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
双暴词条练度评分采用 [18+6 算法](https://ngabbs.com/read.php?tid=29797262);
配装参考数据来自 [Genshin Impact Helper Team](https://heystacks.org/doc/743/genshin-impact-general-character-strats)
""",
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
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
                      child: Center(child: Text("展开配置")),
                    ),
                  ),
                  expanded: Column(
                    children: [
                      ExpandableButton(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text("收起配置")),
                        ),
                      ),
                      _buildSettings(context, uid, characterValueNotifier)
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
    int uid,
    ValueNotifier<CharacterWithState> cvn,
  ) {
    var buffs = BlocGameData.read(context).allBuffs(uid);

    var s = cvn.value;

    Map<String, Widget> sliders = {
      "全局 buff": GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 2,
        ),
        children: [
          ...buffs.map(
            (e) => GestureDetector(
              onTap: () {
                if (s.hasBuff(e)) {
                  cvn.value = s.copyWith(
                    buffs:
                        (s.buffs ?? []).where((m) => m.name != e.name).toList(),
                  );
                } else {
                  cvn.value = s.copyWith(
                    buffs: [...?s.buffs, e],
                  );
                }
              },
              child: Card(
                color: s.hasBuff(e) ? Theme.of(context).focusColor : null,
                child: Center(
                  child: Text(e.name ?? ""),
                ),
              ),
            ),
          )
        ],
      ),
      "角色等级": Slider(
        value: s.c.level.toDouble(),
        min: 1,
        max: 90,
        divisions: 18,
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
      child: SizedBox(
        height: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Expanded(
              child: TabBarView(
                children: [
                  ...sliders.values.map((e) => Center(child: e)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuild(
    BuildContext context,
    GSDB db,
    int uid,
    CharacterWithState current,
    ValueNotifier<CharacterWithState> state,
    FightProps fightProps,
    GSCharacterBuild builds,
  ) {
    var c = state.value;
    var roles = c.character.characterBuilds?.keys.toList() ?? [];

    List<WeaponListTile> weapons = [
      WeaponListTile(
        fightProps: fightProps,
        weapon: db.weapon.find(current.w.key),
        level: c.w.level,
        refinement: c.w.refinement,
        backup: "当前配装",
      ),
      ...?builds.weapons?.map((e) => WeaponListTile(
            fightProps: fightProps,
            weapon: db.weapon.find(e),
            level: c.w.level,
            refinement: c.w.refinement,
          )),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            runSpacing: 8,
            spacing: 8,
            alignment: WrapAlignment.center,
            children: [
              Select<String>(
                title: const Text("角色定位切换"),
                options: c.character.characterBuilds?.keys.toList() ?? [],
                value: c.c.role,
                onSelected: (role) {
                  BlocGameData.read(context).updateCharacter(
                    uid,
                    c.c.key,
                    (c) => c.copyWith(
                      role: role,
                    ),
                  );
                },
                tileBuilder: (ctx, s) {
                  return GestureDetector(
                    onTap: () {
                      if (roles.length > 1) {
                        s.showOptions(ctx);
                      }
                    },
                    child: Text(
                      builds.role ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                optionBuilder: (
                  BuildContext context,
                  SelectOption<dynamic> item,
                  Selected<dynamic> selected,
                ) {
                  return ListTile(
                    title: Text(item.value),
                    selected: c.c.role == item.value,
                    trailing: c
                        .character.characterBuilds?[item.value]?.recommended
                        ?.ifTrueOrNull(() => const Text("推荐")),
                    onTap: () {
                      item.select();
                    },
                  );
                },
                builder: (context, children) {
                  return SingleChildScrollView(
                    child: Wrap(
                      children: children,
                    ),
                  );
                },
              ),
              Select<WeaponListTile>(
                title: const Text("武器"),
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
              fightProps: fightProps,
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
    var skillPriority =
        c.character.characterBuildFor(c.c.role).skillPriority ?? [];

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
                        fightProps: fightProps,
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
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => (SingleChildScrollView(
                              child: SafeArea(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Column(children: [
                                    ...c.character.constellations.map((e) {
                                      return ListTile(
                                        leading: GSImageConstellation(
                                          color: Theme.of(context)
                                                  .textTheme
                                                  .headline1
                                                  ?.color ??
                                              Colors.black,
                                          nameID: e.nameID,
                                          size: 36,
                                        ),
                                        title: Text(e.name.text(Lang.CHS)),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: GSDesc(desc: e.desc),
                                        ),
                                      );
                                    })
                                  ]),
                                ),
                              ),
                            )),
                          );
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 8,
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
                            ],
                          ),
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
