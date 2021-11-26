import equipAffixExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/EquipAffixExcelConfigData.json";
import { cleanText, i18n } from "./text";
import { Dictionary, reduce, snakeCase } from "lodash";

export const equipAffixes = (id: number) => {
  return equipAffixExcelConfigData
    .filter((a) => a.Id == id)
    .map((skillAffix) => {
      const name = i18n(skillAffix.NameTextMapHash);
      const desc = i18n(skillAffix.DescTextMapHash, cleanText);

      return {
        Name: name,
        Desc: desc,
        Level: skillAffix.Level,
        AddProps: addPropSet(skillAffix.AddProps),
        Params: skillAffix.ParamList,
        // ...paramModifies(skillAffix.OpenConfig),
      };
    });
};

export const addPropSet = (addProps: { PropType?: string; Value?: number }[]) => {
  return addProps
    .filter((p) => p.PropType)
    .reduce(
      (r: any, p: any) => ({
        ...r,
        [p.PropType]: p.Value || 0,
      }),
      {},
    );
};

export const propGrowCurveFor = (fn: (type: string) => number[]) => (type: string, base: number) => {
  return {
    Base: base,
    Values: fn(type),
  };
};

export const createIndexes = (sets: {
  [k: string]: { Name: { EN: string; CHS: string }; Id: number };
}): Dictionary<number> => {
  return reduce(
    sets,
    (indexes, s) => ({
      ...indexes,
      [s.Name.EN]: s.Id,
      [snakeCase(s.Name.EN)]: s.Id,
      [s.Name.CHS]: s.Id,
    }),
    {},
  );
};
