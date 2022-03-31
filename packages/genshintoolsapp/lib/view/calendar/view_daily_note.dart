import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/flutter/flutter.dart';
import 'package:rxdart/rxdart.dart';

class ViewDailyNote extends HookWidget {
  const ViewDailyNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = BlocAuth.watch(context).state.chosenUid();

    useObservableEffect(() {
      var authState = BlocAuth.read(context).state;

      if (authState.hasLogon()) {
        return Rx.fromCallable(
          () => authState.authedClient().dailyNote(uid),
        ).doOnData((dailyNote) {
          BlocDailyNote.read(context).syncDailyNote(uid, dailyNote);
        });
      }
    }, [uid]);

    var dailyNote = BlocDailyNote.watch(context).dailyNote(uid);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).focusColor,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runSpacing: 8,
        children: [
          Processing(
            label: const Text("洞天宝钱"),
            current: dailyNote.currentHomeCoin,
            max: dailyNote.maxHomeCoin,
          ),
          Processing(
            label: const Text("原萃树脂"),
            current: dailyNote.currentResin,
            max: dailyNote.maxResin,
          ),
          Processing(
            label: const Text("每日委托"),
            current: dailyNote.finishedTaskNum,
            max: dailyNote.totalTaskNum,
          ),
          Processing(
            label: const Text("派遣中"),
            current: dailyNote.currentExpeditionNum -
                dailyNote.expeditions
                    .where((element) => element.remainedTime == "0")
                    .length,
            max: dailyNote.maxExpeditionNum,
          ),
        ],
      ),
    );
  }
}

class Processing extends HookWidget {
  final Widget label;
  final int current;
  final int max;

  const Processing({
    required this.label,
    required this.current,
    required this.max,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTextStyle.merge(
          style: const TextStyle(fontSize: 11),
          child: Opacity(
            opacity: 0.7,
            child: label,
          ),
        ),
        DefaultTextStyle.merge(
          style: const TextStyle(
            fontSize: 18,
            height: 1.4,
            fontWeight: FontWeight.bold,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
          child: Text("$current / $max"),
        ),
      ],
    );
  }
}
