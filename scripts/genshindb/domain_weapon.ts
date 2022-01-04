import { addPropSet, createIndexes, groupMulti, groupOne, i18n, i18nWithID } from "./common";
import { Materials } from "./domain_material";
import { EquipAffixes } from "./domain_equip_affix";

export const WeaponPropGrowCurveValues = (
  await import("../../vendordata/GenshinData/ExcelBinOutput/WeaponCurveExcelConfigData.json")
).default
  .filter((a) => a.Level <= 90)
  .reduce((ret, a) => {
    return a.CurveInfos.reduce(
      (ret, info) => ({
        ...ret,
        [info.Type]: [...((ret as any)[info.Type] || []), info.Value],
      }),
      ret,
    );
  }, {} as { [k: string]: number[] });

export const WeaponPromotes = groupMulti(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/WeaponPromoteExcelConfigData.json")).default,
  (a) => {
    return {
      UnlockMaxLevel: a.UnlockMaxLevel,
      AddProps: addPropSet(a.AddProps),
      MaterialCosts: [
        ...a.CostItems.filter((item: any) => item.Id).map((item: any) => ({
          MaterialNameID: Materials[item.Id].Name.ID,
          Count: item.Count,
        })),
        ...(a.CoinCost
          ? [
              {
                MaterialNameID: "Mora",
                Count: a.CoinCost,
              },
            ]
          : []),
      ],
    };
  },
  "WeaponPromoteId",
);

const weaponLevelExcelConfigData = (
  await import("../../vendordata/GenshinData/ExcelBinOutput/WeaponLevelExcelConfigData.json")
).default;

export const WeaponLevelupExps = new Array(5).fill(0).map((_, i) => {
  return weaponLevelExcelConfigData.map((v) => v.RequiredExps[i]);
});

export const Weapons = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/WeaponExcelConfigData.json")).default,
  (a) => {
    const name = i18nWithID(a.NameTextMapHash);

    if (name.CHS == "" || name.CHS.indexOf("test") > -1) {
      return null;
    }

    return {
      Id: a.Id,
      Name: name,
      Desc: i18n(a.DescTextMapHash),
      Rarity: a.RankLevel,
      WeaponType: a.WeaponType,
      PromoteId: a.WeaponPromoteId,
      PropGrowCurveAndInitials: a.WeaponProp.filter((p: any) => p.PropType).reduce(
        (ret, curve) => ({
          ...ret,
          [curve.PropType as string]: {
            GrowCurve: curve.Type,
            Initial: curve.InitValue,
          },
        }),
        {},
      ),
      Affixes: a.SkillAffix.map((id) => EquipAffixes[id]).filter((v) => !!v),
    };
  },
  "Id",
);

const weaponIndexes = createIndexes(Weapons);

export const findWeapon = (id: string) => {
  return Weapons[weaponIndexes[id]];
};
