import {
  writeJSONSync,
  Enemies,
  Dungeons,
  Materials,
  EnemyDropTags,
  WeaponPropGrowCurveValues,
  WeaponPromotes,
  Weapons,
  WeaponLevelupExps,
  ArtifactSets,
  ArtifactLevelupMainPropValues,
  ArtifactLevelupExps,
  ArtifactAppendPropDepots,
  ArtifactMainPropDepots,
  Artifacts,
  Characters,
  CharacterPromotes,
  CharacterPropGrowCurveValues,
  CharacterLevelupExps,
} from "./genshindb";
import { Trials } from "./genshindb/character_trial";

writeJSONSync("./assets/genshindb/characters.json", {
  Characters,
  CharacterPromotes,
  CharacterPropGrowCurveValues,
  CharacterLevelupExps,
});

writeJSONSync("./assets/genshindb/enemies.json", {
  Enemies,
  EnemyDropTags,
});

writeJSONSync("./assets/genshindb/weapons.json", {
  Weapons,
  WeaponPromotes,
  WeaponPropGrowCurveValues,
  WeaponLevelupExps,
});

writeJSONSync("./assets/genshindb/artifacts.json", {
  Artifacts,
  ArtifactSets,
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
