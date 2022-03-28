import { reduce, trim, uniq, uniqBy } from "lodash-es";
import fetch from "node-fetch";
import { parseString } from "@fast-csv/parse";
import { writeFile, readFile } from "fs/promises";
import { existsSync, mkdirSync } from "fs";
import { pascalCase } from "./common";
import { findWeapon } from "./domain_weapon";
import { findArtifactSet } from "./domain_artifact";
import { FightProp } from "./openconfig";
import { dirname } from "path";

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
  "Healing Bonus%": "FIGHT_PROP_HEAL_ADD",

  "Pyro DMG": "FIGHT_PROP_FIRE_ADD_HURT",
  "Hydro DMG": "FIGHT_PROP_WATER_ADD_HURT",
  "Geo DMG": "FIGHT_PROP_ROCK_ADD_HURT",
  "Cryo DMG": "FIGHT_PROP_ICE_ADD_HURT",
  "Electro DMG": "FIGHT_PROP_ELEC_ADD_HURT",
  "Anemo DMG": "FIGHT_PROP_WIND_ADD_HURT",
  "Dendro DMG": "FIGHT_PROP_GRASS_ADD_HURT",
  "Physical DMG": "FIGHT_PROP_PHYSICAL_ADD_HURT",
  "Phys DMG": "FIGHT_PROP_PHYSICAL_ADD_HURT",
};

const resolvePropTypes = (s: string): string[] => {
  return reduce(
    trim(s, "*").split("/"),
    (ret: string[], s: string) => {
      const f =
        statsMap[s.trim()] ||
        statsMap[trim(s.trim(), "*")] ||
        statsMap[s.trim().replace("Damage", "DMG")] ||
        statsMap[s.trim().replace("Attack", "ATK")] ||
        statsMap[s.trim().replace("Defence", "ATK")];

      if (f) {
        return [...ret, f];
      }
      console.warn(`unknown prop name ${s}`);

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
      NORMALATTACK: "A",
      SKILL: "E",
    } as any
  )[pascalCase(trim(v, "*").trim()).toUpperCase()];
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

const artifactSetAliases: { [k: string]: string } = {
  "Emblem of Severed Fates": "Emblem of Severed Fate",
  "Maiden's Beloved": "Maiden Beloved",
  "Lavawalkers Epiphany": "Lavawalker",
  Thundersoothers: "Thundersoother",
  "Instructors": "Instructor",
};

const characterBuild = (name: string, b: any) => {
  function completeArtifactAffixPropTypes(list: string[]) {
    return uniq(
      reduce(
        list,
        (ret, f) => {
          if (f == "FIGHT_PROP_HP_PERCENT") {
            return [...ret, f, "FIGHT_PROP_HP"];
          }
          if (f == "FIGHT_PROP_ATTACK_PERCENT") {
            return [...ret, f, "FIGHT_PROP_ATTACK"];
          }
          if (f == "FIGHT_PROP_DEFENSE_PERCENT") {
            return [...ret, f, "FIGHT_PROP_DEFENSE"];
          }
          return [...ret, f];
        },
        [] as string[],
      ),
    );
  }

  return {
    Recommended: b.recommended,
    Role: b.role,
    Weapons: b.weapons
      .map((id: string) => {
        const found = findWeapon(pascalCase(weaponAliases[id] || id));
        if (found) {
          return found.Name.CHS;
        }
        console.warn(`${name} missing weapon ${id}`);
        return "";
      })
      .filter((v: string) => v),
    ArtifactMainPropTypes: {
      EQUIP_SHOES: resolvePropTypes(b.mainStats.sands),
      EQUIP_RING: resolvePropTypes(b.mainStats.goblet),
      EQUIP_DRESS: resolvePropTypes(b.mainStats.circlet),
    },
    ArtifactAffixPropTypes: completeArtifactAffixPropTypes(
      reduce(b.subStats, (ret: string[], s: string) => [...ret, ...resolvePropTypes(s)], []),
    ),
    ArtifactSetPairs: uniqBy(
      b.artifacts.reduce((ret: string[][], sets: string[]) => {
        const pair = sets
          .map((setName) => {
            const found = findArtifactSet(pascalCase(artifactSetAliases[setName] || setName));
            if (found) {
              return found.Name.CHS;
            }
            if ("18AtkSet" === pascalCase(artifactSetAliases[setName] || setName)) {
              return "角斗士的终幕礼";
            }
            if ("20ErSet" === pascalCase(artifactSetAliases[setName] || setName)) {
              return "绝缘之旗印";
            }
            console.warn(`${name} missing artifact set ${setName}`);
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
    SkillPriority: b.talent.map((v: string) => v.split("/").map(formatSkillType).filter(v => v)),
  };
};

const sheet = "https://now-proxy-3.vercel.app/https:/docs.google.com/spreadsheets/d/1gNxZ2xab1J6o1TuNVWMeLOZ7TPOqrsf3SshP5DLvKzI";
const exportURL = `${sheet}/export?format=csv&id=1gNxZ2xab1J6o1TuNVWMeLOZ7TPOqrsf3SshP5DLvKzI`;

enum Grid {
  Dendro,
  Anemo = 653464458,
  Geo = 1780570478,
  Electro = 408609723,
  Cryo = 1169063456,
  Hydro = 1354385732,
  Pyro = 954718212,
}

const loadOrSync = async (g: Grid) => {
  const file = `./.tmp/${Grid[g]}-${g}.csv`;
  if (existsSync(file)) {
    return String(await readFile(file));
  }
  const csv = await fetch(`${exportURL}&gid=${g}`).then((res) => res.text());
  await mkdirSync(dirname(file), { recursive: true });
  await writeFile(file, csv);
  return csv;
};

const fromCSV = async (csv: string, grid: Grid) => {
  const ret: any = {};
  const pickList = (cell: string, splitter = /[~=)*]/) => {
    return cell
      .split("\n")
      .map((v) => trim(v.trim()))
      .filter((v: string) => v && !(v.startsWith("*") || v.startsWith("(") || v.endsWith(".")))
      .map((w: string) =>
        w
          .split(splitter)
          .filter((v) => v)
          .map((v) => v.replace(/([0-9]+\. ?)?([^(]+)(.+)?/, "$2").trim())
          .filter((v) => v && !(v.startsWith("(") || v.startsWith("[") || v === "S1")),
      );
  };

  const pickMainStats = (cell: string) => {
    return cell
      .split("\n")
      .map((v) => trim(v.trim(), "*"))
      .filter((v: string) => v && !(v.startsWith("*") || v.startsWith("(") || v.endsWith(".")))
      .reduce((ret, v: string) => {
        const parts = v.split("-");

        if (parts.length !== 2) {
          return ret;
        }

        return {
          ...ret,
          [parts[0].trim().toLowerCase()]: parts[1].trim(),
        };
      }, {});
  };

  return new Promise<{ [k: string]: any }>((resolve) => {
    let scope = "";
    let partIdx = 0;

    parseString(csv)
      .on("end", () => {
        resolve(ret);
      })
      .on("data", (row) => {
        if (row.indexOf("EQUIPMENT") > -1 || row.indexOf("EQUIPMENTS") > -1) {
          scope = row[1];

          switch (scope.toUpperCase()) {
            case "CHILDE":
              scope = "tartaglia";
              break;
            case "KOKOMI":
              scope = "sangonomiya_kokomi";
              break;
            case "TRAVELER":
              scope = `${scope} ${Grid[grid]}`;
              break;
          }

          partIdx = 0;
        }

        if (scope != "" && partIdx >= 2) {
          if (row[1] !== "") {
            // scope done
            scope = "";
            return;
          }

          const role = row[2].replace("✩", "").split("\n")[0].trim();
          const recommended = row[2].indexOf("✩") > -1;

          if (!role) {
            return;
          }

          ret[pascalCase(scope)] = [
            ...(ret[pascalCase(scope)] || []),
            characterBuild(scope, {
              recommended: recommended,
              name: scope,
              role: role,
              weapons: pickList(row[3]).flat(),
              artifacts: pickList(row[4], /[~=)*/]/),
              mainStats: pickMainStats(row[5]),
              subStats: pickList(row[6]).flat(),
              talent: pickList(row[7]).flat(),
            }),
          ];
        }

        partIdx++;
      });
  });
};

export let Builds: { [key: string]: Array<ReturnType<typeof characterBuild>> } = {
  KamisatoAyato: [
    {
      Recommended: false,
      Role: "DPS",
      Weapons: ["西风剑"],
      ArtifactMainPropTypes: {
        EQUIP_SHOES: [
          FightProp[FightProp.FIGHT_PROP_HP_PERCENT],
        ],
        EQUIP_RING: [
          FightProp[FightProp.FIGHT_PROP_WATER_ADD_HURT],
        ],
        EQUIP_DRESS: [
          FightProp[FightProp.FIGHT_PROP_CRITICAL],
        ],
      },
      ArtifactAffixPropTypes: [
        FightProp[FightProp.FIGHT_PROP_ATTACK_PERCENT],
        FightProp[FightProp.FIGHT_PROP_ATTACK],
        FightProp[FightProp.FIGHT_PROP_CHARGE_EFFICIENCY],
        FightProp[FightProp.FIGHT_PROP_CRITICAL],
        FightProp[FightProp.FIGHT_PROP_CRITICAL_HURT],
      ],
      ArtifactSetPairs: [
        ["角斗士的终幕礼"],
      ],
      SkillPriority: [["E"], ["Q"]],
    },
  ],
};

for (const p of [Grid.Pyro, Grid.Anemo, Grid.Electro, Grid.Cryo, Grid.Hydro, Grid.Geo]) {
  Builds = {
    ...Builds,
    ...(await fromCSV(await loadOrSync(p), p)),
  };
}
