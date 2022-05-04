import {addPropSet, createIndexes, groupMulti, groupOne, i18n, i18nWithKey} from "./common";
import {Materials, toMaterialCosts} from "./domain_material";
import {EquipAffixes} from "./domain_equip_affix";
import {mapKeys} from "lodash-es";
import {
    WeaponCurveExcelConfigData,
    WeaponExcelConfigData,
    WeaponLevelExcelConfigData,
    WeaponPromoteExcelConfigData,
} from "./sources";

export const WeaponPropGrowCurveValues = WeaponCurveExcelConfigData.filter((a) => a.level <= 90).reduce((ret, a) => {
    return a.curveInfos.reduce(
        (ret, info) => ({
            ...ret,
            [info.type]: [...((ret as any)[info.type] || []), info.value],
        }),
        ret,
    );
}, {} as { [k: string]: number[] });

export const WeaponPromotes = groupMulti(
    WeaponPromoteExcelConfigData,
    (a) => {
        return {
            UnlockMaxLevel: a.unlockMaxLevel,
            AddProps: addPropSet(a.addProps),
            MaterialCosts: [
                ...toMaterialCosts(a.costItems),
                ...(a.coinCost
                    ? [
                        {
                            MaterialKey: "Mora",
                            Count: a.coinCost,
                        },
                    ]
                    : []),
            ],
        };
    },
    "weaponPromoteId",
);

const weaponLevelExcelConfigData = WeaponLevelExcelConfigData;

export const WeaponLevelupExps = new Array(5).fill(0).map((_, i) => {
    return weaponLevelExcelConfigData.map((v) => v.requiredExps[i]);
});

export const Weapons = groupOne(
    WeaponExcelConfigData,
    (a) => {
        const name = i18nWithKey(a.nameTextMapHash);

        if (name.CHS == "" || name.CHS.indexOf("test") > -1) {
            return null;
        }

        return {
            Id: a.id,
            Name: name,
            Desc: i18n(a.descTextMapHash),
            Rarity: a.rankLevel,
            WeaponType: a.weaponType,
            PromoteId: a.weaponPromoteId,
            PropGrowCurveAndInitials: a.weaponProp.filter((p) => p.propType).reduce(
                (ret, curve) => ({
                    ...ret,
                    [curve.propType as string]: {
                        GrowCurve: curve.type,
                        Initial: curve.initValue,
                    },
                }),
                {},
            ),
            Affixes: a.skillAffix.map((id) => EquipAffixes[id]).filter((v) => !!v),
        };
    },
    "id",
);

export const WeaponsByKey = mapKeys(Weapons, (v) => v.Name.KEY);

const weaponIndexes = createIndexes(Weapons);

export const findWeapon = (id: string) => {
    return Weapons[weaponIndexes[id]];
};
