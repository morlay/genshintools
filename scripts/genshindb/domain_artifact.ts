import { addPropSet, createIndexes, groupMulti, groupOne, i18n, i18nWithKey } from "./common";
import { EquipAffixes } from "./domain_equip_affix";
import { groupBy, mapKeys, mapValues, reduce } from "lodash-es";

export const ArtifactSets = groupOne(
  (await import("../../GenshinData/ExcelBinOutput/ReliquarySetExcelConfigData.json")).default,
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

export const ArtifactSetsByKey = mapKeys(ArtifactSets, (s) => s.Name.KEY);

export const ArtifactAppendPropDepots = mapValues(
  groupBy(
    (await import("../../GenshinData/ExcelBinOutput/ReliquaryAffixExcelConfigData.json")).default,
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
  (await import("../../GenshinData/ExcelBinOutput/ReliquaryMainPropExcelConfigData.json")).default,
  (d) => d.PropType,
  "PropDepotId",
);

const artifactLevelExcelConfigData = (
  await import("../../GenshinData/ExcelBinOutput/ReliquaryLevelExcelConfigData.json")
).default;

export const ArtifactLevelupExps = new Array(5)
  .fill(0)
  .map((_, idx) => artifactLevelExcelConfigData.filter((a) => a.Rank == idx + 1).map((v) => v.Exp || 0));

export const ArtifactLevelupMainPropValues = new Array(5)
  .fill(0)
  .map((_, idx) => artifactLevelExcelConfigData.filter((a) => a.Rank == idx + 1).map((v) => addPropSet(v.AddProps)));

const artifactExcelConfigData = (
  await import("../../GenshinData/ExcelBinOutput/ReliquaryExcelConfigData.json")
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
          if (i18nWithKey(a.NameTextMapHash).CHS.startsWith("祭")) {
            return null;
          }
          if (`${a.SetId}`[1] == "0") {
            return null;
          }
        }

        const name = i18nWithKey(a.NameTextMapHash);
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
          SetKey: ArtifactSets[a.SetId].Name.KEY,
          AppendPropNum: a.AppendPropNum,
          MainPropDepotId: a.MainPropDepotId,
          AppendPropDepotId: a.AppendPropDepotId,
        };
      },
      "Id",
    ),
    (a) => `${a.Name.KEY}/${a.Rarity}`,
  ),
  (a) => a.Id,
);

const artifactSetIndexes = createIndexes(ArtifactSets);

export const findArtifactSet = (id: string) => {
  return ArtifactSets[artifactSetIndexes[id]];
};
