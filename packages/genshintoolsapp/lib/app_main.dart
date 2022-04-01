import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/syncer.dart';
import 'package:genshintoolsapp/flutter/flutter.dart';
import 'package:genshintoolsapp/upgrader/upgrader.dart';
import 'package:genshintoolsapp/view/artifact.dart';
import 'package:genshintoolsapp/view/calendar.dart';
import 'package:genshintoolsapp/view/character.dart';
import 'package:genshintoolsapp/view/gacha.dart';
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

    useUpgrader(context, BlocAuth.read(context).state.currentChannel);

    useObservableEffect(() {
      return Stream.periodic(const Duration(minutes: 1)).doOnData((v) {
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
