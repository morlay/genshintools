import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/types.dart';
import 'package:genshintools/genshindb/utils.dart';

part 'generated/weapon_service.freezed.dart';

part 'generated/weapon_service.g.dart';

@freezed
class WeaponService with _$WeaponService {
  WeaponService._();

  final Map<String, int> _indexes = {};

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory WeaponService({
    Map<int, Weapon>? weapons,
    List<List<int>>? weaponLevelupExps,
    GSPromoteSet? weaponPromotes,
    PropGrowCurveValueSet? weaponPropGrowCurveValues,
  }) = _WeaponService;

  Weapon find(String idOrName) {
    return findOrNull(idOrName)!;
  }

  Weapon? findOrNull(String idOrName) {
    if (_indexes.isEmpty) {
      weapons?.forEach((id, w) {
        _indexes["${w.id}"] = w.id;
        for (var lang in w.name.keys) {
          _indexes[w.name.text(lang)] = w.id;
        }
      });
    }

    return weapons?[_indexes[idOrName]];
  }

  FightProps fightProps(
    String idOrName,
    int level,
    int affixLevel,
  ) {
    var w = find(idOrName);

    var fightProps = FightProps({});

    w.propGrowCurveAndInitials.forEach((fp, value) {
      weaponPropGrowCurveValues
          ?.multi(value.growCurve, value.initial, level)
          .let((v) => fightProps = fightProps.add(fp, v));
    });

    weaponPromotes?.promotedFightProps(w.promoteId, level).let((it) {
      fightProps = fightProps.merge(it);
    });

    if (affixLevel > 0) {
      w.weaponAffixes(affixLevel).forEach((affix) {
        fightProps = fightProps.merge(affix.patchedFightProps());
      });
    }

    return fightProps;
  }

  List<GSMaterialCost> promoteCosts(int promoteId, int current, int to) {
    return weaponPromotes?.promoteCosts(promoteId, current, to) ?? [];
  }

  int levelUpCost(int rarity, int current, int to) {
    return weaponLevelupExps?.let(
          (weaponLevelupExps) => levelUpCostFor(
            weaponLevelupExps[rangeLimit(rarity, 1, 5) - 1],
            current - 1,
            to - 1,
          ),
        ) ??
        -1;
  }

  List<Weapon> toList() => weapons?.values.toList() ?? [];

  factory WeaponService.fromJson(Map<String, dynamic> json) =>
      _$WeaponServiceFromJson(json);
}
