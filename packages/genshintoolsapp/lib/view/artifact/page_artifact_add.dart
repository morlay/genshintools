import 'package:collection/collection.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/gameui.dart';

class PageArtifactAdd extends HookWidget {
  static void show(BuildContext context, EquipType equipType,
      [GOODArtifact? value,]) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) =>
            PageArtifactAdd(equipType: equipType, value: value),
      ),
    );
  }

  final EquipType equipType;
  final GOODArtifact? value;

  const PageArtifactAdd({
    Key? key,
    this.equipType = EquipType.SHOES,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var blocGameData = BlocGameData.read(context);
    var db = blocGameData.db;
    var as = blocGameData.db.artifact;

    var artifacts = useMemoized(
      () => as.artifacts!.values
          .where(
            (a) =>
                a.rarity == 5 &&
                a.appendPropNum == 4 &&
                a.equipType == equipType,
          )
          .toList(),
      [equipType],
    );

    var defaultArtifact = artifacts.toList()[0];

    var pa = useState(
      value ??
          (GOODArtifact.create(SlotKey.values[equipType.index], '')
              .copyWith(setKey: defaultArtifact.setKey)),
    );

    var a =
        blocGameData.db.artifact.findSet(pa.value.setKey).artifact(equipType);

    var mainProps = useMemoized(
      () => as.mainCanFightProps(a.key),
      [pa.value.setKey],
    );

    var artifactAppendDepot = useMemoized(
      () => as.artifactAppendDepot(a.key),
      [pa.value.setKey],
    );

    var artifact = pa.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(value != null ? '修改圣遗物' : '录入圣遗物'),
        actions: [
          IconButton(
            onPressed: () {
              blocGameData.equipArtifact(uid, artifact, value);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildArtifactSelect(artifacts, db, artifact, pa),
            buildLevelSelect(artifact, pa),
            buildMainPropSelect(pa, artifact, mainProps),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(height: 1),
                const ListTile(
                  title: Text(
                    '副词条',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                ...artifact.substats.map(
                  (ss) => buildAppendPropSelect(
                    artifact,
                    artifactAppendDepot,
                    ss.key.asFightProp(),
                    pa,
                  ),
                ),
                ...?(artifact.substats.length < 4).ifTrueOrNull(() => [
                      const Divider(),
                      ...artifactAppendDepot.keys
                          .where((fp) =>
                              fp != artifact.mainStatKey.asFightProp() &&
                              artifact.substats
                                  .where((ss) => ss.key.asFightProp() == fp)
                                  .isEmpty,)
                          .map(
                            (fp) => buildAppendPropSelect(
                              artifact,
                              artifactAppendDepot,
                              fp,
                              pa,
                            ),
                          ),
                    ],)
              ],
            )
          ],
        ),
      ),
    );
  }

  Select<String> buildAppendPropSelect(
    GOODArtifact artifact,
    GSArtifactAppendDepot artifactAppendDepot,
    FightProp fp,
    ValueNotifier<GOODArtifact> pa,
  ) {
    var remainCount =
        artifact.substats.where((ss) => ss.key.asFightProp() != fp).fold<int>(
              4 + 5,
              (r, ss) =>
                  r -
                  (ss.value == 0
                      ? 1
                      : artifactAppendDepot
                          .valueNs(ss.key.asFightProp(), ss.stringValue())
                          .length),
            );

    var valueIndexes = artifactAppendDepot.canValues(fp);

    var values = valueIndexes.keys
        .where((k) => valueIndexes[k]!.length <= remainCount)
        .toList()
      ..sort((a, b) => artifactAppendDepot
          .calc(fp, valueIndexes[a])
          .compareTo(artifactAppendDepot.calc(fp, valueIndexes[b])),);

    return Select<String>(
      title: Text(fp.label()),
      options: values,
      value: artifact.substats
              .firstWhereOrNull((ss) => ss.key.asFightProp() == fp)
              ?.stringValue() ??
          '',
      onSelected: (selected) {
        var next = GOODSubStat(key: GOODArtifact.statKeyFromFightProp(fp))
            .withStringValue(selected);

        pa.value = artifact.copyWith(
          substats: [
            ...artifact.substats.map((ss) => ss.key == next.key ? next : ss),
            ...?artifact.substats
                .where((ss) => ss.key == next.key)
                .isEmpty
                .ifTrueOrNull(() => [next])
          ],
        );
      },
      builder: (context, children) {
        return GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 1.6,
          ),
          children: children,
        );
      },
      optionBuilder: (context, option, selected) {
        return Card(
          color: (option.value.split('?').first == selected.value)
              .ifTrueOrNull(() => Theme.of(context).focusColor),
          child: InkWell(
            onTap: () {
              option.select();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: DefaultTextStyle.merge(
                  style: Theme.of(context).textTheme.subtitle1,
                  child:
                      buildAppendValue(artifactAppendDepot, fp, option.value),
                ),
              ),
            ),
          ),
        );
      },
      tileBuilder: (context, selected) {
        return ListTile(
            trailing: const Icon(
              Icons.chevron_right,
            ),
            onTap: () => selected.showOptions(context),
            leading: artifact.substats
                .firstWhereOrNull((ss) => ss.key.asFightProp() == fp)
                ?.let(
                  (v) => IconButton(
                    onPressed: () {
                      pa.value = artifact.copyWith(
                        substats: [
                          ...artifact.substats
                              .where((ss) => ss.key.asFightProp() != fp)
                        ],
                      );
                    },
                    icon: const Icon(Icons.clear, size: 16),
                  ),
                ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selected.title,
                ...?selected.value?.let(
                  (v) => (v != '').ifTrueOrNull(() => [
                        buildAppendValue(artifactAppendDepot, fp, v),
                      ],),
                )
              ],
            ),);
      },
    );
  }

  Widget buildAppendValue(
      GSArtifactAppendDepot artifactAppendDepot, FightProp fp, String v,) {
    var indexes = artifactAppendDepot.valueNs(fp, v);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          child: Text(
            GSArtifactAppendDepot.format(
              artifactAppendDepot.calc(
                fp,
                indexes,
              ),
              percent: true,
            ),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          left: 0,
          bottom: -6,
          child: SizedBox(
            width: 56,
            child: AppendValueIndex(
              indexes: indexes,
            ),
          ),
        )
      ],
    );
  }

  Select<FightProp> buildMainPropSelect(ValueNotifier<GOODArtifact> pa,
      GOODArtifact artifact, List<FightProp> mainProps,) {
    return Select<FightProp>(
      title: const Text('主词条'),
      options: mainProps,
      value: artifact.mainStatKey.asFightProp(),
      onSelected: (selected) {
        pa.value = artifact.copyWith(
          mainStatKey: GOODArtifact.statKeyFromFightProp(selected),
        );
      },
      builder: (context, children) {
        return SingleChildScrollView(
          child: Wrap(
            children: children,
          ),
        );
      },
      optionBuilder: (context, option, selected) {
        return ListTile(
          onTap: () {
            option.select();
          },
          selected: option.value == selected.value,
          selectedTileColor: Theme.of(context).focusColor,
          title: Text(option.value.label()),
        );
      },
      tileBuilder: (context, selected) {
        return ListTile(
          trailing: const Icon(
            Icons.chevron_right,
          ),
          onTap: () => selected.showOptions(context),
          subtitle: selected.value?.let((fp) => Text(
                    fp.label(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),) ??
              const Text('请选择'),
          title: selected.title,
        );
      },
    );
  }

  Select<int> buildLevelSelect(
    GOODArtifact artifact,
    ValueNotifier<GOODArtifact> pa,
  ) {
    return Select<int>(
      title: const Text('等级'),
      options: const [0, 4, 8, 12, 16, 20],
      value: artifact.level,
      onSelected: (selected) {
        pa.value = artifact.copyWith(level: selected);
      },
      builder: (context, children) {
        return SingleChildScrollView(
          child: Wrap(
            children: children,
          ),
        );
      },
      optionBuilder: (context, option, selected) {
        return ListTile(
          onTap: () {
            option.select();
          },
          selected: option.value == selected.value,
          selectedTileColor: Theme.of(context).focusColor,
          title: Text('+${option.value}'),
        );
      },
      tileBuilder: (context, selected) {
        return ListTile(
          trailing: const Icon(
            Icons.chevron_right,
          ),
          onTap: () => selected.showOptions(context),
          subtitle: selected.value?.let((lvl) => Text(
                    '+$lvl',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),) ??
              const Text('请选择'),
          title: selected.title,
        );
      },
    );
  }

  Select<GSArtifact> buildArtifactSelect(
    List<GSArtifact> artifacts,
    GSDB db,
    GOODArtifact artifact,
    ValueNotifier<GOODArtifact> pa,
  ) {
    return Select<GSArtifact>(
      title: const Text('圣遗物'),
      options: artifacts,
      value: artifacts.firstWhereOrNull((v) => v.setKey == artifact.setKey),
      onSelected: (selected) {
        pa.value = artifact.copyWith(setKey: selected.setKey);
      },
      builder: (context, children) {
        return GridView(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 110,
            childAspectRatio: 0.8,
          ),
          children: children,
        );
      },
      optionBuilder: (context, option, selected) {
        return Center(
          child: Card(
            color: (option.value == selected.value)
                .ifTrueOrNull(() => Theme.of(context).focusColor),
            child: InkWell(
              onTap: () {
                option.select();
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: WithLabel(
                  label: Text(option.value.name.text(Lang.CHS)),
                  child: GSImage(
                    domain: 'artifact',
                    rarity: 5,
                    size: 64,
                    icon: option.value.icon,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      tileBuilder: (context, selected) {
        return ListTile(
          trailing: const Icon(
            Icons.chevron_right,
          ),
          onTap: () => selected.showOptions(context),
          subtitle: selected.value?.let((it) => Text(
                    it.name.text(Lang.CHS),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),) ??
              const Text('请选择'),
          title: selected.title,
          leading: selected.value?.let(
            (s) => GSImage(
              domain: 'artifact',
              rarity: 5,
              size: 42,
              icon: s.icon,
            ),
          ),
        );
      },
    );
  }
}

class AppendValueIndex extends HookWidget {
  const AppendValueIndex({
    Key? key,
    required this.indexes,
    this.size,
    this.reverse,
  }) : super(key: key);

  final List<int> indexes;
  final bool? reverse;
  final double? size;

  @override
  Widget build(BuildContext context) {
    if (indexes.isEmpty) {
      return Row(
        
      );
    }

    double s = size ?? 4;

    return Wrap(
      runSpacing: 1,
      spacing: 1,
      alignment: reverse?.let((it) => WrapAlignment.end) ?? WrapAlignment.start,
      children: [
        ...indexes.map(
          (n) => Container(
            width: s,
            height: s,
            decoration: BoxDecoration(
              color: n > 0
                  ? linearGradientForRarity((n < 0 ? -n : n) + 1).colors[0]
                  : null,
              border: n < 0
                  ? Border.all(
                      width: 1.5,
                      color: linearGradientForRarity((n < 0 ? -n : n) + 1)
                          .colors[0],
                    )
                  : null,
            ),
          ),
        )
      ],
    );
  }
}
