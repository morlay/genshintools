import { i18n, i18nForName } from "./text";
import materialExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/MaterialExcelConfigData.json";
import materialSourceDataExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/MaterialSourceDataExcelConfigData.json";
import dungeonExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/DungeonExcelConfigData.json";
import dailyDungeonConfigData from "../../vendordata/GenshinData/ExcelBinOutput/DailyDungeonConfigData.json";
import { forEach, has } from "lodash";

const dungeonAndDropDays = () => {
  const dungeonOpenDays: {
    [s: string]: {
      Name: ReturnType<typeof i18n>;
      DropWeekdays?: number[];
    };
  } = {};

  dailyDungeonConfigData.forEach((item) => {
    forEach(item, (ids, key) => {
      const append = (day: number) => {
        forEach(typeof ids === "number" ? [ids] : ids, (id) => {
          if (!dungeonOpenDays[id]) {
            const d = dungeonExcelConfigData.find((d) => d.Id === id);
            if (!d) {
              return null;
            }

            dungeonOpenDays[id] = {
              Name: i18n(d.DisplayNameTextMapHash),
            };
          }

          dungeonOpenDays[id] = {
            ...dungeonOpenDays[id],
            DropWeekdays: [...(dungeonOpenDays[id].DropWeekdays || []), day].sort(),
          };
        });
      };

      const m: any = {
        Monday: 1,
        Tuesday: 2,
        Wednesday: 3,
        Thursday: 4,
        Friday: 5,
        Saturday: 6,
        Sunday: 0,
      };

      if (has(m, key)) {
        append(m[key]);
      }
    });
  });

  return dungeonOpenDays;
};

const openDays = dungeonAndDropDays();

export const material = (id: number) => {
  const m = materialExcelConfigData.find((a) => a.Id == id)!;

  const dungeonId = materialSourceDataExcelConfigData.find((i) => i.Id === m.Id)!.DungeonList[0];

  return {
    Name: i18nForName(m.NameTextMapHash),
    RankLevel: m.RankLevel,
    Dungeon: dungeonId ? openDays[dungeonId] : undefined,
  };
};

export const usedMaterials: any = {};

export const materialNameID = (id: number) => {
  const m = material(id);
  usedMaterials[m.Name.ID] = m;
  return m.Name.ID;
};

export const materials = () => {
  return materialExcelConfigData.reduce((ret, item) => {
    const dungeonId = materialSourceDataExcelConfigData.find((i) => i.Id === item.Id)!.DungeonList[0];

    const m = {
      Name: i18nForName(item.NameTextMapHash),
      RankLevel: item.RankLevel,
      Dungeon: dungeonId ? openDays[dungeonId] : undefined,
    };

    return {
      ...ret,
      [m.Name.ID]: m,
    };
  }, {});
};
