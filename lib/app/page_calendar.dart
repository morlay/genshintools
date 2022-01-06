import 'dart:ui';

import "package:collection/collection.dart";
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/view_daily_note.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/hook/hook.dart';
import 'package:rxdart/rxdart.dart';

import 'view_account.dart';
import 'view_levelup_plans.dart';
import 'view_material.dart';

class PageCalendar extends HookWidget {
  static String routeName = "/calender";

  const PageCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarWithAccount.buildScaffold(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ViewDailyNote(),
            Expanded(
              child: ViewCalendar(),
            )
          ],
        ));
  }
}

class ViewCalendar extends HookWidget {
  const ViewCalendar({Key? key}) : super(key: key);

  addToNeeds(
    Map<String, ViewMaterialNeeds> needs,
    GSImage avatar,
    List<LevelupPlan> levelupPlans,
  ) {
    var plan = levelupPlans.firstWhereOrNull((e) => e.always);

    if (plan != null) {
      for (var mc in plan.costs) {
        var mid = mc.key;

        needs[mid] = ViewMaterialNeeds(
          material: mc,
          needs: [
            ...?needs[mid]?.needs.toList(),
            ViewMaterialNeed(
              avatar: avatar,
              material: mc,
              action: plan.action,
              count: mc.count ?? 0,
              allPlans: levelupPlans,
            )
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = BlocAuth.watch(context).state.chosenUid();

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

    final gbb = BlocGameData.watch(context);
    final characters = gbb.listCharacterWithState(uid);

    Map<String, ViewMaterialNeeds> needs = {};

    characters.where((c) => c.todo).forEach((c) {
      var w = gbb.db.weapon.find(c.w.key);

      var wNameId = w.name.text(Lang.KEY);

      var aw = GSImage(
        domain: "weapon",
        rarity: w.rarity,
        nameID: wNameId,
      );

      addToNeeds(
        needs,
        aw,
        gbb.db.weaponLevelupPlans(wNameId, c.w.level),
      );

      var cNameId = c.character.name.text(Lang.KEY);

      var avatar = GSImage(
        domain: "character",
        rarity: c.character.rarity,
        nameID: cNameId,
      );

      addToNeeds(
        needs,
        avatar,
        gbb.db.characterLevelupPlans(cNameId, c.c.level),
      );

      var skillTypes =
          c.character.characterBuild?.skillPriority?.expand((e) => e) ??
              c.character.skills
                  .map((e) => e.skillType)
                  .where((skillType) => skillType != SkillType.OTHERS);

      for (var skillType in skillTypes) {
        addToNeeds(
          needs,
          avatar,
          gbb.db.characterSkillLevelupPlans(
            cNameId,
            skillType,
            c.c.skillLevel(skillType),
            c.c.level,
          ),
        );
      }
    });

    var list = needs.values.toList()..sort((a, b) => a.compareTo(b));

    var grouped = list.groupListsBy((e) => e.group());

    return DefaultTabController(
      length: grouped.keys.length,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
            tabs: grouped.keys.map((e) => Tab(text: e)).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: grouped.values.map((list) {
                var l =
                    list.groupListsBy((e) => e.material.dropBy).values.toList();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: l.length,
                  itemBuilder: (context, i) {
                    var item = l[i];

                    return ViewMaterialNeeds(
                      material: item[0].material,
                      materials: item.map((e) => e.material).toList(),
                      needs: item.expand((e) => e.needs).toList(),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewMaterialNeeds extends HookWidget {
  final GSMaterial material;
  final List<GSMaterial> materials;
  final List<ViewMaterialNeed> needs;

  const ViewMaterialNeeds({
    required this.material,
    required this.needs,
    this.materials = const [],
    Key? key,
  }) : super(key: key);

  String group() {
    if (material.dungeon != null) {
      return "秘境掉落";
    }

    if (material.materialType == GSMaterialType.AVATAR_MATERIAL) {
      if (material.dropFromRarity == GSMonsterRarity.BIG_BOSS_MONSTER) {
        return "周BOSS掉落";
      }

      if (material.dropFromRarity == GSMonsterRarity.BOSS_MONSTER) {
        return "野外BOSS掉落";
      }

      return "怪物掉落";
    }

    if (material.materialType == GSMaterialType.EXCHANGE) {
      return "野外采集";
    }

    return "其他";
  }

  int compareTo(ViewMaterialNeeds n) {
    return rank() < n.rank() ? -1 : 1;
  }

  rank() {
    return material.dungeon?.let((dungeon) {
          if (dungeon.isTodayOpen()) {
            return material.rank - 2e5;
          }
          if (dungeon.isTomorrowOpen()) {
            return material.rank - 1e5;
          }
          return null;
        }) ??
        1e5 - material.rank;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !(material.dungeon?.isTodayOpen() ?? true)
          ? !(material.dungeon?.isTomorrowOpen() ?? true)
              ? 0.4
              : 0.7
          : 1,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Wrap(
              spacing: 12,
              children: [
                ...(materials.isEmpty ? [material] : materials).map(
                  (m) => GestureDetector(
                    onTap: () {
                      ViewMaterial.showModal(context, m);
                    },
                    child: Wrap(
                      spacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        GSImage(
                          domain: "material",
                          size: 20,
                          rarity: m.rarity,
                          nameID: m.key,
                          rounded: true,
                        ),
                        Text(
                          m.name.text(Lang.CHS),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        subtitle: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...needs.groupListsBy((e) => e.avatar.nameID).values.map(
                    (groupedNeeds) => Wrap(runSpacing: 8, children: [
                      ...groupedNeeds.map((e) => FractionallySizedBox(
                            widthFactor: 0.5,
                            child: e,
                          ))
                    ]),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class ViewMaterialNeed extends HookWidget {
  final GSImage avatar;
  final GSMaterial material;
  final String action;
  final int count;
  final List<LevelupPlan> allPlans;

  const ViewMaterialNeed({
    required this.avatar,
    required this.action,
    required this.material,
    required this.count,
    required this.allPlans,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ViewLevelupPlans.showModal(context, avatar, allPlans);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GSImage(
            domain: avatar.domain,
            nameID: avatar.nameID,
            rarity: avatar.rarity,
            size: 32,
            rounded: true,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  action,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              MaterialWithCount(
                material: material,
                count: count,
              )
            ],
          ),
        ],
      ),
    );
  }
}
