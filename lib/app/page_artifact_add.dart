import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/app/gamedata/bloc_game_data.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/ui/select.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';

class PageArtifactAdd extends HookWidget {
  static void show(BuildContext context, EquipType equipType,
      [GOODArtifact? value]) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
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
          (GOODArtifact.create(SlotKey.values[equipType.index], "")
              .copyWith(setKey: as.findSet("${defaultArtifact.setId}").key)),
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
        title: Text(value != null ? "修改圣遗物" : "录入圣遗物"),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child:
                      Text("副词条", style: Theme.of(context).textTheme.subtitle1),
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
                                  .isEmpty)
                          .map(
                            (fp) => buildAppendPropSelect(
                              artifact,
                              artifactAppendDepot,
                              fp,
                              pa,
                            ),
                          ),
                    ])
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
                          .valueIndexes(ss.key.asFightProp(), ss.stringValue())
                          .length),
            );

    var valueIndexes = artifactAppendDepot.canValues(fp);
    var values = valueIndexes.keys
        .where((k) => valueIndexes[k]!.length <= remainCount)
        .toList();

    return Select<String>(
      options: values,
      value: artifact.substats
              .firstWhereOrNull((ss) => ss.key.asFightProp() == fp)
              ?.stringValue() ??
          "",
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Text(fp.label(),
                  style: Theme.of(context).textTheme.subtitle1),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                children: children,
              ),
            )
          ],
        );
      },
      optionBuilder: (context, option, selected) {
        return ListTile(
          onTap: () {
            option.select();
          },
          selected: option.value == selected.value,
          selectedTileColor: Theme.of(context).focusColor,
          title: Row(
            children: [
              buildAppendValue(artifactAppendDepot, fp, option.value),
            ],
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
                Text(fp.label()),
                ...?selected.value?.let(
                  (v) => (v != "").ifTrueOrNull(() => [
                        buildAppendValue(artifactAppendDepot, fp, v),
                      ]),
                )
              ],
            ));
      },
    );
  }

  Widget buildAppendValue(
      GSArtifactAppendDepot artifactAppendDepot, FightProp fp, String v) {
    var indexes = artifactAppendDepot.valueIndexes(fp, v);

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
              true,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: -6,
          child: AppendValueIndex(
            indexes: indexes,
          ),
        )
      ],
    );
  }

  Select<FightProp> buildMainPropSelect(ValueNotifier<GOODArtifact> pa,
      GOODArtifact artifact, List<FightProp> mainProps) {
    return Select<FightProp>(
      options: mainProps,
      value: artifact.mainStatKey.asFightProp(),
      onSelected: (selected) {
        pa.value = artifact.copyWith(
          mainStatKey: GOODArtifact.statKeyFromFightProp(selected),
        );
      },
      builder: (context, children) {
        return Wrap(
          children: children,
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
                  )) ??
              const Text("请选择"),
          title: const Text("主词条"),
        );
      },
    );
  }

  Select<int> buildLevelSelect(
    GOODArtifact artifact,
    ValueNotifier<GOODArtifact> pa,
  ) {
    return Select<int>(
      options: const [0, 4, 8, 12, 16, 20],
      value: artifact.level,
      onSelected: (selected) {
        pa.value = artifact.copyWith(level: selected);
      },
      builder: (context, children) {
        return Wrap(
          children: children,
        );
      },
      optionBuilder: (context, option, selected) {
        return ListTile(
          onTap: () {
            option.select();
          },
          selected: option.value == selected.value,
          selectedTileColor: Theme.of(context).focusColor,
          title: Text("+${option.value}"),
        );
      },
      tileBuilder: (context, selected) {
        return ListTile(
          trailing: const Icon(
            Icons.chevron_right,
          ),
          onTap: () => selected.showOptions(context),
          subtitle: selected.value?.let((lvl) => Text(
                    "+$lvl",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )) ??
              const Text("请选择"),
          title: const Text("等级"),
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
      options: artifacts,
      value: artifacts.firstWhereOrNull(
          (v) => db.artifact.findSet("${v.setId}").key == artifact.setKey),
      onSelected: (selected) {
        pa.value = artifact.copyWith(
            setKey: db.artifact.findSet("${selected.setId}").key);
      },
      builder: (context, children) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Wrap(
            spacing: 12,
            runSpacing: 2,
            children: children,
          ),
        );
      },
      optionBuilder: (context, option, selected) {
        return ChoiceChip(
          onSelected: (b) {
            option.select();
          },
          selected: option.value == selected.value,
          label: Text(option.value.name.text(Lang.CHS)),
          avatar: GSImage(
            domain: "artifact",
            rarity: 5,
            rounded: true,
            size: 36,
            nameID: option.value.key,
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
                  )) ??
              const Text("请选择"),
          title: const Text("圣遗物"),
          leading: selected.value?.let(
            (s) => GSImage(
              domain: "artifact",
              rarity: 5,
              size: 42,
              nameID: s.key,
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
  }) : super(key: key);

  final List<int> indexes;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...indexes.map(
          (i) => Padding(
            padding: const EdgeInsets.only(right: 1),
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: linearGradientForRarity(i + 2).colors[0],
              ),
            ),
          ),
        )
      ],
    );
  }
}
