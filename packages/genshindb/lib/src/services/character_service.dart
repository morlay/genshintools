import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';
import 'package:genshindb/types.dart';
import 'package:genshindb/utils.dart';
import 'package:collection/collection.dart';

part '__generated__/character_service.freezed.dart';
part '__generated__/character_service.g.dart';

@freezed
class CharacterService with _$CharacterService {
  CharacterService._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory CharacterService({
    Map<String, GSCharacter>? characters,
    List<int>? characterLevelupExps,
    GSPromoteSet? characterPromotes,
    PropGrowCurveValueSet? characterPropGrowCurveValues,
  }) = _CharacterService;

  factory CharacterService.fromJson(Map<String, dynamic> json) =>
      _CharacterService.fromJson(json);

  GSCharacter find(String keyOrName) {
    var f = findOrNull(keyOrName);
    if (f == null) {
      throw 'character not found $keyOrName';
    }
    return f;
  }

  final Map<String, String> _indexes = {};

  GSCharacter? findOrNull(String keyOrName) {
    if (_indexes.isEmpty) {
      characters?.forEach((key, value) {
        _indexes['${value.id}'] = value.key;
        for (final lang in value.name.keys) {
          _indexes[value.name.text(lang)] = value.key;
        }
      });
    }

    return characters?[_indexes[keyOrName]];
  }

  FightProps fightProps(
    String keyOrName,
    int level,
    int activeTalent,
  ) {
    var c = find(keyOrName);

    var fightProps = FightProps({
      FightProp.LEVEL: level.toDouble(),
      FightProp.CRITICAL: c.critical,
      FightProp.CRITICAL_HURT: c.criticalHurt,
      FightProp.CHARGE_EFFICIENCY: c.chargeEfficiency,
    });

    c.propGrowCurveAndInitials.forEach((fp, value) {
      fightProps = fightProps.add(
          fp,
          characterPropGrowCurveValues!
              .multi(value.growCurve, value.initial, level),);
    });

    c.constellations.forEachIndexed((i, constellation) {
      if (activeTalent > i) {
        fightProps = fightProps.merge(constellation.patchedFightProps());
      }
    });

    c.inherentSkills.forEachIndexed((index, skill) {
      if (level > minLevelFromBreakLevel(skill.breakLevel ?? 1)) {
        fightProps = fightProps.merge(skill.patchedFightProps());
      }
    });

    fightProps = fightProps.merge(
        characterPromotes?.promotedFightProps(c.promoteId, level) ??
            FightProps({}),);

    return fightProps;
  }

  List<GSMaterialCost> promoteCosts(int promoteId, int current, int to) {
    return characterPromotes?.promoteCosts(promoteId, current, to) ?? [];
  }

  int levelUpCost(int current, int to) {
    return characterLevelupExps != null
        ? levelUpCostFor(characterLevelupExps!, current - 1, to - 1)
        : -1;
  }

  List<GSCharacter> toList() => characters?.values.toList() ?? [];
}
