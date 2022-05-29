import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/artifact.dart';
import 'package:genshintoolsapp/view/gameui.dart';


class WeaponCard extends HookWidget {
  final GSWeapon weapon;
  final int refinement;
  final FightProps fightProps;
  final int level;
  final GSCharacterBuild? builds;
  final String? backup;

  const WeaponCard({
    required this.weapon,
    required this.fightProps,
    required this.refinement,
    required this.level,
    required this.builds,
    this.backup,
    Key? key,
  }) : super(key: key);

  final double _width = 48;

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;

    var mainFightProps =
        db.weapon.fightPropsForMain(weapon.key, level, refinement);

    return EquipCard(
      name: weapon.name.text(Lang.CHS),
      avatar: _buildAvatar(),
      title: backup?.let((txt) => SizedBox(
            width: _width,
            child: Text(
              txt,
              style: TextStyle(fontSize: 7),
            ),
          )),
      info: SizedBox(
        width: _width,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => SingleChildScrollView(
                child: SafeArea(
                  child: _buildInfo(context),
                ),
              ),
            );
          },
          child: Wrap(
            runSpacing: 4,
            children: [
              ...mainFightProps.keys.expand(
                (fp) =>
                    mainFightProps[fp]?.let((v) => v > 0
                        ? [
                            FightPropView(
                              fightProp: fp,
                              value: v,
                              calcValue: fightProps.calcValue,
                              highlight: [
                                ...?builds?.artifactMainPropTypes?.values
                                    .expand((e) => e),
                                ...?builds?.artifactAffixPropTypes,
                              ].contains(fp),
                            )
                          ]
                        : []) ??
                    [],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WithLevel(
          level: level,
          child: WithCount(
            prefix: 'R',
            count: refinement,
            active: refinement >= 5,
            child: GSImage(
              size: _width.toInt(),
              domain: 'weapon',
              rarity: weapon.rarity,
              icon: weapon.icon,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            weapon.name.text(Lang.CHS),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Wrap(
            runSpacing: 4,
            children: [
              ...weapon.weaponAffixes(refinement).expand(
                    (e) => [
                      SelectableText(
                        e.name.text(Lang.CHS),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).hintColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      GSDesc(
                        desc: e.desc,
                      )
                    ],
                  ),
            ],
          ),
        )
      ],
    );
  }
}

class AppendPropsRank extends StatelessWidget {
  const AppendPropsRank({
    Key? key,
    required this.ranks,
    this.inline,
  }) : super(key: key);

  final Map<String, Rank> ranks;
  final bool? inline;

  @override
  Widget build(BuildContext context) {
    if (inline ?? false) {
      return DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ranks.keys.map((k) => k.replaceAll('双暴词条', '双暴')).join(' / '),
            ),
            Wrap(
              spacing: 3,
              children: [
                ...ranks.keys.map(
                  (key) => Text(
                    ranks[key]!.value.toStringAsFixed(1),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: linearGradientForRarity(
                        ranks[key]!.rarity,
                      ).colors.first,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Wrap(
      runSpacing: 6,
      children: [
        ...ranks.keys.map(
          (key) => DefaultTextStyle.merge(
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            child: Opacity(
              opacity: ranks[key]!.used ? 1 : 0.6,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: DefaultTextStyle.merge(
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.normal,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(key, style: const TextStyle(fontSize: 6)),
                          Text(
                            ranks[key]!.value.toStringAsFixed(1),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: linearGradientForRarity(
                                ranks[key]!.rarity,
                              ).colors.first,
                              fontFeatures: const [
                                FontFeature.tabularFigures()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppendValueIndex(
                        indexes: ranks[key]!.indexes,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
