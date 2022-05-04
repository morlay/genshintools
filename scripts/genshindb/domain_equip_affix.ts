import {addPropSet, i18n, i18nWithKey, groupMulti, cleanText} from "./common";
import {resolveAndFixProps} from "./openconfig";
import {EquipAffixExcelConfigData} from "./sources";

export const EquipAffixes = groupMulti(
    EquipAffixExcelConfigData,
    (a) => {
        const desc = i18n(a.descTextMapHash, cleanText);

        return {
            Id: a.id,
            Name: i18nWithKey(a.nameTextMapHash),
            Desc: desc,
            Level: a.level,
            ...resolveAndFixProps(a.openConfig, desc.CHS, a.paramList, addPropSet(a.addProps)),
        };
    },
    "id",
);
