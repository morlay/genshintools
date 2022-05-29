import 'package:collection/collection.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/artifact.dart';
import 'package:genshintoolsapp/view/gameui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'view_build.dart';
import 'view_fight_props.dart';
import 'view_skill.dart';

class PageCharacter extends HookWidget {
  static String routeName = '/character';

  static void show(BuildContext context, int id) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        settings: RouteSettings(name: PageCharacter.routeName),
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

    var current = blocGameData.findCharacterWithState(uid, '$id');

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
              constellation: current.character.rarity == 4 ? 6 : 0,
            ),
      w: current.c.own
          ? current.w
          : current.w.copyWith(
              level: 90,
              key: db.weapon
                      .findOrNull(builds.weapons?.first.getOrNull(0) ?? '')
                      ?.key ??
                  current.w.key,
            ),
      artifacts: current.artifacts.length == 5
          ? current.artifacts
          : current.graduatedArtifacts(
              db.artifact,
              defaultArtifacts: [
                ...db.artifact
                    .buildArtifactsBySetPair(
                      builds.artifactSetPairs?[0] ?? ['角斗士的终幕礼'],
                      builds,
                    )
                    .map(
                      (a) =>
                          current.artifacts.firstWhereOrNull(
                              (e) => e.slotKey == a.slotKey) ??
                          a,
                    )
                    .map((a) => a.copyWith(level: 20))
              ],
            ),
    );

    var characterValueNotifier = useState(current);

    useEffect(
      () {
        characterValueNotifier.value = characterValueNotifier.value.copyWith(
          artifacts: current.artifacts,
        );
        return null;
      },
      [current.artifacts.map((e) => e.toString()).join('|')],
    );

    useEffect(
      () {
        characterValueNotifier.value = characterValueNotifier.value.copyWith(
          c: characterValueNotifier.value.c.copyWith(
            role: current.c.role,
          ),
        );
        return null;
      },
      [current.c.role],
    );

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
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildRole(context, c, uid, builds),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: _buildBuild(
                                context,
                                state: characterValueNotifier,
                                db: db,
                                uid: uid,
                                current: current,
                                fightProps: fightProps,
                                builds: builds,
                              ),
                            ),
                            SizedBox(
                              width: 56,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SingleChildScrollView(
                                      child: _buildDashboard(
                                        context,
                                        fightProps,
                                        builds,
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox.square(
                                    child: _buildAppendProps(
                                      context,
                                      state: characterValueNotifier,
                                      db: db,
                                      current: current,
                                      fightProps: fightProps,
                                      builds: builds,
                                    ),
                                  )
                                ],
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
                            href?.let((h) => launchUrl(Uri.parse(h)));
                          },
                          styleSheet: Theme.of(context).let(
                            (theme) =>
                                MarkdownStyleSheet.fromTheme(theme).copyWith(
                              p: theme.textTheme.bodyText2?.copyWith(
                                fontSize: 8,
                              ),
                            ),
                          ),
                          data: '''
双暴词条练度评分采用 [18+6 算法](https://ngabbs.com/read.php?tid=29797262);
配装参考数据来自 [Genshin Impact Helper Team](https://heystacks.org/doc/743/genshin-impact-general-character-strats)
''',
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildSkills(context, c, fightProps),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
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
                      child: Center(child: Text('展开配置')),
                    ),
                  ),
                  expanded: Column(
                    children: [
                      ExpandableButton(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Center(child: Text('收起配置')),
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

  Widget _buildAppendProps(
    BuildContext context, {
    required ValueNotifier<CharacterWithState> state,
    required CharacterWithState current,
    required GSDB db,
    required FightProps fightProps,
    required GSCharacterBuild builds,
  }) {
    var as = db.artifact;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: current.artifacts.last.substats.isNotEmpty
          ? [
              AppendPropsRank(
                ranks: current.appendPropsRanks(
                  as,
                  builds,
                  fightProps,
                  location: current.character.key,
                  chargeEfficiencyAsDPS: current.chargeEfficiencyAsDPS(as),
                  asDetails: true,
                ),
              ),
              InkWell(
                onTap: () {
                  if (state.value.artifacts.last.substats.isEmpty) {
                    state.value = state.value.copyWith(
                      artifacts: current.artifacts,
                    );
                  } else {
                    state.value = state.value.copyWith(
                      artifacts: current.graduatedArtifacts(as),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      state.value.artifacts.last.substats.isEmpty
                          ? '返回当前配装'
                          : '查看毕业词条',
                      style: const TextStyle(fontSize: 8),
                    ),
                  ),
                ),
              ),
            ]
          : [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Center(
                  child: Text(
                    '当前面板包含 18+6 词条',
                    style: TextStyle(fontSize: 8),
                  ),
                ),
              ),
            ],
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    FightProps fightProps,
    GSCharacterBuild? builds,
  ) {
    return ViewFightProps(
      asDashboard: true,
      fightProps: fightProps,
      shouldHighlight: (FightProp fp) => [
        ...?builds?.artifactMainPropTypes?.values.expand((e) => e),
        ...?builds?.artifactAffixPropTypes,
      ].contains(fp),
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
      '全局 buff': GridView(
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
                  child: Text(e.name ?? ''),
                ),
              ),
            ),
          )
        ],
      ),
      '角色等级': Slider(
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
      '角色命座': Slider(
        value: s.c.constellation.toDouble(),
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
      '${SkillType.NORMAL_ATTACK.label()}等级': Slider(
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
      '${SkillType.ELEMENTAL_SKILL.label()}等级': Slider(
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
      '${SkillType.ELEMENTAL_BURST.label()}等级': Slider(
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
      '武器等级': Slider(
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
      '武器精炼': Slider(
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
      '圣遗物等级': Slider(
        value: s.artifacts.getOrNull(0)?.level.toDouble() ?? 0,
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
                    height: 24,
                    child: Text(key, style: const TextStyle(fontSize: 11)),
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

  Widget _buildEquipWeapon(
    BuildContext context, {
    required ValueNotifier<CharacterWithState> state,
    required CharacterWithState current,
    required GSDB db,
    required FightProps fightProps,
    required GSCharacterBuild builds,
  }) {
    var c = state.value;

    List<WeaponCard> weapons = [
      WeaponCard(
        fightProps: fightProps,
        weapon: db.weapon.find(current.w.key),
        level: c.w.level,
        refinement: c.w.refinement,
        builds: builds,
        backup: '当前配装',
      ),
      ...?builds.weapons?.let(
        (weapons) => weapons.expandIndexed(
          (i, list) => list.map(
            (e) => WeaponCard(
              fightProps: fightProps,
              weapon: db.weapon.find(e),
              level: c.w.level,
              builds: builds,
              refinement: c.w.refinement,
              backup: '契合度 ${weapons.length - i + (10 - weapons.length)}',
            ),
          ),
        ),
      ),
    ];

    return Select<WeaponCard>(
      title: const Text('武器'),
      value: weapons.firstWhereOrNull((w) => w.weapon.key == c.w.key),
      onSelected: (w) {
        state.value = c.copyWith(
          w: c.w.copyWith(
            key: w.weapon.key,
          ),
        );
      },
      options: weapons,
      builder: (BuildContext context, List<Widget> children) {
        return FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: children,
                  )
                ],
              ),
            ),
          ),
        );
      },
      optionBuilder: (context, item, selected) {
        return InkWell(
          onTap: () {
            item.select();
          },
          child: item.value,
        );
      },
      tileBuilder: (context, selected) {
        return InkWell(
          child: selected.value ?? const Text(''),
          onTap: () {
            selected.showOptions(context);
          },
        );
      },
    );
  }

  Widget _buildEquipArtifact(
    BuildContext context,
    GOODArtifact artifact, {
    required ValueNotifier<CharacterWithState> state,
    required CharacterWithState current,
    required int uid,
    required GSDB db,
    required FightProps fightProps,
    required GSCharacterBuild builds,
  }) {
    var blocGameData = BlocGameData.watch(context);
    var playerState = blocGameData.playerState(uid);
    var list = playerState.artifacts
        .where((a) => a.slotKey == artifact.slotKey)
        .toList();

    return Select<GOODArtifact>(
      title: const Text('圣遗物'),
      options: list,
      value: artifact,
      onSelected: (selected) {
        blocGameData.equipArtifact(
          uid,
          selected,
          artifact,
        );
      },
      builder: (c, list) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [...list],
            ),
          ),
        );
      },
      optionBuilder: (context, option, selected) {
        return GOODArtifactCard(
          artifact: option.value,
          onAvatarTap: () {
            option.select();
          },
        );
      },
      tileBuilder: (context, selected) {
        return selected.value!.let(
          (pa) => GOODArtifactCard(
            artifact: pa,
            onAvatarTap: () {
              selected.showOptions(context);
            },
            noHead: true,
            noDelete: true,
            mainProps: _buildMainProps(
              context,
              artifact,
              builds: builds,
              state: state,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainProps(
    BuildContext context,
    GOODArtifact currentArtifact, {
    required ValueNotifier<CharacterWithState> state,
    required GSCharacterBuild builds,
  }) {
    var dataState = BlocGameData.read(context);
    var db = dataState.db;
    var artifact = state.value.artifacts
        .firstWhereOrNull((a) => a.slotKey == currentArtifact.slotKey);

    return SizedBox(
      width: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Wrap(
          runSpacing: 2,
          children: [
            ...{
              ...?builds.artifactMainPropTypes?[
                  currentArtifact.slotKey.asEquipType()],
              currentArtifact.mainStatKey.asFightProp(),
            }.map(
              (fp) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: (fp == artifact?.mainStatKey.asFightProp())
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    state.value = state.value.copyWith(
                      artifacts: [
                        ...state.value.artifacts.map(
                          (artifact) =>
                              artifact.slotKey == currentArtifact.slotKey
                                  ? artifact.copyWith(
                                      mainStatKey:
                                          GOODArtifact.statKeyFromFightProp(fp),
                                    )
                                  : artifact,
                        )
                      ],
                    );
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    child: FightPropView(
                      fightProp: fp,
                      value: db.artifact.mainFightProp(
                        fp,
                        currentArtifact.rarity,
                        artifact?.level ?? currentArtifact.level,
                      ),
                      highlight: builds.artifactMainPropTypes?[
                                  currentArtifact.slotKey.asEquipType()]
                              ?.contains(fp) ??
                          false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuild(
    BuildContext context, {
    required ValueNotifier<CharacterWithState> state,
    required CharacterWithState current,
    required GSDB db,
    required int uid,
    required FightProps fightProps,
    required GSCharacterBuild builds,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _buildEquipWeapon(
                  context,
                  state: state,
                  db: db,
                  current: current,
                  fightProps: fightProps,
                  builds: builds,
                ),
                Divider(),
                _buildEquipArtifactPair(
                  context,
                  current: current,
                  fightProps: fightProps,
                  state: state,
                ),
                ...state.value.artifacts.map((artifact) => _buildEquipArtifact(
                      context,
                      artifact,
                      state: state,
                      db: db,
                      uid: uid,
                      current: current,
                      fightProps: fightProps,
                      builds: builds,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEquipArtifactPair(
    BuildContext context, {
    required CharacterWithState current,
    required ValueNotifier<CharacterWithState> state,
    required FightProps fightProps,
  }) {
    return ViewArtifactBuilder(
      fightProps: fightProps,
      state: state,
      current: current,
    );
  }

  Widget _buildRole(
    BuildContext context,
    CharacterWithState c,
    int uid,
    GSCharacterBuild builds,
  ) {
    var roles = c.character.characterBuilds?.keys.toList() ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Select<String>(
        title: const Text('角色定位切换'),
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
          return InkWell(
            onTap: () {
              if (roles.length > 1) {
                s.showOptions(ctx);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                builds.role ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
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
            trailing: c.character.characterBuilds?[item.value]?.recommended
                ?.ifTrueOrNull(() => const Text('推荐')),
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

    var skills = [...c.character.skills]..sort(
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
                  height: 24,
                  child: Text(
                    [
                      if (skill.skillType.string() != '')
                        '${skill.skillType.string()}.${fightProps.fixSkillLevel(skill.skillType, c.c.skillLevel(skill.skillType))}'
                            .toString()
                      else
                        '',
                      skill.name.text(Lang.CHS),
                    ].where((s) => s != '').join(' '),
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
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
                  domain: 'character',
                  icon: c.character.icon,
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
                    left: 18,
                    right: 160 + 18,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SingleChildScrollView(
                              child: SafeArea(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children: [
                                      ...c.character.constellations.map((e) {
                                        return ListTile(
                                          leading: GSImageConstellation(
                                            color: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.color ??
                                                Colors.black,
                                            icon: e.icon,
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                                    icon: e.icon,
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
