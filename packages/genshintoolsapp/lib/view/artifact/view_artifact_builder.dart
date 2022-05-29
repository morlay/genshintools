import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/gameui.dart';

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

    return InkWell(
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
    var builds = current.character.characterBuildFor(state.value.c.role);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        List<ViewBuildArtifactSetPair> artifactSets = [
          ViewBuildArtifactSetPair(
            fightProps: fightProps,
            artifacts: current.artifacts,
            backup: '当前配装',
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
          child: SafeArea(
            child: Column(
              children: [
                ListTile(
                  title: Text('其他套装'),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...artifactSets.map(
                          (artifactSet) => ListTile(
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class ViewBuildArtifactSetPair extends HookWidget {
  final FightProps fightProps;
  final List<GOODArtifact> artifacts;
  final String? backup;
  final bool? full;

  const ViewBuildArtifactSetPair({
    required this.fightProps,
    required this.artifacts,
    this.backup,
    this.full,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var db = BlocGameData.read(context).db;
    var sets = db.artifact.resolveArtifactSets(artifacts);

    if (full ?? false) {
      return _buildInfo(context, sets);
    }

    return InkWell(
      child: Text(sets.map((e) => e.name.text(Lang.CHS)).join(" + "),
          textAlign: TextAlign.center),
    );
  }

  Widget _buildInfo(BuildContext context, List<GSArtifactSet> sets) {
    return DefaultTextStyle.merge(
      style: Theme.of(context).textTheme.bodyText2,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Wrap(
              runSpacing: 4,
              children: [
                ...sets.map(
                  (s) => Wrap(
                    runSpacing: 2,
                    children: [
                      ...s.equipAffixes
                          .where(
                            (ea) =>
                                (s.activeNum ?? 0) >= (ea.activeWhenNum ?? 0),
                          )
                          .expand(
                            (e) => [
                              Row(
                                children: [
                                  Text(
                                    '${e.name.text(Lang.CHS)} * ${e.activeWhenNum}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 9,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                              GSDesc(
                                desc: e.desc,
                              ),
                            ],
                          )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ...?backup?.let(
            (it) => [
              Text(
                '[$it]',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 9,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
