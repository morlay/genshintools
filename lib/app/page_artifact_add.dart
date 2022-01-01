import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/auth/auth.dart';
import 'package:genshintools/app/gamedata/bloc_artifact.dart';
import 'package:genshintools/app/gamedata/bloc_game_data.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/app/ui/select.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

class PageArtifactAdd extends HookWidget {
  static void show(BuildContext context, EquipType equipType,
      [PlayerArtifact? value]) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        fullscreenDialog: false,
        builder: (context) =>
            PageArtifactAdd(equipType: equipType, value: value),
      ),
    );
  }

  final EquipType equipType;
  final PlayerArtifact? value;

  const PageArtifactAdd({
    Key? key,
    this.equipType = EquipType.SANDS,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var as = BlocGameData.read(context).db.artifact;
    var blocArtifact = BlocArtifact.watch(context);

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

    var defaultName = artifacts.toList()[0].name.text(Lang.CHS);

    var pa = useState(
      (value ??
          PlayerArtifact.empty().copyWith(
            name: defaultName,
            equipType: equipType,
            main: as.mainCanFightProps(defaultName)[0],
          )),
    );

    var mainProps = useMemoized(
      () => as.mainCanFightProps(pa.value.name),
      [pa.value.name],
    );

    var artifactAppendDepot = useMemoized(
      () => as.artifactAppendDepot(pa.value.name),
      [pa.value.name],
    );

    var playerArtifact = pa.value.copyWith(
      equipType: as.find(pa.value.name).equipType,
      appends: pa.value.appends.map(
          (fp, value) => MapEntry(fp, artifactAppendDepot.valueFix(fp, value))),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(value != null ? "修改圣遗物" : "录入圣遗物"),
        actions: [
          IconButton(
            onPressed: () {
              blocArtifact.equip(uid, playerArtifact, value);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildArtifactSelect(artifacts, playerArtifact, pa),
            buildLevelSelect(playerArtifact, pa),
            buildMainPropSelect(pa, playerArtifact, mainProps),
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
                ...playerArtifact.appends.keys.map(
                  (fp) => buildAppendPropSelect(
                      playerArtifact, artifactAppendDepot, fp, pa),
                ),
                ...?(playerArtifact.appends.keys.length < 4)
                    .ifTrueOrNull(() => [
                          const Divider(),
                          ...artifactAppendDepot.keys
                              .where((fp) =>
                                  fp != playerArtifact.main &&
                                  !playerArtifact.appends.keys.contains(fp))
                              .map(
                                (fp) => buildAppendPropSelect(playerArtifact,
                                    artifactAppendDepot, fp, pa),
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
      PlayerArtifact playerArtifact,
      GSArtifactAppendDepot artifactAppendDepot,
      FightProp fp,
      ValueNotifier<PlayerArtifact> pa) {
    var remainCount =
        playerArtifact.appends.keys.where((ofp) => ofp != fp).fold<int>(
              4 + 5,
              (r, ofp) =>
                  r -
                  (playerArtifact.appends[ofp] == ""
                      ? 1
                      : artifactAppendDepot
                          .valueIndexes(ofp, playerArtifact.appends[ofp])
                          .length),
            );

    var valueIndexes = artifactAppendDepot.canValues(fp);
    var values = valueIndexes.keys
        .where((k) => valueIndexes[k]!.length <= remainCount)
        .toList();

    return Select<String>(
      options: values,
      value: playerArtifact.appends[fp] ?? "",
      onSelected: (selected) {
        pa.value = playerArtifact.copyWith(
          appends: {
            ...playerArtifact.appends,
            fp: selected,
          }..removeWhere((key, value) => value == ""),
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
            leading: playerArtifact.appends[fp]?.let(
              (v) => IconButton(
                onPressed: () {
                  pa.value = playerArtifact.copyWith(
                    appends: {
                      ...playerArtifact.appends,
                      fp: "",
                    }..removeWhere((fp, value) => value == ""),
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

  Select<FightProp> buildMainPropSelect(ValueNotifier<PlayerArtifact> pa,
      PlayerArtifact playerArtifact, List<FightProp> mainProps) {
    return Select<FightProp>(
      options: mainProps,
      value: playerArtifact.main,
      onSelected: (selected) {
        pa.value = playerArtifact.copyWith(
          main: selected,
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
    PlayerArtifact playerArtifact,
    ValueNotifier<PlayerArtifact> pa,
  ) {
    return Select<int>(
      options: const [0, 4, 8, 12, 16, 20],
      value: playerArtifact.level,
      onSelected: (selected) {
        pa.value = playerArtifact.copyWith(level: selected);
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
    PlayerArtifact playerArtifact,
    ValueNotifier<PlayerArtifact> pa,
  ) {
    return Select<GSArtifact>(
      options: artifacts,
      value: artifacts.firstWhereOrNull(
          (v) => v.name.text(Lang.CHS) == playerArtifact.name),
      onSelected: (selected) {
        pa.value = playerArtifact.copyWith(name: selected.name.text(Lang.CHS));
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
            nameID: option.value.nameID,
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
              nameID: s.nameID,
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
                // borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        )
      ],
    );
  }
}
