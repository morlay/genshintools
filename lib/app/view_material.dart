import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

class ViewMaterial extends HookWidget {
  static showModal(BuildContext context, GSMaterial m) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.none,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: ViewMaterial(
            material: m,
          ),
        );
      },
    );
  }

  final GSMaterial material;

  const ViewMaterial({
    required this.material,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;

    var a = GSImage(
      domain: "material",
      nameID: material.key,
      rarity: material.rarity,
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
          Positioned(
            top: 0,
            right: 16,
            left: 16 * 2 + a.size.toDouble(),
            height: a.size - a.size / 3 + 8,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                material.name.text(Lang.CHS),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: a.size / 3 * 2),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  children: [
                    GSDesc(desc: material.desc),
                    Align(
                        widthFactor: double.infinity,
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Wrap(
                            spacing: 4,
                            runSpacing: -8,
                            children: [
                              ...?material.dungeon?.let((d) => [
                                    Chip(
                                      label: Text(
                                        d.name.text(Lang.CHS),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ]),
                              ...?material.sources?.map(
                                (e) => Chip(
                                  label: Text(
                                    e.text(Lang.CHS),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    ...?material.dropFromTags?.let((dropFromTags) => [
                          Align(
                            widthFactor: double.infinity,
                            alignment: Alignment.topLeft,
                            child: Wrap(
                              spacing: 4,
                              runSpacing: -8,
                              children: [
                                ...db.enemy
                                    .listByDropTags(material.dropFromTags ?? [])
                                    .map(
                                      (e) => Chip(
                                        avatar: GSImage(
                                          domain: "enemy",
                                          nameID: e.key,
                                          rounded: true,
                                        ),
                                        label: Text(
                                          e.name.text(Lang.CHS),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    )
                              ],
                            ),
                          )
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialWithCount extends HookWidget {
  final GSMaterial material;
  final int count;

  const MaterialWithCount({
    required this.material,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: GSImage(
        domain: "material",
        size: 36,
        rarity: material.rarity,
        nameID: material.key,
        rounded: true,
      ),
      label: Text("× ${count > 1e4 ? "${count ~/ 1e4}w" : count}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFeatures: [FontFeature.tabularFigures()],
          )),
    );
  }
}
