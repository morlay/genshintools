import avatarExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarExcelConfigData.json";
import trialAvatarExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/TrialAvatarExcelConfigData.json";
import weaponExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/WeaponExcelConfigData.json";
import reliquaryExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryExcelConfigData.json";
import { forEach, mapValues, pick, uniq, values } from "lodash-es";
import reliquaryMainPropExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryMainPropExcelConfigData.json";

import { i18n } from "./common";
import { ArtifactSets } from "./domain_artifact";

const positions = ["EQUIP_BRACER", "EQUIP_NECKLACE", "EQUIP_SHOES", "EQUIP_RING", "EQUIP_DRESS"];

export const Trials = (() => {
  const trialWeapons = trialAvatarExcelConfigData.reduce((trials, item) => {
    const a = avatarExcelConfigData.find((a) => a.Id === item.TrialAvatarParamList[0])!;
    const w = weaponExcelConfigData.find((a) => a.Id === item.TrialWeaponParamList[0])!;

    const name = i18n(a.NameTextMapHash).CHS;

    return {
      ...trials,
      [name]: uniq([...(trials[name] || []), i18n(w.NameTextMapHash).CHS]),
    };
  }, {} as { [k: string]: string[] });

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

  return mapValues(trialWeapons, (w, name) => {
    const o = trials[name];

    return {
      Weapons: w,
      ArtifactSetPairs: o
        ? [uniq(values(pick(o, positions)).map((o) => o.SetId)).map((setID) => ArtifactSets[setID].Name.CHS)]
        : [],
      ArtifactMainPropTypes: 0
        ? mapValues(
            {
              EQUIP_SHOES: [],
              EQUIP_RING: [],
              EQUIP_DRESS: [],
            },
            (_, k) => [o[k].MainPropType],
          )
        : {},
    };
  });
})();
