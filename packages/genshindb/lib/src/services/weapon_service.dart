import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/extension.dart';
import 'package:genshindb/types.dart';
import 'package:genshindb/utils.dart';

part '__generated__/weapon_service.freezed.dart';
part '__generated__/weapon_service.g.dart';

@freezed
class WeaponService with _$WeaponService {
  WeaponService._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory WeaponService({
    Map<String, GSWeapon>? weapons,
    List<List<int>>? weaponLevelupExps,
    GSPromoteSet? weaponPromotes,
    PropGrowCurveValueSet? weaponPropGrowCurveValues,
  }) = _WeaponService;

  GSWeapon find(String keyOrName) {
    final f = findOrNull(keyOrName);
    if (f == null) {
      throw "weapon $keyOrName not found";
    }
    return f;
  }

  final Map<String, String> _indexes = {};

  GSWeapon? findOrNull(String keyOrName) {
    if (_indexes.isEmpty) {
      weapons?.forEach((id, w) {
        _indexes["${w.id}"] = w.key;
        for (var lang in w.name.keys) {
          _indexes[w.name.text(lang)] = w.key;
        }
      });
    }

    return weapons?[_indexes[keyOrName]];
  }

  FightProps fightProps(
    String keyOrName,
    int level,
    int affixLevel,
  ) {
    var w = find(keyOrName);

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

  List<GSWeapon> toList() => weapons?.values.toList() ?? [];

  factory WeaponService.fromJson(Map<String, dynamic> json) =>
      _$WeaponServiceFromJson(json);
}
