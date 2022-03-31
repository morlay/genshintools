import 'package:freezed_annotation/freezed_annotation.dart';

import 'fight_props.dart';
import 'i18n.dart';

part '__generated__/equip_affix.freezed.dart';
part '__generated__/equip_affix.g.dart';

@freezed
class EquipAffix with _$EquipAffix {
  EquipAffix._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory EquipAffix({
    required I18n name,
    required I18n desc,
    required FightProps addProps,
    required List<FightProps> additionalProps,
    int? level,
    int? activeWhenNum,
  }) = _EquipAffix;

  factory EquipAffix.fromJson(Map<String, dynamic> json) =>
      _$EquipAffixFromJson(json);

  FightProps patchedFightProps() {
    return addProps;
  }
}
