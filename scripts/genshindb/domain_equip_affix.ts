import { addPropSet, i18n, i18nWithID, groupMulti, cleanText } from "./common";

export const EquipAffixes = groupMulti(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/EquipAffixExcelConfigData.json")).default,
  (a) => ({
    Id: a.Id,
    Name: i18nWithID(a.NameTextMapHash),
    Desc: i18n(a.DescTextMapHash, cleanText),
    Level: a.Level,
    AddProps: addPropSet(a.AddProps),
    Params: a.ParamList,
  }),
  "Id",
);