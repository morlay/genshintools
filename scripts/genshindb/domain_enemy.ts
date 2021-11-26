import { groupOne, i18nWithID, i18n, createIndexes } from "./common";
import { mapKeys, mapValues, reduce, uniq, values } from "lodash-es";

export const MonsterRelationships = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/MonsterRelationshipExcelConfigData.json")).default,
  (t) => ({
    DropTag: t.TagStr,
    MonsterRarity: t.MonsterRarity,
  }),
  "Id",
);

export const MonsterTitles = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/MonsterTitleExcelConfigData.json")).default,
  (t) => i18nWithID(t.TitleNameTextMapHash),
  "TitleID",
);

export const MonsterSpecialNames = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/MonsterSpecialNameExcelConfigData.json")).default,
  (t) => i18nWithID(t.SpecialNameTextMapHash),
  "SpecialNameLabID",
);

export const MonsterDescribes = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/MonsterDescribeExcelConfigData.json")).default,
  (t) => {
    return {
      DropTag: MonsterRelationships[t.Id]?.DropTag,
      MonsterRarity: MonsterRelationships[t.Id]?.MonsterRarity,
      SpecialName: MonsterSpecialNames[t.SpecialNameLabID],
      Title: MonsterTitles[t.TitleID],
      Name: i18nWithID(t.NameTextMapHash),
    };
  },
  "Id",
);

export const Enemies = mapKeys(
  reduce(
    (await import("../../vendordata/GenshinData/ExcelBinOutput/MonsterExcelConfigData.json")).default,
    (ret, t) => {
      if (!t.DescribeId) {
        return ret;
      }

      if (!MonsterDescribes[t.DescribeId]) {
        // console.log(`invalid ${JSON.stringify(i18nWithID(t.NameTextMapHash))}`);
        return ret;
      }

      const b = {
        ...MonsterDescribes[t.DescribeId],
        Name: MonsterDescribes[t.DescribeId].Name || i18nWithID(t.NameTextMapHash),
        Type: t.Type,
        SecurityLevel: t.SecurityLevel,
        Id: t.Id,
      };

      // ignores
      if (
        {
          treasure_hoarders_liuliu: true,
          treasure_hoarders_boss: true,
          treasure_hoarders_carmen: true,
        }[b.Name.ID]
      ) {
        return ret;
      }

      return {
        ...ret,
        [b.Name.ID]: b,
      };
    },
    {} as any,
  ),
  (v) => v.Id,
);

const enemyIndexes = createIndexes(Enemies);

export const findEnemy = (id: string) => {
  return Enemies[enemyIndexes[id]];
};

export const EnemyDropTags = uniq(values(mapValues(MonsterRelationships, (d) => d.DropTag)));

const MonsterRarities: { [k: string]: string } = {};

export const EnemyDropTagAliases: { [k: string]: { Tags: string[]; MonsterRarity: string } } = reduce(
  values(Enemies),
  (ret, m) =>
    m.DropTag
      ? {
          ...ret,
          [m.DropTag]: {
            MonsterRarity: (MonsterRarities[m.MonsterRarity] = m.MonsterRarity),
            Tags: [m.DropTag],
          },
          [m.Name.CHS]: {
            MonsterRarity: m.MonsterRarity,
            Tags: [m.DropTag],
          },
          ["BOSS"]:
            m.MonsterRarity == "MONSTER_RARITY_BIG_BOSS_MONSTER"
              ? {
                  MonsterRarity: m.MonsterRarity,
                  Tags: [...((ret as any)["BOSS"] ? (ret as any)["BOSS"].Tags : []), m.DropTag],
                }
              : (ret as any)["BOSS"],
        }
      : ret,
  mapValues(
    {
      射手类丘丘人: ["远程丘丘人"],
      大体格丘丘人: ["丘丘暴徒", "丘丘岩盔王"],
      兽境之狼: ["兽境幼兽", "兽境猎犬"],
      遗迹机兵: ["遗迹守卫", "遗迹重机", "拟生机关"],
      雷萤术士: ["雷萤"],
      "愚人众·萤术士": ["召唤师"],
      盗宝团成员: ["盗宝团"],
      "愚人众·冬国仕女": ["藏镜侍女"],
      野伏众: ["浪人武士"],
    },
    (tags) => {
      const e = values(Enemies).find((e) => tags.indexOf(e.DropTag) > -1);

      return {
        MonsterRarity: e ? e.MonsterRarity : "MONSTER_RARITY_SMALL_ENV_ANIMAL",
        Tags: tags,
      };
    },
  ),
);

console.log(MonsterRarities);
