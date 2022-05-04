import {groupOne, i18nWithKey, createIndexes} from "./common";
import {mapKeys, mapValues, reduce, uniq, values} from "lodash-es";
import {
    MonsterDescribeExcelConfigData,
    MonsterExcelConfigData,
    MonsterRelationshipExcelConfigData,
    MonsterSpecialNameExcelConfigData,
    MonsterTitleExcelConfigData,
} from "./sources";

export const MonsterRelationships = groupOne(
    MonsterRelationshipExcelConfigData,
    (t) => ({
        DropTag: t.tagStr,
        MonsterRarity: t.monsterRarity,
    }),
    "id",
);

export const MonsterTitles = groupOne(
    MonsterTitleExcelConfigData,
    (t) => i18nWithKey(t.titleNameTextMapHash),
    "titleID",
);

export const MonsterSpecialNames = groupOne(
    MonsterSpecialNameExcelConfigData,
    (t) => i18nWithKey(t.specialNameTextMapHash),
    "specialNameLabID",
);

export const MonsterDescribes = groupOne(
    MonsterDescribeExcelConfigData,
    (t) => {
        return {
            DropTag: MonsterRelationships[t.id]?.DropTag,
            MonsterRarity: MonsterRelationships[t.id]?.MonsterRarity,
            SpecialName: MonsterSpecialNames[t.specialNameLabID],
            Title: MonsterTitles[t.titleID],
            Name: i18nWithKey(t.nameTextMapHash),
        };
    },
    "id",
);

export const Enemies = mapKeys(
    reduce(
        MonsterExcelConfigData,
        (ret, t) => {
            if (!t.describeId) {
                return ret;
            }

            if (!MonsterDescribes[t.describeId]) {
                // console.log(`invalid ${JSON.stringify(i18nWithID(t.NameTextMapHash))}`);
                return ret;
            }

            const b = {
                ...MonsterDescribes[t.describeId],
                Name: MonsterDescribes[t.describeId].Name || i18nWithKey(t.nameTextMapHash),
                Type: t.type,
                SecurityLevel: t.securityLevel,
                Id: t.id,
                AddProps: {
                    FIGHT_PROP_ENEMY_FIRE_SUB_HURT: t.fireSubHurt,
                    FIGHT_PROP_ENEMY_ROCK_SUB_HURT: t.rockSubHurt,
                    FIGHT_PROP_ENEMY_ELEC_SUB_HURT: t.elecSubHurt,
                    FIGHT_PROP_ENEMY_WATER_SUB_HURT: t.waterSubHurt,
                    FIGHT_PROP_ENEMY_GRASS_SUB_HURT: t.grassSubHurt,
                    FIGHT_PROP_ENEMY_ICE_SUB_HURT: t.iceSubHurt,
                    FIGHT_PROP_ENEMY_WIND_SUB_HURT: t.windSubHurt,
                    FIGHT_PROP_ENEMY_PHYSICAL_SUB_HURT: t.physicalSubHurt,
                },
            };

            // ignores
            if (
                {
                    treasure_hoarders_liuliu: true,
                    treasure_hoarders_boss: true,
                    treasure_hoarders_carmen: true,
                }[b.Name.KEY]
            ) {
                return ret;
            }

            return {
                ...ret,
                [b.Name.KEY]: b,
            };
        },
        {} as any,
    ),
    (v) => v.Id,
);

const enemyIndexes = createIndexes(Enemies);

export const findEnemy = (id: string) => {
    return Enemies[enemyIndexes[id]];
};

export const EnemyDropTags = uniq(values(mapValues(MonsterRelationships, (d) => d.DropTag)));

const MonsterRarities: { [k: string]: string } = {};

export const EnemyDropTagAliases: { [k: string]: { Tags: string[]; MonsterRarity: string } } = reduce(
    values(Enemies),
    (ret, m) =>
        m.DropTag
            ? {
                ...ret,
                [m.DropTag]: {
                    MonsterRarity: (MonsterRarities[m.MonsterRarity] = m.MonsterRarity),
                    Tags: [m.DropTag],
                },
                [m.Name.CHS]: {
                    MonsterRarity: m.MonsterRarity,
                    Tags: [m.DropTag],
                },
                ["BOSS"]:
                    m.MonsterRarity == "MONSTER_RARITY_BIG_BOSS_MONSTER"
                        ? {
                            MonsterRarity: m.MonsterRarity,
                            Tags: [...((ret as any)["BOSS"] ? (ret as any)["BOSS"].Tags : []), m.DropTag],
                        }
                        : (ret as any)["BOSS"],
            }
            : ret,
    mapValues(
        {
            丘丘射手: ["远程丘丘人"],
            射手类丘丘人: ["远程丘丘人"],
            大体格丘丘人: ["丘丘暴徒", "丘丘岩盔王"],
            丘丘王: ["丘丘暴徒", "丘丘岩盔王"],
            兽境之狼: ["兽境幼兽", "兽境猎犬"],
            遗迹机兵: ["遗迹守卫", "遗迹重机", "拟生机关"],
            龙蜥: ["岩龙蜥"],
            深海龙蜥: ["岩龙蜥"],
            黑蛇众: ["黑蛇剑士"],
            雷萤术士: ["雷萤"],
            盗宝团成员: ["盗宝团"],
            野伏众: ["浪人武士"],
            永恒的守护者: ["恒常机关阵列"],
            深海龙蜥之群: ["深海龙蜥组合"],
            "愚人众·债务处理人": ["债务处理人"],
            "愚人众·先遣队": ["先遣队"],
            "愚人众·萤术士": ["召唤师"],
            "愚人众·冬国仕女": ["藏镜侍女"],
        },
        (tags) => {
            const e = values(Enemies).find((e) => tags.indexOf(e.DropTag) > -1);

            return {
                MonsterRarity: e ? e.MonsterRarity : "MONSTER_RARITY_SMALL_ENV_ANIMAL",
                Tags: tags,
            };
        },
    ),
);

var tags = [
    "史莱姆",
    "大史莱姆",
    "魔法生物",
    "元素之核",
    "无相之雷",
    "无相之风",
    "无相之岩",
    "无相之水",
    "无相之冰",
    "无相之火",
    "纯水精灵",
    "飘浮灵",
    "雷音权现",
    "丘丘人",
    "远程丘丘人",
    "丘丘暴徒",
    "丘丘岩盔王",
    "丘丘萨满",
    "深渊法师",
    "深渊使徒",
    "兽境幼兽",
    "兽境猎犬",
    "黄金王兽",
    "黑蛇剑士",
    "先遣队",
    "债务处理人",
    "召唤师",
    "藏镜侍女",
    "遗迹守卫",
    "遗迹重机",
    "遗迹巨蛇",
    "拟生机关",
    "恒常机关阵列",
    "盗宝团",
    "浪人武士",
    "高阶武士",
    "魔偶剑鬼",
    "骗骗花",
    "急冻树",
    "爆炎树",
    "幼岩龙蜥",
    "岩龙蜥",
    "古岩龙蜥水",
    "古岩龙蜥火",
    "古岩龙蜥冰",
    "古岩龙蜥电",
    "深海龙蜥组合",
    "雷萤",
    "蕈兽",
    "采集动物",
    "走兽",
    "鸟类",
    "水族",
    "风魔龙",
    "北风狼",
    "公子",
    "若陀龙王火电",
    "女士",
    "雷电影",
    "雷电将军"
]