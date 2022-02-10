import { addPropSet, i18n, i18nWithKey, groupMulti, cleanText } from "./common";
import { resolveAndFixProps } from "./openconfig";

export const EquipAffixes = groupMulti(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/EquipAffixExcelConfigData.json")).default,
  (a) => {
    const desc = i18n(a.DescTextMapHash, cleanText);

    return ({
      Id: a.Id,
      Name: i18nWithKey(a.NameTextMapHash),
      Desc: desc,
      Level: a.Level,
      ...resolveAndFixProps(a.OpenConfig, desc.CHS, a.ParamList, addPropSet(a.AddProps)),
    });
  },
  "Id",
);

