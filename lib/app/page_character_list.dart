import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/view_account.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';
import 'package:genshintools/hook/hook.dart';
import 'package:rxdart/rxdart.dart';

import 'page_character.dart';
import 'view_build.dart';
import 'view_material.dart';

class PageCharacterList extends HookWidget {
  static String routeName = "/characters";

  const PageCharacterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();

    useObservableEffect(() {
      final blocAuth = BlocAuth.read(context);

      if (blocAuth.state.hasLogon()) {
        return Rx.fromCallable(() => BlocGameData.read(context).syncGameInfo(
              blocAuth.state.authedClient(),
              blocAuth.state.chosenUid(),
              BlocArtifact.read(context)
                  .playerArtifactBuild(uid)
                  .allArtifacts(),
            ));
      }
    }, [uid]);

    var characters = BlocGameData.watch(context).listCharacterWithState(uid);
    var grouped = characters.groupListsBy((e) => e.character.element);
    var elements = ElementType.values.where((e) => e != ElementType.Physical);

    return AppBarWithAccount.buildScaffold(
      context,
      DefaultTabController(
        length: elements.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              padding: const EdgeInsets.all(0),
              indicatorPadding: const EdgeInsets.all(0),
              labelPadding: const EdgeInsets.all(0),
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                ...elements.map(
                  (e) => Container(
                    decoration: BoxDecoration(
                      color: elementColor(e).withOpacity(0.05),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: GSImageElement(
                      element: e,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ...elements.map((element) {
                    var l = grouped[element]?.toList() ?? [];

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: l.length,
                      itemBuilder: (content, i) {
                        var c = l[i];

                        return CharacterListTile(c: c);
                      },
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

class CharacterListTile extends HookWidget {
  const CharacterListTile({
    Key? key,
    required this.c,
  }) : super(key: key);

  final CharacterWithState c;

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;

    return Opacity(
      opacity: c.c.own ? 1.0 : 0.6,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAvatar(context),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.character.name.text(Lang.CHS)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                child: _buildTalentLevels(context),
                              ),
                              Text(
                                c.c.role ?? "",
                                style: const TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ...?c.todo.ifTrueOrNull(() => [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: 56,
                                child: AppendPropsRank(
                                  ranks: c.appendPropsRanks(
                                    db.artifact,
                                    c.character
                                        .characterBuildFor(c.c.role ?? ""),
                                    db.character
                                        .fightProps(
                                          c.c.key,
                                          c.c.level,
                                          c.c.constellation,
                                        )
                                        .merge(db.weapon.fightProps(
                                          c.w.key,
                                          c.w.level,
                                          c.w.refinement,
                                        )),
                                  ),
                                ),
                              ),
                            )
                          ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: _buildAllMaterialCosts(context, db),
                  ),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 100,
              ),
              child: _buildBuild(context, db),
            ),
          ],
        ),
        onTap: () {
          PageCharacter.show(context, c.character.id);
        },
      ),
    );
  }

  Widget _buildAllMaterialCosts(BuildContext context, GSDB db) {
    return Wrap(
      runSpacing: 2,
      spacing: 2,
      children: [
        _buildMaterialCosts(
          context,
          Text("人物等级 Lv.${c.c.level} → Lv.90"),
          db.characterLevelupPlans(
            c.character.key,
            c.c.level,
          ),
        ),
        _buildMaterialCosts(
          context,
          const Text("有效技能等级 → Lv.9"),
          [
            ...[
              SkillType.NORMAL_ATTACK,
              SkillType.ELEMENTAL_SKILL,
              SkillType.ELEMENTAL_BURST,
            ].expand((st) =>
                c.character.characterBuildFor(c.c.role).shouldSkillLevelup(st)
                    ? db.characterSkillLevelupPlans(
                        c.character.key,
                        st,
                        c.c.skillLevel(st),
                        c.c.level,
                      )
                    : [])
          ],
        ),
        ...?db.weapon
            .findOrNull(c.w.key)
            ?.rarity
            .let((rarity) => (rarity >= 3).ifTrueOrNull(() => [
                  _buildMaterialCosts(
                    context,
                    Text("武器等级 Lv.${c.w.level} → Lv.90"),
                    db.weaponLevelupPlans(
                      c.w.key,
                      c.w.level,
                    ),
                  )
                ])),
        _buildMaterialCosts(
          context,
          const Text("圣遗物等级 → Lv.20"),
          [
            ...c.artifacts.expand(
              (a) => db.artifactLevelupPlans(
                a.rarity,
                a.level,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return WithLevel(
      level: c.c.level,
      child: WithCount(
        prefix: "C",
        count: c.c.constellation,
        child: WithElement(
          element: c.character.element,
          child: GSImage(
            domain: "character",
            size: 48,
            rarity: c.character.rarity,
            nameID: c.character.key,
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialCosts(
    BuildContext context,
    Widget label,
    List<LevelupPlan> levelPlans,
  ) {
    Map<String, GSMaterial> materials = {};

    for (var p in levelPlans) {
      for (var c in p.costs) {
        materials[c.key] = materials[c.key]?.let((cc) => cc.copyWith(
                count: ((cc.count ?? 1) + (c.count ?? 1)).toInt())) ??
            c;
      }
    }

    var groupedMaterials = materials.values
        .groupListsBy((e) => "${e.materialType}${e.dropBy}")
        .values;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: label,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          ...groupedMaterials.expand(
                            (list) => list.map(
                              (m) => ListTile(
                                onTap: () {
                                  ViewMaterial.showModal(context, m);
                                },
                                leading: GSImage(
                                  size: 42,
                                  domain: "material",
                                  rarity: m.rarity,
                                  nameID: m.key,
                                ),
                                title: Text(m.name.text(Lang.CHS)),
                                trailing: Text(
                                  "${m.count ?? 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Opacity(
        opacity: 0.7,
        child: Wrap(
          runSpacing: 2,
          spacing: 2,
          children: [
            ...groupedMaterials.expand(
              (list) => list.map(
                (m) => WithCount(
                  count: m.count ?? 1,
                  alignment: Alignment.bottomRight,
                  size: 6,
                  child: GSImage(
                    size: 24,
                    domain: "material",
                    rarity: m.rarity,
                    nameID: m.key,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBuild(BuildContext context, GSDB db) {
    return Wrap(
      alignment: WrapAlignment.end,
      spacing: 2,
      runSpacing: 2,
      children: [
        WithLevel(
          level: c.w.level,
          size: 8,
          child: WithCount(
            prefix: "R",
            count: c.w.refinement,
            size: 7,
            child: GSImage(
              size: 28,
              domain: "weapon",
              rarity: db.weapon.find(c.w.key).rarity,
              nameID: db.weapon.find(c.w.key).key,
            ),
          ),
        ),
        ...(c.todo
            ? c.artifacts.map(
                (a) => WithLevel(
                  level: a.level,
                  size: 8,
                  child: GSImage(
                    size: 28,
                    domain: "artifact",
                    rarity: a.rarity,
                    nameID: db.artifact
                        .findSet(a.setKey)
                        .artifact(a.slotKey.asEquipType())
                        .key,
                  ),
                ),
              )
            : []),
      ],
    );
  }

  Widget _buildTalentLevels(BuildContext context) {
    var builds = c.character.characterBuildFor(c.c.role);

    return Wrap(
      spacing: 0,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ...?builds.skillPriority
            ?.mapIndexed(
              (i, keys) => keys.mapIndexed((j, key) => Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "${j > 0 ? " ~= " : (i > 0 ? " > " : "")}${key.string()}.",
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: "${c.c.talent[TalentType.values[key.index]]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      )
                    ],
                  ))),
            )
            .expand((k) => k)
      ],
    );
  }
}
