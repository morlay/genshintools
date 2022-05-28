import {addPropSet, createIndexes, groupMulti, groupOne, i18n, i18nWithKey} from "./common";
import {EquipAffixes} from "./domain_equip_affix";
import {groupBy, mapKeys, mapValues, reduce} from "lodash-es";
import {
    ReliquaryAffixExcelConfigData,
    ReliquaryExcelConfigData,
    ReliquaryLevelExcelConfigData,
    ReliquaryMainPropExcelConfigData,
    ReliquarySetExcelConfigData,
} from "./sources";

export const ArtifactSets = groupOne(
    ReliquarySetExcelConfigData,
    (artifactSet) => {
        const affixes = EquipAffixes[artifactSet.EquipAffixId || 0] || [];

        if (affixes.length == 0) {
            return null;
        }

        return {
            Id: artifactSet.setId,
            Name: affixes[0].Name,
            EquipAffixes: artifactSet.setNeedNum.map((v, i) => ({
                ...affixes[i],
                ActiveWhenNum: v,
            })),
        };
    },
    "setId",
);

export const ArtifactSetsByKey = mapKeys(ArtifactSets, (s) => s.Name.KEY);

export const ArtifactAppendPropDepots = mapValues(
    groupBy(ReliquaryAffixExcelConfigData, (a) => a.depotId),
    (artifactAffixDepots) =>
        reduce(
            artifactAffixDepots,
            (ret, c) => ({
                ...ret,
                [c.propType]: [...(ret[c.propType] || []), c.propValue],
            }),
            {} as Record<string, number[]>,
        ),
);

export const ArtifactMainPropDepots = groupMulti(ReliquaryMainPropExcelConfigData, (d) => d.propType, "propDepotId");

const artifactLevelExcelConfigData = ReliquaryLevelExcelConfigData;

export const ArtifactLevelupExps = new Array(5)
    .fill(0)
    .map((_, idx) => artifactLevelExcelConfigData.filter((a) => a.rank == idx + 1).map((v) => v.exp || 0));

export const ArtifactLevelupMainPropValues = new Array(5)
    .fill(0)
    .map((_, idx) => artifactLevelExcelConfigData.filter((a) => a.rank == idx + 1).map((v) => addPropSet(v.addProps)));

export const Artifacts = mapKeys(
    mapKeys(
        groupOne(
            ReliquaryExcelConfigData,
            (a) => {
                if (!a.setId || !ArtifactSets[a.setId]) {
                    return null;
                }

                const set = ArtifactSets[a.setId];

                if (set.Name.CHS == "冰之川与雪之砂") {
                    return null;
                }

                if (a.rankLevel === 5) {
                    if (i18nWithKey(a.nameTextMapHash).CHS.startsWith("祭")) {
                        return null;
                    }
                    if (`${a.setId}`[1] == "0") {
                        return null;
                    }
                }

                const name = i18nWithKey(a.nameTextMapHash);
                const desc = i18n(a.descTextMapHash);

                if (name.CHS.startsWith("测试") || desc.CHS == "") {
                    return null;
                }

                if (desc.CHS.endsWith("专用") || desc.CHS.indexOf("待定") > -1) {
                    return null;
                }

                return {
                    Id: a.id,
                    EquipType: a.equipType,
                    Rarity: a.rankLevel,
                    Name: name,
                    Icon: a.icon || "",
                    Desc: desc,
                    MaxLevel: a.maxLevel,
                    SetKey: ArtifactSets[a.setId].Name.KEY,
                    AppendPropNum: a.appendPropNum,
                    MainPropDepotId: a.mainPropDepotId,
                    AppendPropDepotId: a.appendPropDepotId,
                };
            },
            "id",
        ),
        (a) => `${a.Name.KEY}/${a.Rarity}`,
    ),
    (a) => a.Id,
);

const artifactSetIndexes = createIndexes(ArtifactSets);

export const findArtifactSet = (id: string) => {
    return ArtifactSets[artifactSetIndexes[id]];
};
