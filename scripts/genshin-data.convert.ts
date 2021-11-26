import {writeFileSync, mkdirSync} from "fs";
import {characters, reliquaries, weapons, trials, levelExps, materials} from "./genshin-data";

mkdirSync("./assets/genshindb", {recursive: true})

writeFileSync("./assets/genshindb/trials.json", JSON.stringify(trials(), null, 2));
writeFileSync("./assets/genshindb/characters.json", JSON.stringify(characters(), null, 2));
writeFileSync("./assets/genshindb/weapons.json", JSON.stringify(weapons(), null, 2));
writeFileSync("./assets/genshindb/materials.json", JSON.stringify(materials(), null, 2));
writeFileSync("./assets/genshindb/reliquaries.json", JSON.stringify(reliquaries(), null, 2));
writeFileSync("./assets/genshindb/level_exps.json", JSON.stringify(levelExps(), null, 2));
