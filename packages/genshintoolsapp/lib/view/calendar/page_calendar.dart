import "package:collection/collection.dart";
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/account.dart';
import 'package:genshintoolsapp/view/character.dart';
import 'package:genshintoolsapp/view/gameui.dart';
import 'package:rxdart/rxdart.dart';

import 'view_daily_note.dart';

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

      var skillTypes = c.character
              .characterBuildFor(c.c.role)
              .skillPriority
              ?.expand((e) => e) ??
          c.character.skills
              .map((e) => e.skillType)
              .where((skillType) => skillType != SkillType.OTHERS);

      for (var skillType in skillTypes) {
        addToNeeds(
          needs,
          avatar,
          gbb.db.characterSkillLevelupPlans(
              cNameId, skillType, c.c.skillLevel(skillType), c.c.level,
              maxLevel: c.character
                  .characterBuildFor(c.c.role)
                  .emBuild()
                  .ifTrueOrNull(() => 6)),
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

                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    ...ListTile.divideTiles(context: context, tiles: [
                      ...l.map((item) => ViewMaterialNeeds(
                            material: item[0].material,
                            materials: item.map((e) => e.material).toList(),
                            needs: item.expand((e) => e.needs).toList(),
                          ))
                    ])
                  ],
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
    if (material.openWeekdays != null) {
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
    return material.openWeekdays?.let((it) {
          if (material.isTodayOpen()) {
            return material.rank - 2e5;
          }
          if (material.isTomorrowOpen()) {
            return material.rank - 1e5;
          }
          return null;
        }) ??
        1e5 - material.rank;
  }

  @override
  Widget build(BuildContext context) {
    var list = needs
        .groupListsBy((e) => e.avatar.nameID)
        .values
        .expand(
          (groupedNeeds) => groupedNeeds,
        )
        .toList();

    return Opacity(
      opacity: !(material.isTodayOpen())
          ? !(material.isTomorrowOpen())
              ? 0.4
              : 0.7
          : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ...(materials.isEmpty ? [material] : materials)
                    .mapIndexed(
                      (i, m) => [
                        ...?(i > 0).ifTrueOrNull(() => [
                              const SizedBox(
                                height: 10,
                                child: VerticalDivider(
                                  width: 1,
                                ),
                              )
                            ]),
                        GestureDetector(
                          onTap: () {
                            ViewMaterial.showModal(context, m);
                          },
                          child: Text(
                            m.name.text(Lang.CHS),
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    )
                    .expand((e) => e)
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: list,
              ),
            )
          ],
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
    var from = action.split("→").first;
    var to = action.split("→").last;

    return GestureDetector(
      onTap: () {
        ViewLevelupPlans.showModal(context, avatar, allPlans);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 12, top: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            MaterialWithCount(
              material: material,
              count: count,
            ),
            Positioned(
              left: -9,
              top: -9,
              child: GSImage(
                domain: avatar.domain,
                nameID: avatar.nameID,
                rarity: avatar.rarity,
                size: 18,
                borderSize: 2,
                rounded: true,
              ),
            ),
            Positioned(
              right: 0,
              top: -11,
              child: Text(
                to,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ),
            Positioned(
              left: -11,
              bottom: 0,
              child: Opacity(
                opacity: 0.6,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    from,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      fontFeatures: [FontFeature.tabularFigures()],
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
}
