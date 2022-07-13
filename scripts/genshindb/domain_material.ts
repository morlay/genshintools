import {last, mapKeys, mapValues, uniq} from "lodash-es";
import {groupOne, i18n, i18nWithKey, pascalCase} from "./common";
import {EnemyDropTagAliases} from "./domain_enemy";
import {MaterialExcelConfigData, MaterialSourceDataExcelConfigData} from "./sources";
import {readFileSync} from "fs";
import {dirname, join} from "path";
import {fileURLToPath} from "url";

const __dirname = dirname(fileURLToPath(import.meta.url));

const items = eval(
    `(${String(readFileSync(join(__dirname, "../../datasource/paimon-moe/src/data/itemList.js")))
        .replace("export const itemList = ", "")
        .replace(";", "")})`,
);

const weekdays: { [k: string]: number } = {
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 0,
};

const itemOpenWeekdays = mapValues(
    mapKeys(items, (v, k) => pascalCase(k)),
    (v) => (v.day ? [0, ...v.day.map((day: string) => weekdays[day])] : null),
);

export const MaterialSources = groupOne(
    MaterialSourceDataExcelConfigData,
    (t) => {
        const sources = [...t.textList, ...t.jumpList].map((v) => i18n(v)).filter((n) => !!n.CHS);

        let dropTags: string[] = [];
        let dropFromRarity = "";

        sources.forEach((s) => {
            if (s.CHS.endsWith("掉落")) {
                const dropTagGroup: string = last(s.CHS.split("以上"))?.replace(/(少量)?掉落$/, "") || "";
                if (EnemyDropTagAliases[dropTagGroup]) {
                    dropTags = [...dropTags, ...EnemyDropTagAliases[dropTagGroup].Tags];
                    dropFromRarity = EnemyDropTagAliases[dropTagGroup].MonsterRarity;
                    return;
                }
                console.log(`unknown drop tag ${dropTagGroup}`, s);
            }
            if (s.CHS.endsWith("挑战奖励")) {
                let dropTagGroup: string = last(s.CHS.split("以上"))?.replace(/挑战奖励$/, "") || "";
                if (dropTagGroup === "【征讨领域和北风的王狼】") {
                    dropTagGroup = "BOSS";
                }
                if (EnemyDropTagAliases[dropTagGroup]) {
                    dropTags = [...dropTags, ...EnemyDropTagAliases[dropTagGroup].Tags];
                    dropFromRarity = EnemyDropTagAliases[dropTagGroup].MonsterRarity;
                    return;
                }
                console.log(`unknown drop tag ${dropTagGroup}`, s);
            }
        });

        return {
            DropFromTags: uniq(dropTags).sort(),
            DropFromRarity: dropFromRarity,
            Sources: sources,
        };
    },
    "id",
);

export const Materials = groupOne(
    MaterialExcelConfigData,
    (m) => {
        const n = i18nWithKey(m.nameTextMapHash);

        if (n.CHS == "" || n.CHS.includes("test")) {
            return null;
        }

        let s = MaterialSources[m.id];

        if (n.CHS.endsWith("禽肉")) {
            s = {
                ...s,
                DropFromTags: ["鸟类"],
            };
        }

        if (n.CHS.endsWith("兽肉")) {
            s = {
                ...s,
                DropFromTags: ["走兽"],
            };
        }

        if (n.CHS.endsWith("鱼肉")) {
            s = {
                ...s,
                DropFromTags: ["水族"],
            };
        }

        return {
            ...s,
            Id: m.id,
            Name: n,
            Icon: m.icon || "",
            Desc: i18n(m.descTextMapHash),
            Rarity: m.rankLevel || 0,
            Rank: m.rank || 0,
            MaterialType: m.materialType || "",
            OpenWeekdays: itemOpenWeekdays[n.KEY],
        };
    },
    "id",
);


export const toMaterialCosts = (costItems: Array<{ id?: number, count?: number }>) => {
    return costItems.filter((item) => item.id)
        .map((item) => ({
            MaterialKey: Materials[item.id!].Name.KEY,
            Count: item.count || 0,
        }))
}