import 'package:collection/collection.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/common/flutter/flutter.dart';
import 'package:genshintoolsapp/domain/auth.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/view/account.dart';
import 'package:genshintoolsapp/view/character.dart';
import 'package:genshintoolsapp/view/gameui.dart';

import 'page_artifact_add.dart';

class PageArtifactList extends HookWidget {
  static String routeName = "/artifacts";

  const PageArtifactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var blocGameData = BlocGameData.watch(context);
    var equipTypes = EquipType.values;

    var grouped = blocGameData
        .playerState(uid)
        .artifacts
        .groupListsBy((e) => e.slotKey.asEquipType());

    return AppBarWithAccount.buildScaffold(
      context,
      DefaultTabController(
        length: equipTypes.length,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              labelColor: Theme.of(context).primaryColor,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                ...equipTypes.map(
                  (et) => Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Text(et.label()),
                    ),
                  ),
                )
              ],
            ),
            const Divider(height: 1),
            Expanded(
              child: TabBarView(
                children: [
                  ...equipTypes.map((et) {
                    // blocArtifact.state.all
                    var l = grouped[et] ?? [];

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            onTap: () {
                              PageArtifactAdd.show(context, et);
                            },
                            onLongPress: () {
                              _import(context);
                            },
                            title: Row(
                              children: const [
                                SizedBox(
                                  width: 24 * 2,
                                  child: AppendValueIndex(
                                      indexes: [-4, -3, -2, -1, 1, 2, 3, 4]),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "表示词条个数, 颜色分别代表数值档位",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Icon(Icons.add),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 16,
                              children: [
                                ...l.map((artifact) =>
                                    GOODArtifactCard(artifact: artifact)),
                              ],
                            ),
                          )
                        ],
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

  _import(BuildContext context) {
    var uid = BlocAuth.read(context).state.chosenUid();
    var blocGameData = BlocGameData.read(context);
    var characters = blocGameData.db.character;

    showAlert(
      context,
      content: Text("是否开始批量导入?\n此操作不可逆转，现有圣遗物会被清空\n"),
      onConfirm: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['json'],
          withData: true,
        );
        var artifacts = [];
        if (result != null) {
          PlatformFile file = result.files.first;

          var convert = (Uint8List? l) {
            if (l != null) {
              Uint8List nonNullTerminated = l;
              if (l.last == 0) {
                nonNullTerminated =
                    new Uint8List.view(l.buffer, l.offsetInBytes, l.length - 1);
              }
              return utf8.decode(nonNullTerminated, allowMalformed: true);
            } else
              return "";
          };

          Map<String, dynamic> json = jsonDecode(convert(file.bytes));

          if (json.keys.contains("artifacts")) {
            //GOOD format
            //export by Amenoma https://github.com/daydreaming666/Amenoma
            artifacts = json["artifacts"];
          } else if (json.keys.contains("feather")) {
            //mona-uranai format
            //export by YAS https://github.com/wormtql/yas
            artifacts = (json["flower"] +
                    json["feather"] +
                    json["sand"] +
                    json["cup"] +
                    json["head"])
                .map((artifact) => <String, dynamic>{
                      "setKey": _mona2GOODMap[artifact["setName"]],
                      "slotKey": _mona2GOODMap[artifact["position"]],
                      "level": artifact["level"],
                      "rarity": artifact["star"],
                      "mainStatKey": _mona2GOODMap[artifact["mainTag"]["name"]],
                      "location":
                          characters.getCharacterKey(artifact["equip"]) ?? "",
                      "lock": artifact["omit"] as bool? ?? false,
                      "substats": (artifact['normalTags'] as List<dynamic>)
                          .map((e) => <String, dynamic>{
                                "key": _mona2GOODMap[e["name"]],
                                "value": double.parse(
                                            e["value"].toStringAsFixed(3)) <
                                        1
                                    ? e["value"] * 100
                                    : e["value"]
                              })
                          .toList()
                    })
                .toList();
          } else {
            //MingyuLab format
            //export by Amenoma https://github.com/daydreaming666/Amenoma
          }
          blocGameData.importArtifacts(
              uid, artifacts.map((e) => GOODArtifact.fromJson(e)).toList());
        }
        final snackBar = SnackBar(
          content: Text.rich(TextSpan(children: [
            const TextSpan(text: "批量导入成功，共导入"),
            TextSpan(text: artifacts.length.toString()),
            const TextSpan(text: "个圣遗物"),
          ])),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}

class GOODArtifactCard extends HookWidget {
  const GOODArtifactCard({
    Key? key,
    required this.artifact,
    this.onAvatarTap,
  }) : super(key: key);

  final GOODArtifact artifact;
  final void Function()? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    var uid = BlocAuth.watch(context).state.chosenUid();
    var bloc = BlocGameData.read(context);
    var db = BlocGameData.read(context).db;

    var a = db.artifact
        .findSet(artifact.setKey)
        .artifact(artifact.slotKey.asEquipType());

    var builds = db.character.findOrNull(artifact.location)?.let(
          (c) => c.characterBuildFor(
              bloc.playerState(uid).character(artifact.location).role),
        );

    var fightProps = db.character.findOrNull(artifact.location)?.let((cc) {
          var c = bloc.findCharacterWithState(uid, cc.key);

          return db.character
              .fightProps(
                c.c.key,
                c.c.level,
                c.c.constellation,
              )
              .merge(db.weapon.fightProps(
                c.w.key,
                c.w.level,
                c.w.refinement,
              ));
        }) ??
        FightProps({});

    var appendDepot = db.artifact.artifactAppendDepot(a.key);

    double infoWidth = 50;

    return InkWell(
      onTap: () => PageArtifactAdd.show(
          context, artifact.slotKey.asEquipType(), artifact),
      onLongPress: () => _remove(context, artifact),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6,
        ),
        child: Wrap(
          spacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 0,
                    left: -10,
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          a.name.text(Lang.CHS),
                          style: const TextStyle(fontSize: 7),
                        )),
                  ),
                  Positioned(
                    left: 0,
                    bottom: -16,
                    right: 0,
                    child: FightPropView(
                        highlight: builds?.artifactAffixPropTypes
                            ?.contains(artifact.mainStatKey.asFightProp()),
                        fightProp: artifact.mainStatKey.asFightProp(),
                        value: db.artifact.mainFightProp(
                          artifact.mainStatKey.asFightProp(),
                          artifact.rarity,
                          artifact.level,
                        )),
                  ),
                  _buildAvatar(a, db, infoWidth),
                ],
              ),
            ),
            SizedBox(
              width: infoWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...artifact.substats.map((ss) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          bottom: -1,
                          right: 0,
                          child: Opacity(
                            opacity: 0.7,
                            child: SizedBox(
                              width: infoWidth,
                              child: AppendValueIndex(
                                reverse: true,
                                indexes: appendDepot.valueNs(
                                  ss.key.asFightProp(),
                                  ss.stringValue(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: FightPropView(
                              highlight: builds?.artifactAffixPropTypes
                                  ?.contains(ss.key.asFightProp()),
                              fightProp: ss.key.asFightProp(),
                              value: appendDepot.valueFor(
                                ss.key.asFightProp(),
                                ss.stringValue(),
                              ),
                              calcValue: (fp, value) {
                                if (fp == FightProp.ATTACK_PERCENT) {
                                  return fightProps.get(FightProp.BASE_ATTACK) *
                                      value;
                                }
                                if (fp == FightProp.HP_PERCENT) {
                                  return fightProps.get(FightProp.BASE_HP) *
                                      value;
                                }
                                if (fp == FightProp.DEFENSE_PERCENT) {
                                  return fightProps
                                          .get(FightProp.BASE_DEFENSE) *
                                      value;
                                }
                                return null;
                              }),
                        ),
                      ],
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

  GestureDetector _buildAvatar(GSArtifact a, GSDB db, double size) {
    return GestureDetector(
      onTap: onAvatarTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          WithLevel(
            level: artifact.level,
            child: GSImage(
              domain: 'artifact',
              nameID: a.key,
              rarity: artifact.rarity,
              size: size.toInt(),
            ),
          ),
          Positioned(
            left: -8,
            top: -8,
            child: Column(
              children: [
                ...?db.character.findOrNull(artifact.location)?.let((c) => [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: GSImage(
                          domain: "character",
                          rarity: c.rarity,
                          nameID: c.key,
                          rounded: true,
                          borderSize: 2,
                        ),
                      )
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _remove(BuildContext context, GOODArtifact pa) {
    var uid = BlocAuth.read(context).state.chosenUid();

    showAlert(
      context,
      content: Text.rich(TextSpan(children: [
        TextSpan(text: "是否删除 $pa?"),
        const TextSpan(text: "\n"),
        const TextSpan(text: "\n"),
        TextSpan(
            text: "(${pa.toString()})", style: const TextStyle(fontSize: 11)),
      ])),
      onConfirm: () {
        BlocGameData.read(context).removeArtifact(uid, pa);
      },
    );
  }
}

class FightPropView extends HookWidget {
  const FightPropView({
    Key? key,
    required this.fightProp,
    required this.value,
    this.highlight,
    this.calcValue,
  }) : super(key: key);

  final FightProp fightProp;
  final double value;
  final double? Function(FightProp fp, double value)? calcValue;
  final bool? highlight;

  @override
  Widget build(BuildContext context) {
    final formatValue = format(value, fightProp.format());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLabel(),
          DefaultTextStyle.merge(
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: highlight?.ifTrueOrNull(() => FontWeight.bold),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -2,
                  right: -7,
                  child: Text(
                    formatValue.contains("%") ? "%" : "",
                    style: TextStyle(
                      fontSize: 6,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  right: 0,
                  child: Text(
                    calcValue
                            ?.let((calc) => calc(fightProp, value))
                            ?.let((v) => "${v.toInt()}") ??
                        "",
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.normal,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                Text(
                  formatValue.replaceAll("%", ""),
                  style: TextStyle(
                    fontSize: 11,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLabel() {
    var n = _shortName;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Text(
            n[n.length - 1],
            style: TextStyle(
              textBaseline: TextBaseline.ideographic,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...?(n.length > 1).ifTrueOrNull(
          () => [
            Positioned(
              top: -2,
              right: -4,
              child: SizedBox(
                width: 7,
                child: Center(
                  child: Text(
                    n[0],
                    style: TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.bold,
                        fontFeatures: const [FontFeature.tabularFigures()]),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  String get _shortName {
    switch (fightProp) {
      case FightProp.CHARGE_EFFICIENCY:
        return "充";
      case FightProp.ELEMENT_MASTERY:
        return "精";
      case FightProp.CRITICAL:
        return "%暴";
      case FightProp.CRITICAL_HURT:
        return "*暴";
      default:
        if (fightProp.name.contains("HURT_ADD")) {
          return "+${fightProp.label()[0]}";
        }
        if (fightProp.name.contains("PERCENT")) {
          return "%${fightProp.label()[0]}";
        }
        return fightProp.label()[0];
    }
  }
}

Map<String, String> _mona2GOODMap = {
  //name
  'critical': 'critRate_',
  'criticalDamage': 'critDMG_',
  'attackStatic': 'atk',
  'attackPercentage': 'atk_',
  'elementalMastery': 'eleMas',
  'recharge': 'enerRech_',
  'lifeStatic': 'hp',
  'lifePercentage': 'hp_',
  'defendStatic': 'def',
  'defendPercentage': 'def_',
  'physicalBonus': 'physical_dmg_',
  'cureEffect': 'heal_',
  'rockBonus': 'geo_dmg_',
  'windBonus': 'anemo_dmg_',
  'iceBonus': 'cryo_dmg_',
  'waterBonus': 'hydro_dmg_',
  'fireBonus': 'pyro_dmg_',
  'thunderBonus': 'electro_dmg_',
  //slotKey
  'flower': 'flower',
  'feather': 'plume',
  'sand': 'sands',
  'cup': 'goblet',
  'head': 'circlet',
  //setKey
  'archaicPetra': 'ArchaicPetra',
  'blizzardStrayer': 'BlizzardStrayer',
  'bloodstainedChivalry': 'BloodstainedChivalry',
  'crimsonWitch': 'CrimsonWitchOfFlames',
  'gladiatorFinale': 'GladiatorsFinale',
  'heartOfDepth': 'HeartOfDepth',
  'lavaWalker': 'Lavawalker',
  'maidenBeloved': 'MaidenBeloved',
  'noblesseOblige': 'NoblesseOblige',
  'retracingBolide': 'RetracingBolide',
  'thunderSmoother': 'Thundersoother',
  'thunderingFury': 'ThunderingFury',
  'viridescentVenerer': 'ViridescentVenerer',
  'wandererTroupe': 'WanderersTroupe',
  'berserker': 'Berserker',
  'braveHeart': 'BraveHeart',
  'defenderWill': 'DefendersWill',
  'exile': 'TheExile',
  'gambler': 'Gambler',
  'instructor': 'Instructor',
  'martialArtist': 'MartialArtist',
  'prayersForDestiny': 'PrayersForDestiny',
  'prayersForIllumination': 'PrayersForIllumination',
  'prayersForWisdom': 'PrayersForWisdom',
  'prayersToSpringtime': 'PrayersToSpringtime',
  'resolutionOfSojourner': 'ResolutionOfSojourner',
  'scholar': 'Scholar',
  'tinyMiracle': 'TinyMiracle',
  'adventurer': 'Adventurer',
  'luckyDog': 'LuckyDog',
  'travelingDoctor': 'TravelingDoctor',
  'tenacityOfTheMillelith': 'TenacityOfTheMillelith',
  'paleFlame': 'PaleFlame',
  'emblemOfSeveredFate': 'EmblemOfSeveredFate',
  'shimenawaReminiscence': 'ShimenawasReminiscence',
  'huskOfOpulentDreams': 'HuskOfOpulentDreams',
  'oceanHuedClam': 'OceanHuedClam',
  'EchoesOfAnOffering': 'EchoesOfAnOffering',
  'VermillionHereafter': 'VermillionHereafter',
};
