import {addPropSet, cleanText, groupMulti, groupOne, i18n, i18nWithKey, pascalCase} from "./common";
import {toMaterialCosts} from "./domain_material";
import {mapKeys, reduce} from "lodash-es";
import {Weapons} from "./domain_weapon";
import {resolveAndFixProps} from "./openconfig";
import {
    AvatarCurveExcelConfigData,
    AvatarExcelConfigData,
    AvatarLevelExcelConfigData,
    AvatarPromoteExcelConfigData,
    AvatarSkillDepotExcelConfigData,
    AvatarSkillExcelConfigData,
    AvatarTalentExcelConfigData,
    ProudSkillExcelConfigData,
} from "./sources";

export const CharacterLevelupExps = AvatarLevelExcelConfigData.map((a) => a.exp);

export const CharacterPromotes = groupMulti(
    AvatarPromoteExcelConfigData,
    (a) => {
        return {
            UnlockMaxLevel: a.unlockMaxLevel,
            AddProps: addPropSet(a.addProps),
            MaterialCosts: [
                ...toMaterialCosts(a.costItems),
                ...(a.scoinCost
                    ? [
                        {
                            MaterialKey: "Mora",
                            Count: a.scoinCost,
                        },
                    ]
                    : []),
            ],
        };
    },
    "avatarPromoteId",
);

export const CharacterPropGrowCurveValues = AvatarCurveExcelConfigData.filter((a) => a.level <= 90).reduce((ret, a) => {
    return a.curveInfos.reduce(
        (ret, info) => ({
            ...ret,
            [info.type]: [...((ret as any)[info.type] || []), info.value],
        }),
        ret,
    );
}, {} as { [k: string]: number[] });

const Constellations = groupOne(
    AvatarTalentExcelConfigData,
    (talent) => {
        const desc = i18n(talent.descTextMapHash, cleanText);

        return {
            Name: i18nWithKey(talent.nameTextMapHash),
            Icon: talent.icon || "",
            Desc: desc,
            ...resolveAndFixProps(
                talent.openConfig || `talent-${talent.talentId}`,
                desc.CHS,
                talent.paramList,
                addPropSet(talent.addProps),
            ),
        };
    },
    "talentId",
);

const ProudSkills = groupMulti(
    ProudSkillExcelConfigData,
    (ps) => ({
        ProudSkillGroupId: ps.proudSkillGroupId,
        Name: i18nWithKey(ps.nameTextMapHash),
        Icon: ps.icon || "",
        Desc: i18n(ps.descTextMapHash, cleanText),
        ParamNames: ps.paramDescList.map((n) => i18n(n, cleanText)).filter((c) => c.CHS),
        Params: ps.paramList,
        BreakLevel: ps.breakLevel,
        OpenConfig: ps.openConfig,
        MaterialCosts: [
            ...toMaterialCosts(ps.costItems),
            ...(ps.coinCost
                ? [
                    {
                        MaterialKey: "Mora",
                        Count: ps.coinCost,
                    },
                ]
                : []),
        ],
    }),
    "proudSkillGroupId",
);

const Skills = groupOne(
    AvatarSkillExcelConfigData,
    (skill) => {
        const proudSkills = skill.proudSkillGroupId ? ProudSkills[skill.proudSkillGroupId] : [];
        const paramNames = proudSkills.length > 0 ? proudSkills[0].ParamNames : [];

        let skillType = "A";

        if (skill.costElemVal) {
            skillType = "Q";
        } else if (skill.cdTime) {
            skillType = "E";
        } else if (skill.costStamina) {
            skillType = "";
        }

        return {
            Name: i18nWithKey(skill.nameTextMapHash),
            Icon: skill.skillIcon || "",
            Desc: i18n(skill.descTextMapHash, cleanText),
            SkillType: skillType,
            MaterialCosts: proudSkills.map((item) => item.MaterialCosts),
            ...(paramNames.length > 0
                ? {
                    ParamNames: paramNames,
                    Params: proudSkills.map((item) => item.Params),
                }
                : {}),
        };
    },
    "id",
);

const ElementTypes = {
    风: "Anemo",
    岩: "Geo",
    雷: "Electro",
    草: "Dendro",
    冰: "Cryo",
    水: "Hydro",
    火: "Pyro",
};

const SkillDepots = groupOne(
    AvatarSkillDepotExcelConfigData,
    (skillDepot) => {
        const skills = [...skillDepot.skills.filter((id) => id > 0), skillDepot.energySkill as number]
            .map((id) => Skills[id])
            .filter((s) => s);

        const skillNames: { [k: string]: string } = {
            A: "",
            E: "",
            Q: "",
        };

        skills.forEach((s) => {
            skillNames[s.SkillType] = s.Name.CHS;
        });

        const ret = {
            ElementType: "" as any,
            Element: "" as any,
            Constellations: skillDepot.talents.map((id) => {
                const c = Constellations[id];

                if (c && c.Desc.CHS.indexOf("至多提升至15级") > -1) {
                    const addProps: { [k: string]: number } = {};

                    if (c.Desc.CHS.indexOf(skillNames["E"]) > -1) {
                        addProps["FIGHT_PROP_ADD_ELEMENTAL_SKILL_LEVEL"] = 3;
                    }

                    if (c.Desc.CHS.indexOf(skillNames["Q"]) > -1) {
                        addProps["FIGHT_PROP_ADD_ELEMENTAL_BURST_LEVEL"] = 3;
                    }

                    return {
                        ...c,
                        AddProps: {
                            ...c.AddProps,
                            ...addProps,
                        },
                    };
                }

                return c;
            }),
            Skills: skills,
            InherentSkills: skillDepot.inherentProudSkillOpens
                .filter((s) => s.hasOwnProperty("proudSkillGroupId"))
                .map((s) => ProudSkills[(s as any).proudSkillGroupId]!)
                .flat()
                .map((s) => ({
                    ...s,
                    Params: undefined,
                    ...resolveAndFixProps(s.OpenConfig || `skill-${s.ProudSkillGroupId}`, s.Desc.CHS, s.Params, {}),
                })),
        };

        ret.Skills.filter((s) => s).forEach((s) => {
            const matched = s!.Desc!.CHS.match(/([冰水火雷岩风草])元素/);
            if (matched) {
                ret.ElementType = matched[1];
                ret.Element = (ElementTypes as any)[ret.ElementType];
            }
        });

        return ret;
    },
    "id",
);

export const Characters = AvatarExcelConfigData
    .filter((a) => a.useType && i18n(a.descTextMapHash).CHS)
    .reduce(
        (ret, a) => {
            const base = {
                Id: a.id,
                Name: i18nWithKey(a.nameTextMapHash),
                Icon: a.iconName || "",
                Desc: i18n(a.descTextMapHash),
                Rarity: a.qualityType === "QUALITY_ORANGE" ? 5 : 4,
                WeaponType: a.weaponType,
                InitialWeaponKey: Weapons[a.initialWeapon].Name.KEY,
                StaminaRecoverSpeed: a.staminaRecoverSpeed,
                ChargeEfficiency: 1, // todo always 1.0
                Critical: a.critical,
                CriticalHurt: a.criticalHurt,
                PromoteId: a.avatarPromoteId,
                PropGrowCurveAndInitials: a.propGrowCurves.filter((curve) => curve.type).reduce(
                    (ret, curve) => ({
                        ...ret,
                        [curve.type]: {
                            GrowCurve: curve.growCurve,
                            Initial: {
                                FIGHT_PROP_BASE_HP: a.hpBase,
                                FIGHT_PROP_BASE_ATTACK: a.attackBase,
                                FIGHT_PROP_BASE_DEFENSE: a.defenseBase,
                            }[curve.type] || 0,
                        },
                    }),
                    {},
                ),
            };

            if (a.candSkillDepotIds.length > 0) {
                return {
                    ...ret,
                    ...reduce(
                        a.candSkillDepotIds,
                        (ret, skillDepotID) => {
                            const skillDepot = SkillDepots[skillDepotID];

                            if (skillDepot.ElementType == "") {
                                return ret;
                            }

                            const id = 90000000 + skillDepotID;
                            const chsName = `${skillDepot.ElementType}${base.Name.CHS}`;
                            const enName = `${base.Name.EN} ${(ElementTypes as any)[skillDepot.ElementType]}`;
                            const key = pascalCase(enName);

                            return {
                                ...ret,
                                [id]: {
                                    ...base,
                                    ...skillDepot,
                                    Id: id,
                                    Name: {
                                        CHS: chsName,
                                        EN: enName,
                                        KEY: key,
                                    },
                                },
                            };
                        },
                        {},
                    ),
                };
            }

            const avatar = {
                ...base,
                ...SkillDepots[a.skillDepotId],
            };

            return {
                ...ret,
                [avatar.Id]: avatar,
            };
        },
        {},
    );

export const CharactersByKey = mapKeys(Characters, (c: any) => {
    return c.Name.KEY;
});
