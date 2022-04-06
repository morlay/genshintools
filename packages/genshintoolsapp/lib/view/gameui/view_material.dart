import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/common/flutter.dart';

import 'image.dart';
import 'text.dart';

class ViewMaterial extends HookWidget {
  static showModal(BuildContext context, GSMaterial m) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.none,
      builder: (BuildContext context) {
        return ViewMaterial(
          material: m,
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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -a.size / 4,
          left: 16,
          child: a,
        ),
        Positioned(
          top: 0,
          right: 16,
          left: 16 * 2 + a.size.toDouble(),
          height: a.size - a.size / 4 + 4,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              material.name.text(Lang.CHS),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: a.size / 4 * 3),
          child: SingleChildScrollView(
            child: SafeArea(
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
                            spacing: 8,
                            runSpacing: 8,
                            children: [
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
                              spacing: 8,
                              runSpacing: 8,
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
        ),
      ],
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
    return WithCount(
      alignment: Alignment.bottomRight,
      count: count,
      size: 10,
      child: GSImage(
        domain: "material",
        size: 36,
        rarity: material.rarity,
        nameID: material.key,
      ),
    );
  }
}
