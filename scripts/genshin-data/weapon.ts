import weaponExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/WeaponExcelConfigData.json";
import weaponPromoteExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/WeaponPromoteExcelConfigData.json";
import weaponCurveExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/WeaponCurveExcelConfigData.json";
import { addPropSet, createIndexes, equipAffixes, propGrowCurveFor } from "./utils";
import { chsText, i18n, i18nForName } from "./text";
import { material, materialNameID } from "./material";
import { Dictionary } from "lodash";

const weaponPropGrowCurve = (growCurve: string) => {
  return weaponCurveExcelConfigData
    .filter((a) => a.Level <= 90)
    .map((a) => {
      return a.CurveInfos.find((i) => i.Type == growCurve)?.Value || 0;
    });
};

const weaponPromotes = (weaponPromoteId: number) => {
  const p = weaponPromoteExcelConfigData.filter((a) => a.WeaponPromoteId == weaponPromoteId);

  return p.map((a, i) => ({
    MinLevel: i > 0 ? p[i - 1]?.UnlockMaxLevel : 1,
    UnlockMaxLevel: a.UnlockMaxLevel,
    CoinCost: a.CoinCost || 0,
    MaterialCosts: a.CostItems.filter((item: any) => item.Id).map((item: any) => ({
      MaterialNameID: materialNameID(item.Id),
      Count: item.Count,
    })),
    AddProps: addPropSet(a.AddProps),
  }));
};

export const weapons = () => {
  const ws = weaponExcelConfigData
    .map((a) => {
      const name = chsText(a.NameTextMapHash);

      if (name == "" || name.startsWith("(test)")) {
        return null;
      }

      return {
        Id: a.Id,
        Name: i18nForName(a.NameTextMapHash),
        Desc: i18n(a.DescTextMapHash),
        RankLevel: a.RankLevel,
        WeaponType: a.WeaponType,
        Promotes: weaponPromotes(a.WeaponPromoteId),
        Affixes: a.SkillAffix.filter((v) => v !== 0)
          .map((id) => equipAffixes(id))
          .filter((v) => !!v),
        PropGrowCurves: ((a.WeaponProp as any) || [])
          .filter((a: any) => a.PropType)
          .reduce(
            (ret: any, prop: any) => ({
              ...ret,
              [prop.PropType]: propGrowCurveFor(weaponPropGrowCurve)(prop.Type, prop.InitValue),
            }),
            {},
          ),
      };
    })
    .filter((a) => !!a)
    .reduce(
      (ret, a) => ({
        ...ret,
        [a!.Id]: a,
      }),
      {} as Dictionary<{
        Id: number;
        Name: ReturnType<typeof i18n>;
        Desc: ReturnType<typeof i18n>;
        RankLevel: number;
        WeaponType: string;
      }>,
    );

  return {
    Weapons: ws,
    WeaponIndexes: createIndexes(ws),
  };
};
