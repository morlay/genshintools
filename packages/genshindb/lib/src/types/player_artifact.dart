import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';
import 'package:genshindb/extension.dart';

part '__generated__/player_artifact.freezed.dart';

@freezed
class PlayerArtifact with _$PlayerArtifact {
  PlayerArtifact._();

  factory PlayerArtifact({
    required EquipType equipType,
    required String name,
    required FightProp main,
    required Map<FightProp, String> appends,
    required int rarity,
    required int level,
    @Default(0) int usedBy,
  }) = _PlayerArtifact;

  factory PlayerArtifact.fromJson(String s) {
    var valueParts = s.split("|");

    var name = "";
    var rarity = 5;
    var usedBy = 0;
    var equipType = EquipType.BRACER;

    valueParts.getOrNull(0)?.split("!").let((list) {
      list.getOrNull(0)?.let((n) {
        name = n;
      });
      list.getOrNull(1)?.let((r) {
        rarity = int.parse(r);
      });
      list.getOrNull(2)?.let((r) {
        for (var et in EquipType.values) {
          if (et.label() == r) {
            equipType = et;
          }
        }
      });
      list.getOrNull(3)?.let((r) {
        if (r != "") {
          usedBy = int.parse(r);
        }
      });
    });

    var level = valueParts
            .getOrNull(1)
            ?.split("!")
            .getOrNull(1)
            ?.let((l) => int.parse(l)) ??
        20;

    var mainProp = valueParts
            .getOrNull(1)
            ?.split("!")
            .getOrNull(0)
            ?.let((s) => resolveFightProp(s)) ??
        FightProp.HP;

    Map<FightProp, String> appends = {};

    valueParts.forEachIndexed((i, s) {
      if (i > 1) {
        var fp = resolveFightProp(s);
        if (fp != null) {
          var def = s.substring(aliases[fp]!.length);
          appends[fp] = def;
        } else {
          throw s;
        }
      }
    });

    return PlayerArtifact(
      equipType: equipType,
      name: name,
      rarity: rarity,
      level: level,
      main: mainProp,
      appends: appends,
      usedBy: usedBy,
    );
  }

  static FightProp? resolveFightProp(String s) {
    for (var fp in aliases.keys) {
      var alias = aliases[fp]!.toUpperCase();
      if (s.toUpperCase().startsWith(alias)) {
        return fp;
      }
    }
  }

  @override
  String toString() {
    return [
      "$name!$rarity!${equipType.label()}",
      "${aliases[main]}!$level",
      ...appends.keys.map((p) => "${aliases[p]}${appends[p]}"),
    ].join("|");
  }

  String toJson() {
    return toString();
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) {
    return other is PlayerArtifact && other.hashCode == hashCode;
  }
}

Map<FightProp, String> aliases = {
  FightProp.FIRE_ADD_HURT: "${ElementType.Pyro.string()}DMG",
  FightProp.ELEC_ADD_HURT: "${ElementType.Electro.string()}DMG",
  FightProp.ICE_ADD_HURT: "${ElementType.Cryo.string()}DMG",
  FightProp.WATER_ADD_HURT: "${ElementType.Hydro.string()}DMG",
  FightProp.WIND_ADD_HURT: "${ElementType.Anemo.string()}DMG",
  FightProp.ROCK_ADD_HURT: "${ElementType.Geo.string()}DMG",
  FightProp.GRASS_ADD_HURT: "${ElementType.Dendro.string()}DMG",
  FightProp.PHYSICAL_ADD_HURT: "${ElementType.Physical.string()}DMG",
  FightProp.CRITICAL_HURT: "CritDMG",
  FightProp.CRITICAL: "Crit",
  FightProp.HP: "HP+",
  FightProp.ATTACK: "ATK+",
  FightProp.DEFENSE: "DEF+",
  FightProp.ELEMENT_MASTERY: "EM+",
  FightProp.DEFENSE_PERCENT: "DEF",
  FightProp.HP_PERCENT: "HP",
  FightProp.ATTACK_PERCENT: "ATK",
  FightProp.HEAL_ADD: "HEAL",
  FightProp.CHARGE_EFFICIENCY: "ER",
};
