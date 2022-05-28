import 'package:collection/collection.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/gameui.dart';

import 'page_character.dart';
import 'view_build.dart';

class CharacterCard extends HookWidget {
  const CharacterCard({
    Key? key,
    required this.c,
  }) : super(key: key);

  final CharacterWithState c;

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;

    // print(c.character.name);

    return InkWell(
      onTap: () {
        PageCharacter.show(context, c.character.id);
      },
      child: Opacity(
        opacity: c.c.own ? 1.0 : 0.6,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    c.c.role ?? '',
                    style: const TextStyle(fontSize: 7),
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 0,
                child: _buildAvatar(context),
              ),
              Positioned(
                left: 30,
                top: 58 - 20,
                child: _buildMaterialCosts(
                  context,
                  Text('人物等级 Lv.${c.c.level} → Lv.90'),
                  db.characterLevelupPlans(
                    c.character.key,
                    c.c.level,
                  ),
                  const SizedBox(
                    width: 58,
                    height: 20,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: _buildMaterialCosts(
                  context,
                  Text('武器等级 Lv.${c.w.level} → Lv.90'),
                  db.weapon
                          .findOrNull(c.w.key)
                          ?.rarity
                          .let((rarity) => (rarity >= 3).ifTrueOrNull(() => db
                              .weaponLevelupPlans(
                                c.w.key,
                                c.w.level,
                              )
                              .toList(),),) ??
                      [],
                  _buildWeapon(context, db),
                ),
              ),
              Positioned(
                left: 30,
                top: -11,
                child: Text(
                  c.character.name.text(Lang.CHS),
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 30 * 4,
                  height: 30 * 2,
                  child: _buildMaterialCosts(
                    context,
                    const Text('所有圣遗物等级 → Lv.20'),
                    c.artifacts
                        .expand(
                          (a) => db.artifactLevelupPlans(
                            a.rarity,
                            a.level,
                          ),
                        )
                        .toList(),
                    _buildArtifacts(context, db),
                    detector: ({onTap, child}) => GestureDetector(
                      onTap: onTap,
                      child: child,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: -11,
                child: c.todo.ifTrueOrNull(() =>
                        SizedBox(width: 120, child: _buildArtifactScope(db)),) ??
                    const SizedBox(width: 0),
              ),
              Positioned(
                right: 0,
                bottom: 32,
                child: _buildMaterialCosts(
                  context,
                  const Text('有效技能等级 → Lv.10'),
                  [
                    SkillType.NORMAL_ATTACK,
                    SkillType.ELEMENTAL_SKILL,
                    SkillType.ELEMENTAL_BURST,
                  ].expand<LevelupPlan>((st) {
                    var b = c.character.characterBuildFor(c.c.role);
                    return b.shouldSkillLevelup(st)
                        ? db.characterSkillLevelupPlans(
                            c.character.key, st, c.c.skillLevel(st), c.c.level,
                            maxLevel: b.emBuild().ifTrueOrNull(() => 6) ?? 10,)
                        : [];
                  }).toList(),
                  SizedBox(
                    width: 28,
                    height: 32,
                    child: _buildTalentLevels(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArtifactScope(GSDB db) {
    return SizedBox(
      child: AppendPropsRank(
        inline: true,
        ranks: c.appendPropsRanks(
          db.artifact,
          c.character.characterBuildFor(c.c.role ?? ''),
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
              ),),
          location: c.character.key,
          chargeEfficiencyAsDPS: c.artifacts
                  .where((a) => a.setKey == db.artifact.findSet('绝缘之旗印').key)
                  .length >=
              4,
        ),
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return WithLevel(
      level: c.c.level,
      child: WithCount(
        prefix: 'C',
        count: c.c.constellation,
        child: WithElement(
          element: c.character.element,
          child: GSImage(
            domain: 'character',
            size: 58,
            rarity: c.character.rarity,
            nameID: c.character.key,
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialCosts(BuildContext context, Widget label,
      List<LevelupPlan> levelPlans, Widget child,
      {Widget Function({void Function()? onTap, Widget? child})? detector,}) {
    if (levelPlans.isEmpty) {
      return child;
    }

    Map<String, GSMaterial> materials = {};

    for (final p in levelPlans) {
      for (final c in p.costs) {
        materials[c.key] = materials[c.key]?.let((cc) => cc.copyWith(
                count: ((cc.count ?? 1) + (c.count ?? 1)).toInt(),),) ??
            c;
      }
    }

    var groupedMaterials = materials.values
        .groupListsBy((e) => "${e.materialType}${e.dropBy}")
        .values;

    detector ??= ({void Function()? onTap, Widget? child}) => InkWell(
          onTap: onTap,
          child: child,
        );

    return detector(
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
                                  domain: 'material',
                                  rarity: m.rarity,
                                  nameID: m.key,
                                ),
                                title: Text(m.name.text(Lang.CHS)),
                                trailing: Text(
                                  '${m.count ?? 1}',
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
      child: child,
    );
  }

  Widget _buildWeapon(BuildContext context, GSDB db) {
    return WithLevel(
      level: c.w.level,
      size: 7,
      child: WithCount(
        prefix: 'R',
        count: c.w.refinement,
        size: 7,
        child: GSImage(
          size: 28,
          domain: 'weapon',
          rarity: db.weapon.find(c.w.key).rarity,
          nameID: db.weapon.find(c.w.key).key,
        ),
      ),
    );
  }

  Widget _buildArtifacts(BuildContext context, GSDB db) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: [
        ...c.todo
            ? c.artifacts.expandIndexed((i, a) => [
                  WithLevel(
                    level: a.level,
                    size: 7,
                    child: GSImage(
                      size: 28,
                      domain: 'artifact',
                      rarity: a.rarity,
                      nameID: db.artifact
                          .findSet(a.setKey)
                          .artifact(a.slotKey.asEquipType())
                          .key,
                    ),
                  ),
                  ...?(i == 0).ifTrueOrNull(() => [
                        const SizedBox(
                          width: 28,
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                        const SizedBox(
                          width: 28,
                        ),
                      ],),
                ],)
            : [],
      ],
    );
  }

  Widget _buildTalentLevels(BuildContext context) {
    var builds = c.character.characterBuildFor(c.c.role);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...?builds.skillPriority
            ?.mapIndexed(
              (i, keys) => keys.mapIndexed((j, key) => Stack(
                    children: [
                      Positioned(
                        child: Text(
                          '${key.string()}.',
                          style: TextStyle(
                            color: Theme.of(context).hintColor,
                            fontSize: 8,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            '${c.c.talent[TalentType.values[key.index]]}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                            ),
                          ),)
                    ],
                  ),),
            )
            .expand((k) => k)
      ],
    );
  }
}
