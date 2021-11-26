import puppeteer from "puppeteer";
import {writeFile} from "fs/promises";
import {existsSync, mkdirSync} from "fs";
import axios from "axios";
import {snakeCase} from "lodash";

(async () => {
    const browser = await puppeteer.launch();
    const page = await browser.newPage();

    // 角色
    await page.goto("https://genshin-impact.fandom.com/wiki/Characters", {});

    const characters = await page.evaluate(() => {
        const ret: { [name: string]: string } = {};

        document.querySelectorAll(".article-table img").forEach(($img, i) => {
            const alt = $img.getAttribute("alt") || "";

            if (alt && alt.startsWith("Character") && alt.endsWith("Thumb.png")) {
                const name = alt.slice("Character".length, alt.length - "Thumb.png".length).trim();
                const src = $img.getAttribute("data-src")!.split("/latest/")[0] + "/latest";

                if (src) {
                    ret[`character__${name}`] = src;
                }
            }
        });

        return ret;
    });

    // 武器头像
    await page.goto("https://genshin-impact.fandom.com/wiki/Category:Weapons", {});

    const weapons = await page.evaluate(() => {
        const ret: { [name: string]: string } = {};

        document.querySelectorAll(".category-page__member img").forEach(($icon, i) => {
            const alt = $icon.getAttribute("alt") || "";

            if (alt) {
                const name = alt;
                const src = $icon.getAttribute("data-src")!.split("/latest/")[0] + "/latest";

                if (src) {
                    ret[`weapon__${name}`] = src;
                }
            }
        });

        return ret;
    });

    let icons = {
        ...characters,
        ...weapons,
    };

    // 材料
    const pages = {
        "https://genshin-impact.fandom.com/wiki/Category:Common_Currency": true,
        "https://genshin-impact.fandom.com/wiki/Materials": true,
    };

    for (const p in pages) {
        await page.goto(p, {});

        const materials = await page.evaluate(() => {
            const ret: { [name: string]: string } = {};

            const d = ($icon: Element) => {
                const alt = $icon.getAttribute("alt") || "";
                const src = $icon.getAttribute("data-src") || $icon.getAttribute("src") || "";

                if (alt && (src.startsWith("https://") || src.startsWith("//"))) {
                    const name = alt;
                    const s = src.split("/latest/")[0] + "/latest";

                    if (s) {
                        ret[`material__${name}`] = s;
                    } else {
                        console.log(`invalid ${name}`);
                    }
                }
            };

            document.querySelectorAll(".category-page__member img").forEach(d);
            document.querySelectorAll(".item_image img").forEach(d);

            return ret;
        });

        icons = {
            ...icons,
            ...materials,
        };
    }

    await browser.close();

    const groups: string[][] = [];

    Object.keys(icons).forEach((item, i, array) => {
        const j = i % (array.length / 10);
        groups[j] = [...(groups[j] || []), item];
    });

    mkdirSync(`./assets/images`, {recursive: true})

    for (let i in groups) {
        await Promise.all(
            groups[i].map((name) => {
                return new Promise((resolve, reject) => {
                    const url = `${icons[name]}/scale-to-width-down/256/`;

                    const [cat, n] = name.split("__");

                    const target = `./icons/${cat}__${snakeCase(n)}.png`;

                    if (existsSync(target)) {
                        resolve(undefined);
                        return;
                    }

                    console.log(`fetching ${url}`);

                    axios
                        .get(url, {responseType: "arraybuffer"})
                        .then((r) => writeFile(`./assets/images/${cat}__${snakeCase(n)}.png`, r.data))
                        .then(resolve)
                        .catch(reject);
                });
            }),
        );
    }

    return;
})();
