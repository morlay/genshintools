import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';
import 'package:genshintools/genshindb/utils.dart';

import 'equip_affix.dart';
import 'i18n.dart';
import 'prop_grow_curve.dart';

part 'generated/weapon.freezed.dart';
part 'generated/weapon.g.dart';

@freezed
class Weapon with _$Weapon {
  Weapon._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory Weapon({
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
  }) = _Weapon;

  factory Weapon.fromJson(Map<String, dynamic> json) => _Weapon.fromJson(json);

  get nameID => name.text(Lang.ID);

  List<EquipAffix> weaponAffixes(int affixLevel) {
    affixLevel = rangeLimit(affixLevel, 1, 5);
    List<EquipAffix> picked = [];

    affixes.forEachIndexed((i, list) {
      picked.add(list[affixLevel - 1]);
    });

    return picked;
  }

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) {
    return other is Weapon && other.hashCode == hashCode;
  }
}
