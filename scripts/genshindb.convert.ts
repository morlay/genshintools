import { mapValues, findLast } from "lodash-es";

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

writeJSONSync("./assets/genshindb/characters.json", {
  Characters: mapValues(CharactersByKey, (c: any) => ({
    ...c,
    CharacterBuild: findLast(Builds[c.Name.KEY], (b) => b.Recommended),
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

