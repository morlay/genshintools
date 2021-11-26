import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/types.dart';
import 'package:genshintools/genshindb/utils.dart';

part 'generated/character_service.freezed.dart';
part 'generated/character_service.g.dart';

@freezed
class CharacterService with _$CharacterService {
  CharacterService._();

  final Map<String, int> _indexes = {};

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory CharacterService({
    Map<int, GSCharacter>? characters,
    List<int>? characterLevelupExps,
    GSPromoteSet? characterPromotes,
    PropGrowCurveValueSet? characterPropGrowCurveValues,
  }) = _CharacterService;

  factory CharacterService.fromJson(Map<String, dynamic> json) =>
      _CharacterService.fromJson(json);

  GSCharacter find(String idOrName) {
    return findOrNull(idOrName)!;
  }

  GSCharacter? findOrNull(String idOrName) {
    if (_indexes.isEmpty) {
      characters?.forEach((key, value) {
        _indexes["${value.id}"] = value.id;
        for (var lang in value.name.keys) {
          _indexes[value.name.text(lang)] = value.id;
        }
      });
    }

    return characters?[_indexes[idOrName]];
  }

  FightProps fightProps(
    String idOrName,
    int level,
    int activeTalent,
  ) {
    var c = find(idOrName);
    if (c == null) {
      return FightProps({});
    }

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
              .multi(value.growCurve, value.initial, level));
    });

    c.constellations.forEachIndexed((i, constellation) {
      if (activeTalent > i) {
        fightProps = fightProps.merge(constellation.patchedFightProps());
      }
    });

    fightProps = fightProps.merge(
        characterPromotes?.promotedFightProps(c.promoteId, level) ??
            FightProps({}));

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
