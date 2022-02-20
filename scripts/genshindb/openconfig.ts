import { forEach, isNumber, round, size, trim } from "lodash-es";


const format = (n: number, prec: number, percent: boolean) => {
  if (percent) {
    n = n * 100;
  }
  return round(n, prec);
};

const paramsIndexOrValue = (s: string, params: number[]) => {
  const percent = s.endsWith("%");
  const num = trim(s, "%");
  const parts = num.split(".");
  const prec = parts.length == 2 ? parts[1].length : 0;

  for (let j = 0; j < params.length; j++) {
    const v = params[j];
    if (v > 0) {
      if (num == `${format(v, prec, percent)}`) {
        return `${j}`;
      }
    }
  }
  if (percent) {
    return parseFloat(num) / 100;
  }
  return parseFloat(num);
};


const createConfigFn = <T extends (...args: any[]) => any>(fn: T, ...patterns: RegExp[]) => {
  (fn as any).test = (s: string, params: number[]) => {
    for (const p of patterns) {
      const matched = s.match(p);
      if (matched) {
        if (matched.groups) {
          return [
            paramsIndexOrValue(matched.groups["param"], params), matched.index!, matched[0].length,
          ] as const;
        }
        if (isNumber(matched.index)) {
          return [
            null, matched.index!, matched[0].length,
          ] as const;
        }
      }
    }
    return null;
  };
  return fn as (T & {
    test: (s: string, params: number[]) => [number, number, number] | null,
  });
};

export enum FightProp {
  FIGHT_PROP_ATTACK,
  FIGHT_PROP_ATTACK_PERCENT,
  FIGHT_PROP_DEFENSE_PERCENT,
  FIGHT_PROP_SHIELD_COST_MINUS_RATIO,
  FIGHT_PROP_CHARGE_EFFICIENCY,
  FIGHT_PROP_HEAL_ADD,
  FIGHT_PROP_HP_PERCENT,
  FIGHT_PROP_ELEMENT_MASTERY,
  FIGHT_PROP_CRITICAL,
  FIGHT_PROP_ELEMENTAL_SKILL_ADD_CRITICAL,
  FIGHT_PROP_CRITICAL_HURT,
  FIGHT_PROP_NORMAL_ATTACK_ADD_HURT,
  FIGHT_PROP_CHARGED_ATTACK_ADD_HURT,
  FIGHT_PROP_PLUNGING_ATTACK_ADD_HURT,
  FIGHT_PROP_ELEMENTAL_SKILL_ADD_HURT,
  FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT,
  FIGHT_PROP_SWIRL_ADD_HURT,
  FIGHT_PROP_SUPER_CONDUCT_ADD_HURT,
  FIGHT_PROP_MELT_ADD_HURT,
  FIGHT_PROP_VAPORIZE_ADD_HURT,
  FIGHT_PROP_ELECTRO_CHARGED_ADD_HURT,
  FIGHT_PROP_OVERLOADED_ADD_HURT,
  FIGHT_PROP_FIRE_ADD_HURT,
  FIGHT_PROP_ELEC_ADD_HURT,
  FIGHT_PROP_WATER_ADD_HURT,
  FIGHT_PROP_WIND_ADD_HURT,
  FIGHT_PROP_ROCK_ADD_HURT,
  FIGHT_PROP_GRASS_ADD_HURT,
  FIGHT_PROP_ICE_ADD_HURT,

  FIGHT_PROP_ELEMENTAL_SKILL_RADIO,

  ATTACK__ON__HP,
  ATTACK_PERCENT__ON__HP,
  ELEMENTAL_BURST_ADD_HURT__ON__CHARGE_EFFICIENCY__MAX$_75,

  NORMAL_ATTACK_EXTRA_HURT__ON__HP,
  CHARGED_ATTACK_EXTRA_HURT__ON__HP,
  PLUNGING_ATTACK_EXTRA_HURT__ON__HP,
  ELEMENTAL_SKILL_EXTRA_HURT__ON__HP,
  ELEMENTAL_BURST_EXTRA_HURT__ON__HP,

  FIGHT_PROP_ATTACK_ADD_RADIO,
}

const fns: { [k: string]: ReturnType<typeof createConfigFn> } = {
  CharTalent_SangonomiyaKokomi: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_HEAL_ADD]: 0.25,
    [FightProp.FIGHT_PROP_CRITICAL]: -1,
  }), /珊瑚宫心海的治疗加成提升/),

  CharTalent_Bennett: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ATTACK_ADD_RADIO]: 0.2,
  }), /追加班尼特基础攻击力/),

  CharTalent_XinQiu: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEMENTAL_SKILL_RADIO]: 1.5,
  }), /画雨笼山造成的伤害提升/),

  CharTalent_ZhongLi: createConfigFn((v: number) => {
    const params = [0.013899999670684338, 0.01899999938905239, 0.33000001311302185];
    return ({
      [FightProp.NORMAL_ATTACK_EXTRA_HURT__ON__HP]: params[0],
      [FightProp.CHARGED_ATTACK_EXTRA_HURT__ON__HP]: params[0],
      [FightProp.PLUNGING_ATTACK_EXTRA_HURT__ON__HP]: params[0],
      [FightProp.ELEMENTAL_SKILL_EXTRA_HURT__ON__HP]: params[1],
      [FightProp.ELEMENTAL_BURST_EXTRA_HURT__ON__HP]: params[2],
    });
  }, /基于生命值上限，钟离的以下攻击造成的伤害提高/),

  UpAttackOnHp: createConfigFn((v: number) => ({
    [FightProp.ATTACK__ON__HP]: v,
  }), /基于装备该武器的角色生命值上限的(?<param>[.\d]+%)，获得攻击力加成/),

  UpElementalBurstHurtOnChargeEfficiency: createConfigFn((v: number) => ({
    [FightProp.ELEMENTAL_BURST_ADD_HURT__ON__CHARGE_EFFICIENCY__MAX$_75]: v,
  }), /基于元素充能效率的(?<param>[.\d]+%)，提高元素爆发造成的伤害/),

  UpAttack: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ATTACK]: v,
  }), /攻击力提[高升](?<param>[.\d]+)点/),
  UpAttackPercent: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ATTACK_PERCENT]: v,
  }), /攻击力提[高升](?<param>[.\d]+%)/, /提[高升](.+)?(?<param>[.\d]+%)攻击力/, /获得(?<param>[.\d]+%)攻击力提升/),
  UpDefencePercent: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_DEFENSE_PERCENT]: v,
  }), /防御力提[高升](?<param>[.\d]+%)/, /获得(?<param>[.\d]+%)防御力提升/),
  UpShieldCostMinusRatio: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_SHIELD_COST_MINUS_RATIO]: v,
  }), /护盾强效提[高升](?<param>[.\d]+%)/),
  UpHealAdd: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_HEAL_ADD]: v,
  }), /治疗加成提[高升](?<param>[.\d]+%)/),
  UpChargeEfficiency: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_CHARGE_EFFICIENCY]: v,
  }), /元素充能效率提升(?<param>[.\d]+%)/),
  UpHpPercent: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_HP_PERCENT]: v,
  }), /生命值提[高升](?<param>[.\d]+%)/),
  UpElementMastery: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEMENT_MASTERY]: v,
  }), /元素精通提[高升](?<param>[.\d]+)点?/),
  UpAttackAndDefencePercent: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ATTACK_PERCENT]: v,
    [FightProp.FIGHT_PROP_DEFENSE_PERCENT]: v,
  }), /攻击力和防御力提[高升](?<param>[.\d]+%)/),

  AddElementalHurt_Ice: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ICE_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)冰元素伤害加成/, /冰元素伤害加成额外提升(?<param>[.\d]+%)/),
  AddElementalHurt_Rock: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ROCK_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)岩元素伤害加成/),
  AddElementalHurt_Water: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_WATER_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)水元素伤害加成/),
  AddElementalHurt_Fire: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_FIRE_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)火元素伤害加成/),
  AddElementalHurt_Wind: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_WIND_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)风元素伤害加成/),
  AddElementalHurt_Elec: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEC_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)雷元素伤害加成/),
  AddElementalHurt_Grass: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_GRASS_ADD_HURT]: v,
  }), /(获得|提供)(?<param>[.\d]+%)草元素伤害加成/),

  AddElementalHurt: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_FIRE_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_WATER_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_ICE_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_ROCK_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_ELEC_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_WIND_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_GRASS_ADD_HURT]: v,
  }), /元素伤害加成提[高升](?<param>[.\d]+%)/, /全元素伤害提升(?<param>[.\d]+%)/, /获得(?<param>[.\d]+%)所有元素伤害加成/),
  AddHurt_NormalChangedAndPlungingAttack: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_NORMAL_ATTACK_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_CHARGED_ATTACK_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_PLUNGING_ATTACK_ADD_HURT]: v,
  }), /普通攻击、重击、下落攻击造成的伤害提[高升](?<param>[.\d]+%)/),
  AddHurt_NormalAndChangedAttack: createConfigFn((v: number) => ({
      [FightProp.FIGHT_PROP_NORMAL_ATTACK_ADD_HURT]: v,
      [FightProp.FIGHT_PROP_CHARGED_ATTACK_ADD_HURT]: v,
    }),
    /普通攻击与重击造成的伤害提[高升](?<param>[.\d]+%)/,
    /普通攻击与重击的造成的伤害提[高升](?<param>[.\d]+%)/,
  ),
  AddHurt_NormalAttack: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_NORMAL_ATTACK_ADD_HURT]: v,
  }), /普通攻击的伤害提[高升](?<param>[.\d]+%)/, /普通攻击造成的伤害提升(?<param>[.\d]+%)/, /普通攻击造成的伤害提高.+(?<param>[.\d]+%)/),
  AddHurt_ChangedAttack: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_CHARGED_ATTACK_ADD_HURT]: v,
  }), /重击造成的伤害提[高升](?<param>[.\d]+%)/, /提高(?<param>[.\d]+%)重击伤害/),
  AddHurt_ElementalSkill: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEMENTAL_SKILL_ADD_HURT]: v,
  }), /元素战技造成的伤害增加(?<param>[.\d]+%)/),
  AddHurt_ElementalBurst: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT]: v,
  }), /元素爆发造成的伤害(至多)?提[高升](?<param>[.\d]+%)/),
  AddHurt_ElementalSkillAndBurst: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEMENTAL_SKILL_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT]: v,
  }), /元素战技与元素爆发的伤害提[高升](?<param>[.\d]+%)/),
  AddHurt_Swirl: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_SWIRL_ADD_HURT]: v,
  }), /扩散反应造成的伤害提[高升](?<param>[.\d]+%)/),
  AddHurt_ElecReactions: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_OVERLOADED_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_ELECTRO_CHARGED_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_SUPER_CONDUCT_ADD_HURT]: v,
  }), /超载、感电、超导反应造成的伤害提[高升](?<param>[.\d]+%)/),
  AddHurt_FireReactions: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_OVERLOADED_ADD_HURT]: v,
  }), /超载、燃烧反应造成的伤害提[高升](?<param>[.\d]+%)/),
  AddHurt_FireReactionRatio: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_MELT_ADD_HURT]: v,
    [FightProp.FIGHT_PROP_VAPORIZE_ADD_HURT]: v,
  }), /蒸发、融化反应的加成系数提高(?<param>[.\d]+%)/),
  AddHurt: createConfigFn((v: number) => ({
      [FightProp.FIGHT_PROP_NORMAL_ATTACK_ADD_HURT]: v,
      [FightProp.FIGHT_PROP_CHARGED_ATTACK_ADD_HURT]: v,
      [FightProp.FIGHT_PROP_PLUNGING_ATTACK_ADD_HURT]: v,
      [FightProp.FIGHT_PROP_ELEMENTAL_SKILL_ADD_HURT]: v,
      [FightProp.FIGHT_PROP_ELEMENTAL_BURST_ADD_HURT]: v,
    }), /造成的伤害提[高升](?<param>[.\d]+%)/, /造成的伤害增加(?<param>[.\d]+%)/,
  ),
  AddCritical_ElementalSkill: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_ELEMENTAL_SKILL_ADD_CRITICAL]: v,
  }), /元素战技的暴击率提[高升](?<param>[.\d]+%)/),
  AddCritical: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_CRITICAL]: v,
  }), /暴击率(额外)?提[高升](?<param>[.\d]+%)/),
  AddCriticalHurt: createConfigFn((v: number) => ({
    [FightProp.FIGHT_PROP_CRITICAL_HURT]: v,
  }), /暴击伤害(额外)?提[高升](?<param>[.\d]+%)/),
};

export const OpenConfigs: {
  [k: string]: {
    Config: Array<{ [k: string]: string | number }>,
    Desc: string,
    Params: number[],
  }
} = {};

const resolveConfig = (openConfig: string, desc: string, params: number[]) => {
  if (OpenConfigs[openConfig]) {
    return OpenConfigs[openConfig].Config;
  }

  const config: Array<{ [k: string]: string | number }> = [];

  for (let part of desc.split(/[。；]/g)) {
    const pc: { [k: string]: string | number } = {};

    for (const fn in fns) {
      const ret = fns[fn].test(part, params);

      if (ret) {
        part = part.slice(0, ret[1]) + part.slice(ret[1] + ret[2]);
        pc[fn] = ret[0];
      }
    }

    if (size(pc) > 0) {
      const mayWhen = part.split("，")[0];
      if (mayWhen.match(/[后时内]$/) || mayWhen.includes("影响下")) {
        if (["装备", "攻击造成伤害时", "点按"].every(v => part.indexOf(v) == -1)) {
          pc["$when"] = mayWhen;
        }
      }
      config.push(pc);
    } else {
      if (part.match(/(提升|提高|获得|提供)/g)) {
        if (["技能等级提高", "提升至15级"].every(v => part.indexOf(v) == -1)) {
          // console.log(part, params.join(", "));
        }
      }
    }
  }

  OpenConfigs[openConfig] = {
    Config: config,
    Desc: desc,
    Params: params,
  };

  return config;
};

const setFightProps = (fps: { [k: string]: number }, fs: { [k: string]: string | number }, params: number[]) => {
  for (const k in fs) {
    if (fns[k]) {
      const rets = fns[k](params[fs[k] as any] || fs[k]);
      forEach(rets, (v: number, k: FightProp) => {
        fps[FightProp[k]] = (v || fps[FightProp[k]] || 0);
      });
    }
  }
};


const configsToProps = (configs: Array<{ [k: string]: string | number }>, params: number[], addProps: {}) => {
  return {
    AddProps: configs
      .filter((c) => !c["$when"])
      .reduce((addProps, fns) => {
        setFightProps(addProps, fns, params);
        return addProps;
      }, addProps as any),
    AdditionalProps: configs
      .filter((c) => c["$when"])
      .map((fns) => {
        const addProps = {};
        setFightProps(addProps, fns, params);
        return {
          ...addProps,
          $when: fns["$when"],
        };
      }, {}),
  };
};


export const resolveAndFixProps = (openConfig: string, desc: string, params: number[], defaultAddProps: {}) => {
  return {
    OpenConfig: openConfig,
    ...configsToProps(resolveConfig(openConfig, desc, params), params, defaultAddProps),
  };
};
