import { reduce, snakeCase, trim, uniqBy } from "lodash-es";
import { findWeapon } from "./domain_weapon";
import { findArtifactSet } from "./domain_artifact";

const statsMap: Record<string, string> = {
  "HP%": "FIGHT_PROP_HP_PERCENT",
  "ATK%": "FIGHT_PROP_ATTACK_PERCENT",
  "DEF%": "FIGHT_PROP_DEFENSE_PERCENT",
  "Flat HP": "FIGHT_PROP_HP",
  "Flat ATK": "FIGHT_PROP_ATTACK",
  "Flat DEF": "FIGHT_PROP_DEFENSE",

  "Elemental Mastery": "FIGHT_PROP_ELEMENT_MASTERY",
  EM: "FIGHT_PROP_ELEMENT_MASTERY",
  "Energy Recharge": "FIGHT_PROP_CHARGE_EFFICIENCY",
  "ER%": "FIGHT_PROP_CHARGE_EFFICIENCY",
  "Crit Rate": "FIGHT_PROP_CRITICAL",
  "Crit DMG": "FIGHT_PROP_CRITICAL_HURT",
  // hack
  DMG: "FIGHT_PROP_CRITICAL_HURT",
  "Healing Bonus": "FIGHT_PROP_HEAL_ADD",

  "Pyro DMG": "FIGHT_PROP_FIRE_ADD_HURT",
  "Hydro DMG": "FIGHT_PROP_WATER_ADD_HURT",
  "Geo DMG": "FIGHT_PROP_ROCK_ADD_HURT",
  "Cryo DMG": "FIGHT_PROP_ICE_ADD_HURT",
  "Electro DMG": "FIGHT_PROP_ELEC_ADD_HURT",
  "Anemo DMG": "FIGHT_PROP_WIND_ADD_HURT",
  "Dendro DMG": "FIGHT_PROP_GRASS_ADD_HURT",
  "Physical DMG": "FIGHT_PROP_PHYSICAL_ADD_HURT",
};

const resolvePropTypes = (s: string): string[] => {
  return reduce(
    s.split("/"),
    (ret: string[], s: string) => {
      const f =
        statsMap[s.trim()] ||
        statsMap[s.trim().replace("Damage", "DMG")] ||
        statsMap[s.trim().replace("Attack", "ATK")] ||
        statsMap[s.trim().replace("Defence", "ATK")];

      if (f) {
        return [...ret, f];
      }

      return ret;
    },
    [],
  );
};

const chooseTwo = (list: string[]) => {
  const pairs: string[][] = [];

  for (let i = 0; i < list.length; i++) {
    for (let j = i + 1; j < list.length; j++) {
      pairs.push([list[i], list[j]]);
    }
  }

  return pairs;
};

const formatSkillType = (v: string) => {
  return (
    {
      BURST: "Q",
      NORMAL_ATTACK: "A",
      SKILL: "E",
    } as any
  )[snakeCase(trim(v, "*").trim()).toUpperCase()];
};

const weaponAliases: { [k: string]: string } = {
  "Skyrider's Greatsword": "Skyrider Greatsword",
  Wavebreaker: "Wavebreaker's Fin",
  "Aquilla Favonia": "Aquila Favonia",
  "Viridescent Hunt": "The Viridescent Hunt",
  "Anemona Kageuchi": "Amenoma Kageuchi",
  "Solar Pearl R4": "Solar Pearl",
  "Festering Desire R5": "Festering Desire",
};

const artifactAliases: { [k: string]: string } = {
  "Emblem of Severed Fates": "Emblem of Severed Fate",
  "Maiden's Beloved": "Maiden Beloved",
  "Lavawalkers Epiphany": "Lavawalker",
  Thundersoothers: "Thundersoother",
};

export const characterBuild = (name: string, b: any) => {
  return {
    Role: b.role,
    Weapons: b.weapons
      .map((id: string) => {
        const found = findWeapon(snakeCase(weaponAliases[id] || id));
        if (found) {
          return found.Name.CHS;
        }
        console.log(`${name} missing weapon ${id}`);
        return "";
      })
      .filter((v: string) => v),
    ArtifactMainPropTypes: {
      EQUIP_SHOES: resolvePropTypes(b.mainStats.sands),
      EQUIP_RING: resolvePropTypes(b.mainStats.goblet),
      EQUIP_DRESS: resolvePropTypes(b.mainStats.circlet),
    },
    ArtifactAffixPropTypes: reduce(b.subStats, (ret: string[], s: string) => [...ret, ...resolvePropTypes(s)], []),
    ArtifactSetPairs: uniqBy(
      b.artifacts.reduce((ret: string[][], sets: string[]) => {
        const pair = sets
          .map((setName) => {
            const found = findArtifactSet(snakeCase(artifactAliases[setName] || setName));
            if (found) {
              return found.Name.CHS;
            }
            if ("18_atk_set" === snakeCase(artifactAliases[setName] || setName)) {
              return "角斗士的终幕礼";
            }
            if ("20_er_set" === snakeCase(artifactAliases[setName] || setName)) {
              return "绝缘之旗印";
            }
            console.log(`${name} missing artifact set ${setName}`);
            return null;
          })
          .filter((s) => s) as string[];

        if (pair.length > 2) {
          return [...ret, ...chooseTwo(pair)];
        }

        return [...ret, pair];
      }, []),
      (s: string[]) => s.join("/"),
    ),
    SkillPriority: b.talent.map((v: string) => v.split("/").map(formatSkillType)),
  };
};
