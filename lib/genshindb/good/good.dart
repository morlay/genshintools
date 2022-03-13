import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

part 'generated/good.freezed.dart';
part 'generated/good.g.dart';

@freezed
class GOOD with _$GOOD {
  GOOD._();

  factory GOOD({
    @Default("GOOD") String format,
    @Default(1) double version,
    @Default("dev.morlay.genshintools") String source,
    required List<GOODCharacter> characters,
    required List<GOODArtifact> artifacts,
    required List<GOODWeapon> weapons,
    required Map<String, double> materials,
  }) = _GOOD;

  factory GOOD.empty() => GOOD(
        characters: [],
        artifacts: [],
        weapons: [],
        materials: {},
      );

  factory GOOD.fromJson(Map<String, dynamic> json) => _GOOD.fromJson(json);

  GOODCharacter? characterOrNull(String key) {
    return characters.firstWhereOrNull((c) => c.key == key);
  }

  GOODCharacter character(String key) {
    return characterOrNull(key) ??
        GOODCharacter(
          constellation: 0,
          key: key,
          level: 0,
          ascension: 0,
          talent: {
            TalentType.auto: 1,
            TalentType.skill: 1,
            TalentType.burst: 1,
          },
        );
  }

  updateCharacter(
    String key,
    GOODCharacter Function(GOODCharacter c) update,
  ) {
    final updated = update(characters.firstWhereOrNull((e) => e.key == key) ??
        GOODCharacter.create(key));

    return copyWith(
      version: 1,
      characters: _cleanupCharacters([
        ...characters.where((e) => e.key != ""),
        updated,
      ]),
    );
  }

  updateWeapon(
    String location,
    GOODWeapon Function(GOODWeapon c) update,
    String defaultKey,
  ) {
    var found = weapons.firstWhereOrNull((e) => e.location == location);

    if (found != null) {
      return copyWith(
        weapons: _cleanupWeapons(weapons
            .map((a) => a.location == found.location ? update(found) : a)
            .toList()),
      );
    }

    return copyWith(
      weapons: _cleanupWeapons([
        ...weapons,
        update(GOODWeapon.create(defaultKey, location)),
      ]),
    );
  }

  GOOD updateArtifact(
    SlotKey sk,
    String location,
    GOODArtifact Function(GOODArtifact artifact) update,
  ) {
    var found = artifacts.firstWhereOrNull((e) =>
        (e.slotKey == sk && e.location == location) ||
        // 为圣遗物匹配不同元素的旅行者
        (e.slotKey == sk && e.location == 'Traveler') &&
            location.startsWith('Traveler'));

    if (found != null) {
      return copyWith(
        artifacts: _cleanupArtifacts(
            artifacts.map((a) => a == found ? update(found) : a).toList()),
      );
    }

    return copyWith(
      artifacts: _cleanupArtifacts(
          artifacts..add(update(GOODArtifact.create(sk, location)))),
    );
  }

  List<GOODCharacter> _cleanupCharacters(List<GOODCharacter> characters) {
    return characters.where((w) => w.key != "").toList().uniqBy((e) => e.key);
  }

  List<GOODWeapon> _cleanupWeapons(List<GOODWeapon> weapons) {
    return weapons.where((w) => w.key != "").toList().uniqBy((e) => e.location);
  }

  List<GOODArtifact> _cleanupArtifacts(List<GOODArtifact> artifacts) {
    return artifacts
        .where((a) => a.setKey != "")
        .toList()
        .uniqBy((e) => e.hashCode);
  }

  GOOD removeArtifact(GOODArtifact artifact) {
    return copyWith(
      artifacts: artifacts.where((a) => a != artifact).toList(),
    );
  }

  GOOD equipArtifact(GOODArtifact artifact, GOODArtifact? from) {
    if (from != null) {
      if (from.location == artifact.location) {
        return copyWith(
            artifacts: [
          ...artifacts.map((a) => from == a ? artifact : a),
        ].uniqBy((e) => e.hashCode));
      } else {
        return copyWith(
            artifacts: [
          ...artifacts.map((a) {
            if (from == a) {
              return from.copyWith(
                location: artifact.location,
              );
            }
            if (artifact == a) {
              return artifact.copyWith(
                location: from.location,
              );
            }
            return a;
          })
        ].uniqBy((e) => e.hashCode));
      }
    }
    return copyWith(
      artifacts: [
        ...artifacts,
        artifact,
      ].uniqBy((e) => e.hashCode),
    );
  }

  GOODWeapon weaponOn(String location, [String? defaultKey]) {
    return weapons.firstWhereOrNull((w) => w.location == location) ??
        GOODWeapon(
          key: defaultKey ?? "",
          level: 1,
          ascension: 0,
          refinement: 1,
          location: location,
        );
  }

  List<GOODArtifact> artifactsOn(String location) {
    return artifacts.where((a) => a.location == location).toList()
      ..sort((a, b) => a.slotKey.index.compareTo(b.slotKey.index));
  }
}

@freezed
class GOODCharacter with _$GOODCharacter {
  GOODCharacter._();

  static int ascensionByLevel(int level) {
    var ascension = 0;
    for (var maxLevel in [20, 40, 50, 60, 70, 80]) {
      if (level > maxLevel) {
        ascension++;
      }
    }
    return ascension;
  }

  factory GOODCharacter({
    required String key,
    required int level,
    required int constellation,
    required int ascension,
    required Map<TalentType, int> talent,
    String? role,
  }) = _GOODCharacter;

  factory GOODCharacter.create(String key) => GOODCharacter(
          key: key,
          level: 1,
          constellation: 0,
          ascension: 0,
          talent: {
            TalentType.auto: 1,
            TalentType.skill: 1,
            TalentType.burst: 1,
          });

  factory GOODCharacter.fromJson(Map<String, dynamic> json) =>
      _GOODCharacter.fromJson(json);

  bool get own => level > 0;

  int skillLevel(SkillType skill) {
    return talent[TalentType.values[skill.index]] ?? 1;
  }
}

@freezed
class GOODSubStat with _$GOODSubStat {
  GOODSubStat._();

  factory GOODSubStat({
    required StatKey key,
    @Default(0) double value,
  }) = _GOODSubStat;

  factory GOODSubStat.fromJson(Map<String, dynamic> json) =>
      _GOODSubStat.fromJson(json);

  GOODSubStat withStringValue(String value) {
    return copyWith(
      value: key.name.endsWith("_")
          ? double.parse(value.split("?").first) * 100
          : double.parse(value.split("?").first).toInt().toDouble(),
    );
  }

  String stringValue() {
    return key.name.endsWith("_")
        ? GSArtifactAppendDepot.format(value / 100)
        : GSArtifactAppendDepot.format(value);
  }

  @override
  String toString() {
    return "${key.name}:${stringValue()}";
  }
}

@freezed
class GOODArtifact with _$GOODArtifact {
  GOODArtifact._();

  factory GOODArtifact({
    required String setKey,
    required SlotKey slotKey,
    required int level,
    required int rarity,
    required StatKey mainStatKey,
    required String location,
    required List<GOODSubStat> substats,
    @Default(true) bool lock,
  }) = _GOODArtifact;

  static StatKey statKeyFromFightProp(FightProp fp) {
    return _fightPropToStatKey[fp]!;
  }

  factory GOODArtifact.create(SlotKey slotKey, String location) {
    return GOODArtifact(
      slotKey: slotKey,
      location: location,
      mainStatKey: defaultMainStatKey(slotKey),
      setKey: "",
      rarity: 5,
      level: 0,
      substats: [],
    );
  }

  factory GOODArtifact.fromJson(Map<String, dynamic> json) =>
      _GOODArtifact.fromJson(json);

  static StatKey defaultMainStatKey(SlotKey sk) {
    return {
      SlotKey.flower: StatKey.hp,
      SlotKey.plume: StatKey.atk,
      SlotKey.sands: StatKey.atk_,
      SlotKey.goblet: StatKey.atk_,
      SlotKey.circlet: StatKey.critRate_,
    }[sk]!;
  }

  Map<FightProp, String> substatsAsFightProps() {
    var subProps = substats.fold<Map<FightProp, String>>({}, (ret, s) {
      return {
        ...ret,
        s.key.asFightProp(): GSArtifactAppendDepot.format(
          s.key.name.endsWith("_") ? (s.value / 1e2) : s.value,
        )
      };
    });
    return subProps;
  }
}

@freezed
class GOODWeapon with _$GOODWeapon {
  GOODWeapon._();

  factory GOODWeapon({
    required String key,
    required int level,
    required int ascension,
    required int refinement,
    required String location,
    @Default(true) bool lock,
  }) = _GOODWeapon;

  factory GOODWeapon.create(String key, String location) => GOODWeapon(
        key: key,
        location: location,
        level: 1,
        ascension: 0,
        refinement: 1,
      );

  factory GOODWeapon.fromJson(Map<String, dynamic> json) =>
      _GOODWeapon.fromJson(json);
}

@JsonEnum()
enum SlotKey {
  flower,
  plume,
  sands,
  goblet,
  circlet,
}

extension SlotKeyAsEquipType on SlotKey {
  EquipType asEquipType() {
    return EquipType.values[index];
  }
}

enum TalentType {
  auto,
  skill,
  burst,
  other,
}

extension TalentTypeAsSkillType on TalentType {
  SkillType asSkillType() {
    return SkillType.values[index];
  }
}

@JsonEnum()
enum StatKey {
  hp,
  hp_,
  atk,
  atk_,
  def,
  def_,
  eleMas,
  enerRech_,
  heal_,
  critRate_,
  critDMG_,
  physical_dmg_,
  anemo_dmg_,
  geo_dmg_,
  electro_dmg_,
  hydro_dmg_,
  pyro_dmg_,
  cryo_dmg_,
}

extension StatKeyAsFightProp on StatKey {
  FightProp asFightProp() {
    return _statKeyToFightProp[StatKey.values[index]]!;
  }
}

Map<FightProp, StatKey> _fightPropToStatKey =
    _statKeyToFightProp.map((k, v) => MapEntry(v, k));

Map<StatKey, FightProp> _statKeyToFightProp = {
  StatKey.hp: FightProp.HP,
  StatKey.hp_: FightProp.HP_PERCENT,
  StatKey.atk: FightProp.ATTACK,
  StatKey.atk_: FightProp.ATTACK_PERCENT,
  StatKey.def: FightProp.DEFENSE,
  StatKey.def_: FightProp.DEFENSE_PERCENT,
  StatKey.eleMas: FightProp.ELEMENT_MASTERY,
  StatKey.enerRech_: FightProp.CHARGE_EFFICIENCY,
  StatKey.heal_: FightProp.HEAL_ADD,
  StatKey.critRate_: FightProp.CRITICAL,
  StatKey.critDMG_: FightProp.CRITICAL_HURT,
  StatKey.physical_dmg_: FightProp.PHYSICAL_ADD_HURT,
  StatKey.anemo_dmg_: FightProp.WIND_ADD_HURT,
  StatKey.geo_dmg_: FightProp.ROCK_ADD_HURT,
  StatKey.electro_dmg_: FightProp.ELEC_ADD_HURT,
  StatKey.hydro_dmg_: FightProp.WATER_ADD_HURT,
  StatKey.pyro_dmg_: FightProp.FIRE_ADD_HURT,
  StatKey.cryo_dmg_: FightProp.ICE_ADD_HURT,
};
