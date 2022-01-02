import fetch from "node-fetch";
import { parseString } from "@fast-csv/parse";
import { writeFile, readFile } from "fs/promises";
import { existsSync } from "fs";
import { snakeCase } from "lodash-es";
import { characterBuild } from "./genshindb/character_build";

const sheet = "https://docs.google.com/spreadsheets/d/1gNxZ2xab1J6o1TuNVWMeLOZ7TPOqrsf3SshP5DLvKzI";
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
  const file = `./vendordata/${Grid[g]}-${g}.csv`;
  if (existsSync(file)) {
    return String(await readFile(file));
  }
  const csv = await fetch(`${exportURL}&gid=${g}`).then((res) => res.text());
  await writeFile(file, csv);
  return csv;
};

const fromCSV = async (csv: string, grid: Grid) => {
  const ret: any = {};
  const pickList = (cell: string, splitter = /[~=)*]/) => {
    return cell
      .split("\n")
      .map((v) => v.trim())
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
      .map((v) => v.trim())
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

          const role = row[2].replace("⭐", "").split("\n")[0].trim();
          const recommended = row[2].indexOf("⭐") > -1;

          if (!(role && recommended)) {
            return;
          }

          ret[snakeCase(scope)] = characterBuild(scope, {
            recommended: recommended,
            name: scope,
            role: role,
            weapons: pickList(row[3]).flat(),
            artifacts: pickList(row[4], /[~=)*/]/),
            mainStats: pickMainStats(row[5]),
            subStats: pickList(row[6]).flat(),
            talent: pickList(row[7]).flat(),
          });
        }

        partIdx++;
      });
  });
};

let v: any = {
  yun_jin: {
    Role: "SUPPORT",
    Weapons: [],
    ArtifactMainPropTypes: {
      EQUIP_SHOES: ["FIGHT_PROP_CHARGE_EFFICIENCY"],
      EQUIP_RING: ["FIGHT_PROP_DEFENSE_PERCENT"],
      EQUIP_DRESS: ["FIGHT_PROP_DEFENSE_PERCENT"],
    },
    ArtifactAffixPropTypes: [
      "FIGHT_PROP_CHARGE_EFFICIENCY",
      "FIGHT_PROP_DEFENSE_PERCENT",
      "FIGHT_PROP_DEFENSE",
    ],
    ArtifactSetPairs: [
      ["华馆梦醒形骸记"],
    ],
    SkillPriority: [["Q"], ["E"]],
  },
  shenhe: {
    Role: "SUPPORT",
    Weapons: [],
    ArtifactMainPropTypes: {
      EQUIP_SHOES: ["FIGHT_PROP_CHARGE_EFFICIENCY"],
      EQUIP_RING: ["FIGHT_PROP_ATTACK_PERCENT"],
      EQUIP_DRESS: ["FIGHT_PROP_ATTACK_PERCENT"],
    },
    ArtifactAffixPropTypes: [
      "FIGHT_PROP_CHARGE_EFFICIENCY",
      "FIGHT_PROP_ATTACK_PERCENT",
      "FIGHT_PROP_ATTACK",
    ],
    ArtifactSetPairs: [],
    SkillPriority: [["Q"], ["E"]],
  },
};

for (const p of [Grid.Pyro, Grid.Anemo, Grid.Electro, Grid.Cryo, Grid.Hydro, Grid.Geo]) {
  v = {
    ...v,
    ...(await fromCSV(await loadOrSync(p), p)),
  };
}

await writeFile(
  "./scripts/genshindb/character_build_recommended.ts",
  `
export const builds = ${JSON.stringify(v, null, 2)}

export const characterBuildRecommended = (nameID: string) => {
  if (!(builds as any)[nameID]) {
    console.log("missing character build", nameID)
  }
  return (builds as any)[nameID]
}
`,
);
