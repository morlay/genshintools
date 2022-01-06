import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/page_artifact_list.dart';
import 'package:genshintools/app/ui/select.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/good/good.dart';

import 'auth/auth.dart';
import 'view_build.dart';

class ViewArtifactBuilder extends HookWidget {
  const ViewArtifactBuilder({
    Key? key,
    required this.current,
    required this.state,
    required this.fightProps,
  }) : super(key: key);

  final CharacterWithState current;
  final ValueNotifier<CharacterWithState> state;
  final FightProps fightProps;

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.read(context).state.chosenUid();
    var c = state.value;

    return GestureDetector(
      onTap: () {
        _showModal(context, uid, state);
      },
      child: ViewBuildArtifactSetPair(
        fightProps: fightProps,
        artifacts: c.artifacts,
      ),
    );
  }

  void _showModal(
    BuildContext context,
    int uid,
    ValueNotifier<CharacterWithState> state,
  ) {
    var db = BlocGameData.read(context).db;
    var builds = current.character.characterAllBuilds();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List<ViewBuildArtifactSetPair> artifactSets = [
          ViewBuildArtifactSetPair(
            fightProps: fightProps,
            artifacts: current.artifacts,
            backup: "当前配装",
          ),
          ...?builds.artifactSetPairs?.map(
            (artifactSetPair) => ViewBuildArtifactSetPair(
              fightProps: fightProps,
              artifacts: db.artifact.buildArtifactsBySetPair(
                artifactSetPair,
                builds,
                current.artifacts,
              ),
            ),
          ),
        ];

        return FractionallySizedBox(
          heightFactor: 0.7,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).primaryColor,
                  tabs: const [
                    Tab(text: "当前配装"),
                    Tab(text: "其他套装"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      CurrentArtifact(uid: uid, c: current),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ...artifactSets.map(
                              (artifactSet) => ListTile(
                                selected: false,
                                onTap: () {
                                  state.value = state.value.copyWith(
                                    artifacts: artifactSet.artifacts,
                                  );
                                  Navigator.of(context).pop();
                                },
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                title: ViewBuildArtifactSetPair(
                                  full: true,
                                  fightProps: fightProps,
                                  backup: artifactSet.backup,
                                  artifacts: artifactSet.artifacts,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CurrentArtifact extends HookWidget {
  const CurrentArtifact({
    Key? key,
    required this.uid,
    required this.c,
  }) : super(key: key);

  final CharacterWithState c;
  final int uid;

  @override
  Widget build(BuildContext context) {
    var blocGameData = BlocGameData.watch(context);
    var state = blocGameData.playerState(uid);
    var current = state.artifactsOn(c.character.key);

    return SingleChildScrollView(
      child: Column(
        children: [
          ...EquipType.values.map((et) {
            var list = state.artifacts
                .where((a) => a.slotKey.asEquipType() == et)
                .toList();

            var currentArtifact =
                current.firstWhereOrNull((a) => a.slotKey.asEquipType() == et);

            return Select<GOODArtifact>(
              title: const Text("圣遗物"),
              options: list,
              value: currentArtifact,
              onSelected: (selected) {
                if (currentArtifact == null) {
                  blocGameData.equipArtifact(
                    uid,
                    selected.copyWith(
                      location: c.character.key,
                    ),
                  );
                } else {
                  blocGameData.equipArtifact(
                    uid,
                    selected,
                    currentArtifact,
                  );
                }
              },
              optionBuilder: (context, option, selected) {
                return GOODArtifactListTile(
                  artifact: option.value,
                  onAvatarTap: () {
                    option.select();
                  },
                );
              },
              tileBuilder: (context, selected) {
                return selected.value?.let((pa) => GOODArtifactListTile(
                        artifact: pa,
                        onAvatarTap: () {
                          selected.showOptions(context);
                        })) ??
                    ListTile(
                      onTap: () {
                        selected.showOptions(context);
                      },
                      title: Text("请选择${et.label()}"),
                    );
              },
            );
          })
        ],
      ),
    );
  }
}
