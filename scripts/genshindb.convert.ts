import { mapValues, findLast, omit } from "lodash-es";

import {
  writeJSONSync,
  Enemies,
  Dungeons,
  Materials,
  EnemyDropTags,
  WeaponPropGrowCurveValues,
  WeaponPromotes,
  WeaponLevelupExps,
  ArtifactLevelupMainPropValues,
  ArtifactLevelupExps,
  ArtifactAppendPropDepots,
  ArtifactMainPropDepots,
  Artifacts,
  CharactersByKey,
  CharacterPromotes,
  CharacterPropGrowCurveValues,
  CharacterLevelupExps,
  Builds,
  ArtifactSetsByKey,
  WeaponsByKey,
} from "./genshindb";
import { Trials } from "./genshindb/character_trial";
import { OpenConfigs } from "./genshindb/openconfig";

writeJSONSync("./assets/genshindb/characters.json", {
  Characters: mapValues(CharactersByKey, (c: any) => ({
    ...c,
    CharacterBuilds: Builds[c.Name.KEY].reduce((ret, b) => {
      return ({
        ...ret,
        [b.Role]: omit(b, "Role"),
      });
    },{}),
  })),
  CharacterPromotes,
  CharacterPropGrowCurveValues,
  CharacterLevelupExps,
});

writeJSONSync("./assets/genshindb/enemies.json", {
  Enemies,
  EnemyDropTags,
});

writeJSONSync("./assets/genshindb/weapons.json", {
  Weapons: WeaponsByKey,
  WeaponPromotes,
  WeaponPropGrowCurveValues,
  WeaponLevelupExps,
});

writeJSONSync("./assets/genshindb/artifacts.json", {
  Artifacts,
  ArtifactSets: ArtifactSetsByKey,
  ArtifactLevelupExps,
  ArtifactMainPropDepots,
  ArtifactAppendPropDepots,
  ArtifactLevelupMainPropValues,
});

writeJSONSync("./assets/genshindb/materials.json", {
  Materials: Materials,
  Dungeons: Dungeons,
});

writeJSONSync("./assets/trials.json", {
  Trials: Trials,
});

writeJSONSync("./assets/builds.json", {
  Builds: Builds,
});

writeJSONSync("./assets/openconfigs.json", OpenConfigs);


