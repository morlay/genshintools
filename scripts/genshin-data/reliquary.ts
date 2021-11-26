import { Dictionary, groupBy, map, mapValues, pick, reduce, uniq, values } from "lodash";
import { i18n } from "./text";
import reliquaryExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryExcelConfigData.json";
import reliquaryMainPropExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryMainPropExcelConfigData.json";
import reliquaryAffixExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryAffixExcelConfigData.json";
import reliquarySetExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquarySetExcelConfigData.json";
import reliquaryLevelExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ReliquaryLevelExcelConfigData.json";
import { addPropSet, createIndexes, equipAffixes } from "./utils";

export const reliquarySets = (): Dictionary<{
  Id: number;
  Name: ReturnType<typeof i18n>;
  EquipAffixes: ReturnType<typeof equipAffixes>;
}> => {
  return reliquarySetExcelConfigData.reduce(
    (ret, reliquarySet) => ({
      ...ret,
      [reliquarySet.SetId]: (() => {
        const affixes = equipAffixes(reliquarySet.EquipAffixId || 0);

        if (affixes.length > 0) {
          return {
            Id: reliquarySet.SetId,
            Name: affixes[0].Name,
            EquipAffixes: reliquarySet.SetNeedNum.map((v, i) => ({
              ...affixes[i],
              NeedNum: v,
            })),
          };
        }
        return {};
      })(),
    }),
    {},
  );
};

const reliquaryAffixDepots = () =>
  mapValues(
    groupBy(reliquaryAffixExcelConfigData, (a) => a.DepotId),
    (reliquaryAffixes) =>
      reduce(
        reliquaryAffixes,
        (ret, c) => ({
          ...ret,
          [c.PropType]: [...(ret[c.PropType] || []), c.PropValue],
        }),
        {} as Record<string, number[]>,
      ),
  );

const reliquaryAddProps = () => {
  return new Array(5)
    .fill(0)
    .map((_, idx) => reliquaryLevelExcelConfigData.filter((a) => a.Rank == idx + 1).map((v) => addPropSet(v.AddProps)));
};

export const reliquaries = () => {
  const sets = reliquarySets();
  const affixDepots = reliquaryAffixDepots();

  const setIDs: string[] = [];
  const appendPropDepotIds: string[] = [];

  const reliquaries = reliquaryExcelConfigData.reduce((ret, a) => {
    if (!a.SetId || !(sets as any)[a.SetId]) {
      return ret;
    }

    const name = i18n(a.NameTextMapHash);
    const desc = i18n(a.DescTextMapHash);

    if (name.CHS.startsWith("测试") || desc.CHS == "") {
      return ret;
    }

    const d = {
      AppendPropNum: a.AppendPropNum,
      AppendPropDepotId: a.AppendPropDepotId,
      MainPropTypes: reliquaryMainPropExcelConfigData
        .filter((c) => c.PropDepotId == a.MainPropDepotId)
        .map((c) => c.PropType),
    };

    const r = {
      Id: a.Id,
      EquipType: a.EquipType,
      RankLevel: a.RankLevel,
      Name: name,
      Desc: desc,
      MaxLevel: a.MaxLevel,
      SetId: a.SetId,
      ...d,
    };

    const uuid = r.Id || `${r.Name.CHS}/${a.RankLevel}`;

    if (desc.CHS.endsWith("专用")) {
      return ret;
    }

    if (ret[uuid]) {
      if (`${d.AppendPropDepotId}`[0] != "9" && ret[uuid].AppendPropDepotId != d.AppendPropDepotId) {
        appendPropDepotIds.push(a.AppendPropDepotId);

        ret[uuid].OtherDepots = [...(ret[uuid].OtherDepots || []), ...(d as any)];
      }

      return ret;
    }

    setIDs.push(a.SetId);
    appendPropDepotIds.push(a.AppendPropDepotId);

    return {
      ...ret,
      [r.Id]: r,
    };
  }, {});

  const finalReliquarySets = pick(sets, setIDs);

  return {
    Reliquaries: reliquaries,
    ReliquaryIndexes: createIndexes(reliquaries),
    ReliquarySets: finalReliquarySets,
    ReliquarySetIndexes: createIndexes(finalReliquarySets),
    ReliquaryAffixDepots: pick(affixDepots, appendPropDepotIds),
    ReliquaryAddProps: reliquaryAddProps(),
  };
};
