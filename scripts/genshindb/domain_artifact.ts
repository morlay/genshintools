import { addPropSet, createIndexes, groupMulti, groupOne, i18n, i18nWithID } from "./common";
import { EquipAffixes } from "./domain_equip_affix";
import { groupBy, mapKeys, mapValues, reduce } from "lodash-es";

export const ArtifactSets = groupOne(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/ReliquarySetExcelConfigData.json")).default,
  (artifactSet) => {
    const affixes = EquipAffixes[artifactSet.EquipAffixId || 0] || [];

    if (affixes.length == 0) {
      return null;
    }

    return {
      Id: artifactSet.SetId,
      Name: affixes[0].Name,
      EquipAffixes: artifactSet.SetNeedNum.map((v, i) => ({
        ...affixes[i],
        ActiveWhenNum: v,
      })),
    };
  },
  "SetId",
);

export const ArtifactAppendPropDepots = mapValues(
  groupBy(
    (await import("../../vendordata/GenshinData/ExcelBinOutput/ReliquaryAffixExcelConfigData.json")).default,
    (a) => a.DepotId,
  ),
  (artifactAffixDepots) =>
    reduce(
      artifactAffixDepots,
      (ret, c) => ({
        ...ret,
        [c.PropType]: [...(ret[c.PropType] || []), c.PropValue],
      }),
      {} as Record<string, number[]>,
    ),
);

export const ArtifactMainPropDepots = groupMulti(
  (await import("../../vendordata/GenshinData/ExcelBinOutput/ReliquaryMainPropExcelConfigData.json")).default,
  (d) => d.PropType,
  "PropDepotId",
);

const artifactLevelExcelConfigData = (
  await import("../../vendordata/GenshinData/ExcelBinOutput/ReliquaryLevelExcelConfigData.json")
).default;

export const ArtifactLevelupExps = new Array(5)
  .fill(0)
  .map((_, idx) => artifactLevelExcelConfigData.filter((a) => a.Rank == idx + 1).map((v) => v.Exp || 0));

export const ArtifactLevelupMainPropValues = new Array(5)
  .fill(0)
  .map((_, idx) => artifactLevelExcelConfigData.filter((a) => a.Rank == idx + 1).map((v) => addPropSet(v.AddProps)));

const artifactExcelConfigData = (
  await import("../../vendordata/GenshinData/ExcelBinOutput/ReliquaryExcelConfigData.json")
).default;

export const Artifacts = mapKeys(
  mapKeys(
    groupOne(
      artifactExcelConfigData,
      (a) => {
        if (!a.SetId || !ArtifactSets[a.SetId]) {
          return null;
        }

        const set = ArtifactSets[a.SetId];

        if (set.Name.CHS == "冰之川与雪之砂") {
          return null;
        }

        if (a.RankLevel === 5) {
          if (i18nWithID(a.NameTextMapHash).CHS.startsWith("祭")) {
            return null;
          }
          if (`${a.SetId}`[1] == "0") {
            return null;
          }
        }

        const name = i18nWithID(a.NameTextMapHash);
        const desc = i18n(a.DescTextMapHash);

        if (name.CHS.startsWith("测试") || desc.CHS == "") {
          return null;
        }

        if (desc.CHS.endsWith("专用") || desc.CHS.indexOf("待定") > -1) {
          return null;
        }

        return {
          Id: a.Id,
          EquipType: a.EquipType,
          Rarity: a.RankLevel,
          Name: name,
          Desc: desc,
          MaxLevel: a.MaxLevel,
          SetId: a.SetId,
          AppendPropNum: a.AppendPropNum,
          MainPropDepotId: a.MainPropDepotId,
          AppendPropDepotId: a.AppendPropDepotId,
        };
      },
      "Id",
    ),
    (a) => `${a.Name.ID}/${a.Rarity}`,
  ),
  (a) => a.Id,
);

const artifactSetIndexes = createIndexes(ArtifactSets);

export const findArtifactSet = (id: string) => {
  return ArtifactSets[artifactSetIndexes[id]];
};
