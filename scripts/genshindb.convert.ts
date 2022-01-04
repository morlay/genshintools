import { mapValues } from "lodash-es";

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
  Builds,
} from "./genshindb";

writeJSONSync("./assets/genshindb/characters.json", {
  Characters: mapValues(Characters, (c: any) => ({
    ...c,
    CharacterBuild: Builds[c.Name.ID],
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
