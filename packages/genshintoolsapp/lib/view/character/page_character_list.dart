import 'package:collection/collection.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/account.dart';
import 'package:genshintoolsapp/view/gameui.dart';

import 'character_card.dart';

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
            ));
      }
    }, [uid]);

    var characters = BlocGameData.watch(context).listCharacterWithState(uid);
    Map<dynamic, List<CharacterWithState>> grouped =
        characters.groupListsBy((e) => e.character.element);
    grouped["TODO"] = characters.where((c) => c.todo).toList();

    var elements = ElementType.values.where((e) => e != ElementType.Physical);

    return AppBarWithAccount.buildScaffold(
      context,
      DefaultTabController(
        length: elements.length + 1,
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("All Stars",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
                ...elements.map(
                  (e) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  ...[
                    "TODO",
                    ...elements,
                  ].map((element) {
                    var l = grouped[element]?.toList() ?? [];
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 4,
                        runSpacing: 16,
                        children: [...l.map((c) => CharacterCard(c: c))],
                      ),
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
