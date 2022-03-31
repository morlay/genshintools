import { addPropSet, cleanText, groupMulti, groupOne, i18n, i18nWithKey, pascalCase } from "./common";
import { Materials } from "./domain_material";
import { mapKeys, reduce } from "lodash-es";
import { Weapons } from "./domain_weapon";
import { resolveAndFixProps } from "./openconfig";
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

export const CharacterLevelupExps = AvatarLevelExcelConfigData.map((a) => a.Exp);

export const CharacterPromotes = groupMulti(
  AvatarPromoteExcelConfigData,
  (a) => {
    return {
      UnlockMaxLevel: a.UnlockMaxLevel,
      AddProps: addPropSet(a.AddProps),
      MaterialCosts: [
        ...a.CostItems.filter((item: any) => item.Id).map((item: any) => ({
          MaterialKey: Materials[item.Id].Name.KEY,
          Count: item.Count,
        })),
        ...(a.ScoinCost
          ? [
              {
                MaterialKey: "Mora",
                Count: a.ScoinCost,
              },
            ]
          : []),
      ],
    };
  },
  "AvatarPromoteId",
);

export const CharacterPropGrowCurveValues = AvatarCurveExcelConfigData.filter((a) => a.Level <= 90).reduce((ret, a) => {
  return a.CurveInfos.reduce(
    (ret, info) => ({
      ...ret,
      [info.Type]: [...((ret as any)[info.Type] || []), info.Value],
    }),
    ret,
  );
}, {} as { [k: string]: number[] });

const Constellations = groupOne(
  AvatarTalentExcelConfigData,
  (talent) => {
    const desc = i18n(talent.DescTextMapHash, cleanText);

    return {
      Name: i18nWithKey(talent.NameTextMapHash),
      Desc: desc,
      ...resolveAndFixProps(
        talent.OpenConfig || `talent-${talent.TalentId}`,
        desc.CHS,
        talent.ParamList,
        addPropSet(talent.AddProps),
      ),
    };
  },
  "TalentId",
);

const ProudSkills = groupMulti(
  ProudSkillExcelConfigData,
  (ps) => ({
    ProudSkillGroupId: ps.ProudSkillGroupId,
    Name: i18nWithKey(ps.NameTextMapHash),
    Desc: i18n(ps.DescTextMapHash, cleanText),
    ParamNames: ps.ParamDescList.map((n) => i18n(n, cleanText)).filter((c) => c.CHS),
    Params: ps.ParamList,
    BreakLevel: ps.BreakLevel,
    OpenConfig: ps.OpenConfig,
    MaterialCosts: [
      ...ps.CostItems.filter((item: any) => item.Id).map((item: any) => ({
        MaterialKey: Materials[item.Id].Name.KEY,
        Count: item.Count,
      })),
      ...(ps.CoinCost
        ? [
            {
              MaterialKey: "Mora",
              Count: ps.CoinCost,
            },
          ]
        : []),
    ],
  }),
  "ProudSkillGroupId",
);

const Skills = groupOne(
  AvatarSkillExcelConfigData,
  (skill) => {
    const proudSkills = skill.ProudSkillGroupId ? ProudSkills[skill.ProudSkillGroupId] : [];
    const paramNames = proudSkills.length > 0 ? proudSkills[0].ParamNames : [];

    let skillType = "A";

    if (skill.CostElemVal) {
      skillType = "Q";
    } else if (skill.CdTime) {
      skillType = "E";
    } else if (skill.CostStamina) {
      skillType = "";
    }

    return {
      Name: i18nWithKey(skill.NameTextMapHash),
      Desc: i18n(skill.DescTextMapHash, cleanText),
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
  "Id",
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
    const skills = [...skillDepot.Skills.filter((id) => id > 0), skillDepot.EnergySkill as number]
      .map((id) => Skills[id])
      .filter((s) => s);
    const skillNames: any = {
      E: "",
      Q: "",
    };

    skills.forEach((s) => {
      skillNames[s.SkillType] = s.Name.CHS;
    });

    const ret = {
      ElementType: "" as any,
      Element: "" as any,
      Constellations: skillDepot.Talents.map((id) => {
        const c = Constellations[id];

        if (c && c.Desc.CHS.indexOf("至多提升至15级") > -1) {
          const addProps: any = {};

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
      InherentSkills: skillDepot.InherentProudSkillOpens.filter((s: any) => s.ProudSkillGroupId)
        .map((s: any) => {
          return ProudSkills[s.ProudSkillGroupId]!;
        })
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
  "Id",
);

export const Characters = AvatarExcelConfigData.filter((a) => a.UseType && i18n(a.DescTextMapHash).CHS).reduce(
  (ret, a) => {
    const base = {
      Id: a.Id,
      Name: i18nWithKey(a.NameTextMapHash),
      Desc: i18n(a.DescTextMapHash),
      Rarity: a.QualityType === "QUALITY_ORANGE" ? 5 : 4,
      WeaponType: a.WeaponType,
      InitialWeaponKey: Weapons[a.InitialWeapon].Name.KEY,
      StaminaRecoverSpeed: a.StaminaRecoverSpeed,
      ChargeEfficiency: 1, // todo always 1.0
      Critical: a.Critical,
      CriticalHurt: a.CriticalHurt,
      PromoteId: a.AvatarPromoteId,
      PropGrowCurveAndInitials: a.PropGrowCurves.filter((curve) => curve.Type).reduce(
        (ret, curve) => ({
          ...ret,
          [curve.Type]: {
            GrowCurve: curve.GrowCurve,
            Initial:
              {
                FIGHT_PROP_BASE_HP: a.HpBase,
                FIGHT_PROP_BASE_ATTACK: a.AttackBase,
                FIGHT_PROP_BASE_DEFENSE: a.DefenseBase,
              }[curve.Type] || 0,
          },
        }),
        {},
      ),
    };

    if (a.CandSkillDepotIds.length > 0) {
      return {
        ...ret,
        ...reduce(
          a.CandSkillDepotIds,
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
      ...SkillDepots[a.SkillDepotId],
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
