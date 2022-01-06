import { has, keys, last, uniq } from "lodash-es";
import { groupOne, i18n, i18nWithKey } from "./common";
import { EnemyDropTagAliases } from "./domain_enemy";

const weekdays: any = {
  Monday: 1,
  Tuesday: 2,
  Wednesday: 3,
  Thursday: 4,
  Friday: 5,
  Saturday: 6,
  Sunday: 0,
};

export const DungeonOpenWeekdays = (
  await import("../../vendordata/GenshinData/ExcelBinOutput/DailyDungeonConfigData.json")
).default.reduce((dungeonOpenWeekdays, item) => {
  keys(item).forEach((key) => {
    if (has(weekdays, key)) {
      ((item as any)[key] as number[]).forEach((dungeonID) => {
        dungeonOpenWeekdays[dungeonID] = uniq([...(dungeonOpenWeekdays[dungeonID] || []), weekdays[key]]).sort();
      });
    }
  });
  return dungeonOpenWeekdays;
}, {} as { [DungeonId: number]: number[] });

export const Dungeons = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/DungeonExcelConfigData.json")).default,
  (t) => {
    const v = {
      Id: t.Id,
      Name: i18nWithKey(t.NameTextMapHash),
      DisplayName: i18nWithKey(t.DisplayNameTextMapHash),
      Type: t.Type,
      OpenWeekdays: DungeonOpenWeekdays[t.Id],
    };

    if (t.Type == "DUNGEON_PLOT" || v.Name.CHS.indexOf("test") > -1) {
      return null;
    }

    return v;
  },
  "Id",
);

export const MaterialSources = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/MaterialSourceDataExcelConfigData.json")).default,
  (t) => {
    const sources = t.TextList.map((v) => i18n(v)).filter((n) => !!n.CHS);
    let dropTags: string[] = [];
    let dropFromRarity = "";

    sources.forEach((s) => {
      if (s.CHS.endsWith("掉落")) {
        const dropTagGroup: string = last(s.CHS.split("以上"))?.replace(/(少量)?掉落$/, "") || "";
        if (EnemyDropTagAliases[dropTagGroup]) {
          dropTags = [...dropTags, ...EnemyDropTagAliases[dropTagGroup].Tags];
          dropFromRarity = EnemyDropTagAliases[dropTagGroup].MonsterRarity;
          return;
        }
        console.log(`unknown drop tag ${dropTagGroup}`, s);
      }
      if (s.CHS.endsWith("挑战奖励")) {
        let dropTagGroup: string = last(s.CHS.split("以上"))?.replace(/挑战奖励$/, "") || "";
        if (dropTagGroup === "【征讨领域和北风的王狼】") {
          dropTagGroup = "BOSS";
        }
        if (EnemyDropTagAliases[dropTagGroup]) {
          dropTags = [...dropTags, ...EnemyDropTagAliases[dropTagGroup].Tags];
          dropFromRarity = EnemyDropTagAliases[dropTagGroup].MonsterRarity;
          return;
        }
        console.log(`unknown drop tag ${dropTagGroup}`, s);
      }
    });

    return {
      DropFromTags: uniq(dropTags).sort(),
      DropFromRarity: dropFromRarity,
      DungeonId: Dungeons[t.DungeonList[0]]?.Id,
      Sources: sources,
    };
  },
  "Id",
);

export const Materials = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/MaterialExcelConfigData.json")).default,
  (m) => {
    const n = i18nWithKey(m.NameTextMapHash);

    if (n.CHS.includes("test")) {
      return null;
    }

    let s = MaterialSources[m.Id];

    if (n.CHS.endsWith("禽肉")) {
      s = {
        ...s,
        DropFromTags: ["鸟类"],
      };
    }

    if (n.CHS.endsWith("兽肉")) {
      s = {
        ...s,
        DropFromTags: ["走兽"],
      };
    }

    if (n.CHS.endsWith("鱼肉")) {
      s = {
        ...s,
        DropFromTags: ["水族"],
      };
    }

    return {
      ...s,
      Id: m.Id,
      Name: n,
      Desc: i18n(m.DescTextMapHash),
      Rarity: m.RankLevel || 0,
      Rank: m.Rank || 0,
      MaterialType: m.MaterialType || "",
    };
  },
  "Id",
);
