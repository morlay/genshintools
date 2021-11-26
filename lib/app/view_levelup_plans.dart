import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/view_material.dart';
import 'package:genshintools/genshindb/genshindb.dart';

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
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: ViewLevelupPlans(
            avatar: m,
            allPlans: allPlans,
          ),
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
      nameID: avatar.nameID,
      domain: avatar.domain,
      rarity: avatar.rarity,
      borderSize: 3,
      size: 72,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -a.size / 3,
            left: 16,
            child: a,
          ),
          Padding(
            padding: EdgeInsets.only(top: a.size / 5 * 4),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...allPlans.map((e) => ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(e.action,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFeatures: [FontFeature.tabularFigures()],
                              )),
                        ),
                        subtitle: Stack(
                          children: [
                            Wrap(
                                spacing: 4,
                                runSpacing: -8,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...e.costs
                                      .map((material) => MaterialWithCount(
                                            material: material,
                                            count: material.count!,
                                          ))
                                ])
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
