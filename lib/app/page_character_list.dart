import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/view_account.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';
import 'package:genshintools/hook/hook.dart';
import 'package:rxdart/rxdart.dart';

import 'page_character.dart';

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

    var characters = BlocGameData.read(context).listCharacterWithState(uid);
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
        leading: SizedBox(
          child: WithLevel(
            level: c.c.level,
            child: WithCount(
              prefix: "C",
              count: c.c.constellation,
              child: WithElement(
                element: c.character.element,
                child: GSImage(
                  domain: "character",
                  rarity: c.character.rarity,
                  nameID: c.character.key,
                ),
              ),
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            children: [
              Text(
                c.character.name.text(Lang.CHS),
              ),
              const Expanded(child: Text("")),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Wrap(
                      spacing: 8,
                      children: [
                        ...c.c.talent.keys.map(
                          (key) => Text.rich(TextSpan(
                            children: [
                              TextSpan(
                                text: "${key.asSkillType().string()}.",
                                style: TextStyle(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "${c.c.talent[key]}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 4,
              alignment: WrapAlignment.end,
              children: [
                WithLevel(
                  level: c.w.level,
                  size: 9,
                  child: WithCount(
                    prefix: "R",
                    count: c.w.refinement,
                    size: 10,
                    child: GSImage(
                      size: 32,
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
                          size: 9,
                          child: GSImage(
                            size: 32,
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
            )
          ],
        ),
        onTap: () {
          PageCharacter.show(context, c.character.id);
        },
      ),
    );
  }
}
