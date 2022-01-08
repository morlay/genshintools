import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/page_artifact_list.dart';
import 'package:genshintools/app/page_calendar.dart';
import 'package:genshintools/app/page_character_list.dart';
import 'package:genshintools/app/page_gacha.dart';
import 'package:genshintools/hook/hook.dart';
import 'package:genshintools/syncer/syncer.dart';
import 'package:genshintools/upgrader/upgrader.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class AppMain extends HookWidget {
  AppMain({Key? key}) : super(key: key);

  final List<Topic> _topics = <Topic>[
    Topic(
      icon: const Icon(Icons.event_outlined),
      label: '今日',
      widget: const PageCalendar(),
    ),
    Topic(
      icon: const Icon(Icons.catching_pokemon),
      label: '角色',
      widget: const PageCharacterList(),
    ),
    Topic(
      icon: const Icon(Icons.build),
      label: '圣遗物',
      widget: const PageArtifactList(),
    ),
    Topic(
      icon: const Icon(Icons.gamepad),
      label: '抽卡',
      widget: const PageGacha(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _selectedIndex = useState(0);

    useEffect(() {
      Upgrader.checkVersion(context);
    }, []);

    useObservableEffect(() {
      return Stream.periodic(const Duration(minutes: 5)).doOnData((v) {
        WebDAVSyncer.read(context).sync();
      });
    }, []);

    return Provider<BottomNavigationBar>.value(
      value: BottomNavigationBar(
        currentIndex: _selectedIndex.value,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _selectedIndex.value = index,
        items: [
          ..._topics.map(
            (e) => BottomNavigationBarItem(
              icon: e.icon,
              label: e.label,
            ),
          ),
        ],
      ),
      child: _topics.elementAt(_selectedIndex.value).widget,
    );
  }
}

class Topic {
  Icon icon;
  String label;
  Widget widget;

  Topic({
    required this.icon,
    required this.label,
    required this.widget,
  });
}
