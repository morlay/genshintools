import avatarExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarExcelConfigData.json";
import weaponExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/WeaponExcelConfigData.json";
import trialAvatarExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/TrialAvatarExcelConfigData.json";
import reliquaryExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryExcelConfigData.json";
import { i18n } from "./text";
import { forEach, mapValues, pick, uniq, values } from "lodash";
import { reliquarySets } from "./reliquary";
import reliquaryMainPropExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryMainPropExcelConfigData.json";

const positions = ["EQUIP_BRACER", "EQUIP_NECKLACE", "EQUIP_SHOES", "EQUIP_RING", "EQUIP_DRESS"];

export const trials = () => {
  const trialWeapons = trialAvatarExcelConfigData.reduce((trials, item) => {
    const a = avatarExcelConfigData.find((a) => a.Id === item.TrialAvatarParamList[0])!;
    const w = weaponExcelConfigData.find((a) => a.Id === item.TrialWeaponParamList[0])!;

    const name = i18n(a.NameTextMapHash).CHS;

    return {
      ...trials,
      [name]: uniq([...(trials[name] || []), i18n(w.NameTextMapHash).CHS]),
    };
  }, {} as { [k: string]: string[] });

  const sets = reliquarySets();

  const trials: any = {};

  forEach(reliquaryExcelConfigData, (r) => {
    const desc = i18n(r.DescTextMapHash);
    const mainPropTypes = reliquaryMainPropExcelConfigData
      .filter((c) => c.PropDepotId == r.MainPropDepotId)
      .map((c) => c.PropType);

    if (!desc.CHS.endsWith("专用")) {
      return;
    }

    let actor = desc.CHS.replace("专用", "");

    if (actor === "一斗") {
      actor = "荒泷一斗";
    }

    if (actor != "默认") {
      if (!trials[actor]) {
        trials[actor] = {};
      }
      if (!trials[actor][r.EquipType]) {
        trials[actor][r.EquipType] = {};
      }

      trials[actor][r.EquipType] = {
        SetId: r.SetId,
        MainPropType: mainPropTypes.join(","),
      };
    }
  });

  return mapValues(trials, (o, name) => {
    return {
      Weapons: trialWeapons[name],
      Set: uniq(values(pick(o, positions)).map((o) => o.SetId)).map((setID) => sets[setID].Name.CHS),
      MainPropTypes: values(pick(o, positions)).map((o) => o.MainPropType),
    };
  });
};
