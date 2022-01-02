import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';

part 'generated/player_state.freezed.dart';
part 'generated/player_state.g.dart';

@freezed
class PlayerState with _$PlayerState {
  PlayerState._();

  factory PlayerState({
    required Map<int, CharacterState> characters,
  }) = _PlayerState;

  factory PlayerState.fromJson(Map<String, dynamic> json) =>
      _PlayerState.fromJson(json);

  PlayerState mergeCharacterState(CharacterState cs) {
    return PlayerState(characters: {
      ...characters,
      cs.id: characters[cs.id]?.let(
            (it) => it.copyWith(
              skillLevelsLastSyncAt: cs.skillLevelsLastSyncAt,
              own: cs.own,
              todo: cs.todo,
              level: cs.level,
              activeConstellationNum: cs.activeConstellationNum,
              skillLevels: {
                SkillType.NORMAL_ATTACK: 1,
                SkillType.ELEMENTAL_SKILL: 1,
                SkillType.ELEMENTAL_BURST: 1,
                ...it.skillLevels,
                ...cs.skillLevels,
              },
              defaultBuild: cs.defaultBuild,
              build: it.build.copyWith(
                weaponID: cs.build.weaponID,
                weaponLevel: cs.build.weaponLevel,
                weaponAffixLevel: cs.build.weaponAffixLevel,
                artifacts: cs.build.artifacts,
              ),
            ),
          ) ??
          cs
    });
  }

  CharacterState getCharacterOrInitial(GSDB db, GSCharacter c) {
    return characters[c.id] ?? initial(db, c);
  }

  CharacterState initial(GSDB db, GSCharacter c) {
    var builds = c.characterAllBuilds();

    var build = CharacterBuildState(
      weaponID: c.initialWeaponId,
      weaponLevel: 1,
      weaponAffixLevel: 1,
      artifacts: db.artifact.buildArtifactsBySetPair(
          builds.artifactSetPairs?.getOrNull(0) ?? ["角斗士的终幕礼"], builds, {}),
    );

    return CharacterState(
      id: c.id,
      own: false,
      todo: false,
      level: 1,
      activeConstellationNum: 0,
      skillLevels: {
        SkillType.NORMAL_ATTACK: 1,
        SkillType.ELEMENTAL_SKILL: 1,
        SkillType.ELEMENTAL_BURST: 1,
      },
      build: build,
      defaultBuild: build,
    );
  }
}

@freezed
class CharacterState with _$CharacterState {
  CharacterState._();

  factory CharacterState({
    required int id,
    required int level,
    required int activeConstellationNum,
    required Map<SkillType, int> skillLevels,
    required bool own,
    required bool todo,
    required CharacterBuildState build,
    CharacterBuildState? defaultBuild,
    DateTime? skillLevelsLastSyncAt,
  }) = _CharacterState;

  factory CharacterState.fromJson(Map<String, dynamic> json) =>
      _CharacterState.fromJson(json);

  int skillLevel(SkillType skillType) {
    return skillLevels[skillType] ?? 1;
  }

  CharacterState withWeaponId(int weaponId) {
    return copyWith(
      build: build.copyWith(
        weaponID: weaponId,
      ),
    );
  }

  CharacterState withArtifacts(Map<EquipType, PlayerArtifact> artifacts) {
    return copyWith(
      build: build.copyWith(
        artifacts: artifacts.map(
          (key, value) => MapEntry(
            key,
            value.copyWith(
              level: build.artifacts[key]?.level ?? 0,
            ),
          ),
        ),
      ),
    );
  }

  CharacterState withMainProp(
    GSCharacterBuild builds,
    EquipType et,
    FightProp mainProp,
  ) {
    return copyWith(
      build: build.copyWith(
        artifacts: {
          ...build.artifacts,
          et: build.artifact(et).copyWith(
                main: mainProp,
              )
        },
      ),
    );
  }
}

@freezed
class CharacterBuildState with _$CharacterBuildState {
  CharacterBuildState._();

  factory CharacterBuildState({
    required int weaponID,
    required int weaponLevel,
    required int weaponAffixLevel,
    required Map<EquipType, PlayerArtifact> artifacts,
  }) = _CharacterBuildState;

  factory CharacterBuildState.fromJson(Map<String, dynamic> json) =>
      _CharacterBuildState.fromJson(json);

  PlayerArtifact artifact(EquipType equipType) {
    return artifacts[equipType] ??
        PlayerArtifact(
          equipType: equipType,
          name: {
            EquipType.FLOWER: "角斗士的留恋",
            EquipType.FEATHER: "角斗士的归宿",
            EquipType.SANDS: "角斗士的希冀",
            EquipType.CIRCLET: "角斗士的酣醉",
            EquipType.GOBLET: "角斗士的凯旋",
          }[equipType]!,
          main: {
            EquipType.FLOWER: FightProp.HP,
            EquipType.FEATHER: FightProp.ATTACK,
            EquipType.SANDS: FightProp.ATTACK_PERCENT,
            EquipType.GOBLET: FightProp.ATTACK_PERCENT,
            EquipType.CIRCLET: FightProp.CRITICAL,
          }[equipType]!,
          appends: {},
          rarity: 5,
          level: 1,
          usedBy: 0,
        );
  }
}
