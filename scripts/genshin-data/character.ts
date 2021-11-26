import proudSkillExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/ProudSkillExcelConfigData.json";
import avatarExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarExcelConfigData.json";
import avatarPromoteExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarPromoteExcelConfigData.json";
import avatarTalentExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarTalentExcelConfigData.json";
import avatarSkillDepotExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarSkillDepotExcelConfigData.json";
import avatarCurveExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarCurveExcelConfigData.json";
import avatarSkillExcelConfigData from "../../vendordata/GenshinData/ExcelBinOutput/AvatarSkillExcelConfigData.json";
import {builds} from "../../vendordata/paimon-moe/src/data/build";

import {cleanText, chsText, i18n, i18nList, i18nForName} from "./text";
import {addPropSet, propGrowCurveFor} from "./utils";
import {materialNameID} from "./material";
import {Dictionary, reduce, values, snakeCase, uniqBy, filter, last, get} from "lodash";
import {reliquaries} from "./reliquary";
import {weapons} from "./weapon";

const theReliquaries = reliquaries();
const theWeapons = weapons();

const statsMap: Dictionary<string> = {
    "HP%": "FIGHT_PROP_HP_PERCENT",
    "ATK%": "FIGHT_PROP_ATTACK_PERCENT",
    "DEF%": "FIGHT_PROP_DEFENSE_PERCENT",
    "Flat HP": "FIGHT_PROP_HP",
    "Flat ATK": "FIGHT_PROP_ATTACK",
    "Flat DEF": "FIGHT_PROP_DEFENSE",

    "Elemental Mastery": "FIGHT_PROP_ELEMENT_MASTERY",
    EM: "FIGHT_PROP_ELEMENT_MASTERY",
    "Energy Recharge": "FIGHT_PROP_CHARGE_EFFICIENCY",
    "ER%": "FIGHT_PROP_CHARGE_EFFICIENCY",
    "Crit Rate": "FIGHT_PROP_CRITICAL",
    "Crit DMG": "FIGHT_PROP_CRITICAL_HURT",
    // hack
    DMG: "FIGHT_PROP_CRITICAL_HURT",
    "Healing Bonus": "FIGHT_PROP_HEAL_ADD",

    "Pyro DMG": "FIGHT_PROP_FIRE_ADD_HURT",
    "Hydro DMG": "FIGHT_PROP_WATER_ADD_HURT",
    "Geo DMG": "FIGHT_PROP_ROCK_ADD_HURT",
    "Cryo DMG": "FIGHT_PROP_ICE_ADD_HURT",
    "Electro DMG": "FIGHT_PROP_ELEC_ADD_HURT",
    "Anemo DMG": "FIGHT_PROP_WIND_ADD_HURT",
    "Dendro DMG": "FIGHT_PROP_GRASS_ADD_HURT",
    "Physical DMG": "FIGHT_PROP_PHYSICAL_ADD_HURT",
};

const resolvePropTypes = (s: string): string[] => {
    return reduce(
        s.split("/"),
        (ret: string[], s: string) => {
            const f =
                statsMap[s.trim()] ||
                statsMap[s.trim().replace("Damage", "DMG")] ||
                statsMap[s.trim().replace("Attack", "ATK")] ||
                statsMap[s.trim().replace("Defence", "ATK")];

            if (f) {
                return [...ret, f];
            }

            console.log(s.trim());

            return ret;
        },
        [],
    );
};

const chooseTwo = (list: string[]) => {
    const pairs: string[][] = [];

    for (let i = 0; i < list.length; i++) {
        for (let j = i + 1; j < list.length; j++) {
            pairs.push([list[i], list[j]]);
        }
    }

    return pairs;
};

const avatarBuild = (enName: string) => {
    const r = (builds as any)[snakeCase(enName)];

    if (r) {
        const b = last(filter(values(r.roles), (v) => v.recommended));

        const rec = {
            MainPropTypes: [
                resolvePropTypes(b.mainStats.sands),
                resolvePropTypes(b.mainStats.goblet),
                resolvePropTypes(b.mainStats.circlet),
            ],
            AffixPropTypes: reduce(b.subStats, (ret: string[], s: string) => [...ret, ...resolvePropTypes(s)], []),
            TalentPriority: b.talent.map((v: string) => snakeCase(v.trim()).toUpperCase()),
            Weapons: b.weapons.map((w: { id: string }) => {
                const found = theWeapons.Weapons[theWeapons.WeaponIndexes[snakeCase(w.id)]];
                if (found) {
                    return found.Name.CHS;
                }
                return w.id;
            }),
            ReliquarySets: uniqBy(
                b.artifacts.reduce((ret: string[][], sets: string[]) => {
                    const pair = sets
                        .map((setName) => {
                            const found = theReliquaries.ReliquarySets[theReliquaries.ReliquarySetIndexes[snakeCase(setName)]];
                            if (found) {
                                return found.Name.CHS;
                            }
                            if ("18_atk_set" === snakeCase(setName)) {
                                return "角斗士的终幕礼";
                            }
                            return null;
                        })
                        .filter((s) => s) as string[];

                    if (pair.length > 2) {
                        return [...ret, ...chooseTwo(pair)];
                    }

                    return [...ret, pair];
                }, []),
                (s: string[]) => s.join("/"),
            ),
        };

        return rec;
    }
    console.log("missing", enName);
    return {};
};

const avatarPropGrowCurve = (growCurve: string) => {
    return avatarCurveExcelConfigData
        .filter((a) => a.Level <= 90)
        .map((a) => {
            return a.CurveInfos.find((i) => i.Type == growCurve)?.Value || 0;
        });
};

const talent = (talentId: number) => {
    const talent = avatarTalentExcelConfigData.find((a) => a.TalentId == talentId);
    if (talent) {
        return {
            Name: i18nForName(talent.NameTextMapHash),
            Desc: i18n(talent.DescTextMapHash, cleanText),
            AddProps: addPropSet(talent.AddProps),
            // OpenConfig: talent.OpenConfig,
            Params: talent.ParamList,
        };
    }
    return null;
};

const proudSkills = (proudSkillGroupId: number) => {
    return proudSkillExcelConfigData
        .filter((skill) => skill.ProudSkillGroupId == proudSkillGroupId)
        .map((skill) => {
            return {
                Name: i18nForName(skill.NameTextMapHash),
                Desc: i18n(skill.DescTextMapHash, cleanText),
                ParamNames: i18nList(skill.ParamDescList, cleanText),
                BreakLevel: skill.BreakLevel || 0,
                Params: skill.ParamList,
            };
        });
};

const skill = (skillID: number) => {
    const skill = avatarSkillExcelConfigData.find((a) => a.Id == skillID);

    if (skill) {
        const proudSkills = proudSkillExcelConfigData.filter((item) => item.ProudSkillGroupId == skill.ProudSkillGroupId);

        const paramNames = proudSkills.length > 0 ? i18nList(proudSkills[0].ParamDescList) : [];

        let skillType = "A";

        if (skill.CostElemVal) {
            skillType = "Q";
        } else if (skill.CdTime) {
            skillType = "E";
        } else if (skill.CostStamina) {
            skillType = "A";
        }

        return {
            Name: i18nForName(skill.NameTextMapHash),
            Desc: i18n(skill.DescTextMapHash, cleanText),
            SkillType: skillType,
            BreakLevels: proudSkills.map((item) => item.BreakLevel || 0),
            CoinCosts: proudSkills.map((item) => item.CoinCost || 0),
            MaterialCosts: proudSkills.map((item) =>
                item.CostItems.filter((item: any) => item.Id).map((item: any) => ({
                    MaterialNameID: materialNameID(item.Id),
                    Count: item.Count,
                })),
            ),
            ProudSkills:
                paramNames.length > 0
                    ? {
                        ParamNames: paramNames,
                        Params: proudSkills.map((item) => item.ParamList),
                    }
                    : {},
        };
    }

    return null;
};

const ElementTypes = {
    风: "Anemo",
    岩: "Geo",
    雷: "Electro",
    草: "Dendro",
    冰: "Cryo",
    水: "Hydro",
    火: "Pyco",
};

const avatarSkillAndTalents = (skillDepotId: number) => {
    const skillDepot = avatarSkillDepotExcelConfigData.find((a) => a.Id == skillDepotId)!;

    const ret = {
        ElementType: "" as any,
        Skills: [...skillDepot.Skills.filter((id) => id > 0), skillDepot.EnergySkill as number]
            .map((id) => skill(id))
            .filter((s) => s),
        InherentSkills: skillDepot.InherentProudSkillOpens.filter((s) => (s as any).ProudSkillGroupId)
            .map((s: any) => proudSkills(s.ProudSkillGroupId))
            .flat(),
        Talents: skillDepot.Talents.map((id) => talent(id)),
    };

    ret.Skills.filter((s) => s).forEach((s) => {
        const matched = s!.Desc.CHS.match(/([冰水火雷岩风草])元素/);
        if (matched) {
            ret.ElementType = matched[1];
        }
    });

    return ret;
};

const avatarPromotes = (avatarPromoteId: number) => {
    const p = avatarPromoteExcelConfigData.filter((a) => a.AvatarPromoteId == avatarPromoteId);

    return p.map((a, i) => ({
        MinLevel: i > 0 ? p[i - 1]?.UnlockMaxLevel : 1,
        UnlockMaxLevel: a.UnlockMaxLevel,
        CoinCost: a.ScoinCost || 0,
        MaterialCosts: a.CostItems.filter((item: any) => item.Id).map((item: any) => ({
            MaterialNameID: materialNameID(item.Id),
            Count: item.Count,
        })),
        AddProps: addPropSet(a.AddProps),
    }));
};

export const characters = () => {
    return avatarExcelConfigData
        .filter((a) => a.UseType && chsText(a.DescTextMapHash))
        .reduce((ret, a) => {
            const base = {
                Id: a.Id,
                Name: i18nForName(a.NameTextMapHash),
                Desc: i18n(a.DescTextMapHash),
                RankLevel: a.QualityType === "QUALITY_ORANGE" ? 5 : 4,
                WeaponType: a.WeaponType,
                InitialWeaponId: a.InitialWeapon,
                StaminaRecoverSpeed: a.StaminaRecoverSpeed,
                ChargeEfficiency: a.ChargeEfficiency,
                Critical: a.Critical,
                CriticalHurt: a.CriticalHurt,
                ...{
                    Promotes: avatarPromotes(a.AvatarPromoteId),
                    PropGrowCurves: a.PropGrowCurves.reduce(
                        (ret, curve) => ({
                            ...ret,
                            [curve.Type]: propGrowCurveFor(avatarPropGrowCurve)(
                                curve.GrowCurve,
                                {
                                    FIGHT_PROP_BASE_HP: a.HpBase,
                                    FIGHT_PROP_BASE_ATTACK: a.AttackBase,
                                    FIGHT_PROP_BASE_DEFENSE: a.DefenseBase,
                                }[curve.Type] || 0,
                            ),
                        }),
                        {},
                    ),
                },
            };

            if (a.CandSkillDepotIds.length > 0) {
                return {
                    ...ret,
                    ...reduce(
                        a.CandSkillDepotIds,
                        (ret, skillDepotID) => {
                            const ast = avatarSkillAndTalents(skillDepotID);
                            if (ast.ElementType == "") {
                                return ret;
                            }

                            const id = 90000000 + Object.keys(ElementTypes).indexOf(ast.ElementType);
                            const chsName = `${ast.ElementType}${base.Name.CHS}`;
                            const enName = `${base.Name.EN} ${(ElementTypes as any)[ast.ElementType]}`;

                            return {
                                ...ret,
                                [id]: {
                                    ...base,
                                    ...avatarSkillAndTalents(skillDepotID),
                                    Id: id,
                                    Name: {
                                        CHS: chsName,
                                        EN: enName,
                                    },
                                    AvatarBuild: avatarBuild(enName),
                                },
                            };
                        },
                        {},
                    ),
                };
            }

            const avatar = {
                ...base,
                ...avatarSkillAndTalents(a.SkillDepotId),
                AvatarBuild: avatarBuild(base.Name.EN),
            };

            return {
                ...ret,
                [avatar.Id]: avatar,
            };
        }, {});
};
