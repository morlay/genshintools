import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';
import 'package:genshindb/utils.dart';
import 'package:collection/collection.dart';

import 'equip_affix.dart';
import 'i18n.dart';
import 'prop_grow_curve.dart';

part '__generated__/weapon.freezed.dart';
part '__generated__/weapon.g.dart';

@freezed
class GSWeapon with _$GSWeapon {
  GSWeapon._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSWeapon({
    required int id,
    required I18n name,
    required I18n desc,
    required int rarity,
    @WeaponTypeStringConverter() required WeaponType weaponType,
    required List<List<EquipAffix>> affixes,
    required int promoteId,
    @FightPropStringConverter()
        required Map<FightProp, PropGrowCurveAndInitial>
            propGrowCurveAndInitials,
  }) = _GSWeapon;

  factory GSWeapon.fromJson(Map<String, dynamic> json) =>
      _GSWeapon.fromJson(json);

  get key => name.text(Lang.KEY);

  List<EquipAffix> weaponAffixes(int affixLevel) {
    affixLevel = rangeLimit(affixLevel, 1, 5);
    List<EquipAffix> picked = [];

    affixes.forEachIndexed((i, list) {
      picked.add(list[affixLevel - 1]);
    });

    return picked;
  }

  @override
  int get hashCode => key.hashCode;

  @override
  bool operator ==(Object other) {
    return other is GSWeapon && other.hashCode == hashCode;
  }
}
