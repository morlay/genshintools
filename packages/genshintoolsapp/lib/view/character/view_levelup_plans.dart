import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/gameui.dart';

class ViewLevelupPlans extends HookWidget {
  static showModal(
    BuildContext context,
    GSImage m,
    List<LevelupPlan> allPlans,
  ) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.none,
      builder: (BuildContext context) {
        return ViewLevelupPlans(
          avatar: m,
          allPlans: allPlans,
        );
      },
    );
  }

  final GSImage avatar;
  final List<LevelupPlan> allPlans;

  const ViewLevelupPlans({
    required this.avatar,
    required this.allPlans,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var a = GSImage(
      icon: avatar.icon,
      domain: avatar.domain,
      rarity: avatar.rarity,
      borderSize: 3,
      size: 72,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -a.size / 4,
          left: 16 - 3,
          child: a,
        ),
        Padding(
          padding: EdgeInsets.only(top: a.size / 4 * 3),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  ...allPlans.map((e) => ListTile(
                        leading: Text(
                          "→ ${e.action.split("→").last.trim()}",
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                        title: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              ...e.costs.map(
                                (material) => GestureDetector(
                                  onTap: () {
                                    ViewMaterial.showModal(context, material);
                                  },
                                  child: MaterialWithCount(
                                    material: material,
                                    count: material.count!,
                                  ),
                                ),
                              )
                            ],),
                      ),)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
