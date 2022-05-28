import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/common/flutter.dart';

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
            current: Text("${dailyNote.currentHomeCoin}"),
            max: Text("${dailyNote.maxHomeCoin}"),
          ),
          Processing(
            label: const Text("原萃树脂"),
            current: Text("${dailyNote.currentResin}"),
            max: Text("${dailyNote.maxResin}"),
          ),
          Processing(
            label: const Text("每日委托"),
            current: Text("${dailyNote.finishedTaskNum}"),
            max: Text("${dailyNote.totalTaskNum}"),
          ),
          Processing(
            label: const Text("派遣中"),
            current: Text(
                "${dailyNote.currentExpeditionNum - dailyNote.expeditions.where((element) => element.remainedTime == "0").length}"),
            max: Text("${dailyNote.maxExpeditionNum}"),
          ),
          Processing(
            label: const Text("参量质变仪 CD"),
            current: Text(dailyNote.transformer.cd().toString().split(".")[0]),
          ),
        ],
      ),
    );
  }
}

class Processing extends HookWidget {
  final Widget label;
  final Widget current;
  final Widget? max;

  const Processing({
    required this.label,
    required this.current,
    this.max,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 96),
      child: Column(
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
            child: Wrap(
              children: [
                current,
                ...max?.let((m) => [
                          Text(" / "),
                          m,
                        ]) ??
                    [],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
