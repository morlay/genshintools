import { mapValues, omit } from "lodash-es";

import {
  writeJSONSync,
  Enemies,
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
import { OpenConfigs, resolveAndFixProps } from "./genshindb/openconfig";

writeJSONSync("./assets/genshindb/characters.json", {
  Characters: mapValues(CharactersByKey, (c: any) => ({
    ...c,
    CharacterBuilds: (Builds[c.Name.KEY] || []).reduce((ret, b) => {
      return ({
        ...ret,
        [b.Role]: omit(b, "Role"),
      });
    }, {}),
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
});

writeJSONSync("./assets/builds.json", {
  Builds: Builds,
});

const whens: { [k:string]: boolean } = {};

writeJSONSync(
  "./assets/openconfigs.json",
  {
    OpenConfigs: mapValues(OpenConfigs, (c, k) => {
      const props = resolveAndFixProps(k, c.Desc, c.Params, {});

      props.AdditionalProps.forEach((p) => {
        whens[p.$when || ""] = true;
      });

      return ({
        ...props,
        Desc: c.Desc,
      });
    }),
    Whens: whens,
  },
);


