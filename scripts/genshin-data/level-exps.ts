import avatarLevelExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarLevelExcelConfigData.json";
import weaponLevelExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/WeaponLevelExcelConfigData.json";
import reliquaryLevelExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryLevelExcelConfigData.json";

const levelExpAvatar = () => avatarLevelExcelConfigData.map((v) => v.Exp);

const levelExpWeapon = () =>
  new Array(5).fill(0).map((_, i) => {
    return weaponLevelExcelConfigData.map((v) => v.RequiredExps[i]);
  });

const levelExpReliquary = () =>
  new Array(5)
    .fill(0)
    .map((_, idx) => reliquaryLevelExcelConfigData.filter((a) => a.Rank == idx + 1).map((v) => v.Exp || 0));

export const levelExps = () => {
  return {
    Avatar: levelExpAvatar(),
    Weapon: levelExpWeapon(),
    Reliquary: levelExpReliquary(),
  };
};
