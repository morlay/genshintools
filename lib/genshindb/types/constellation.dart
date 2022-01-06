import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';

import 'fight_props.dart';
import 'i18n.dart';

part 'generated/constellation.freezed.dart';
part 'generated/constellation.g.dart';

@freezed
class GSConstellation with _$GSConstellation {
  GSConstellation._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSConstellation({
    required I18n name,
    required I18n desc,
    required FightProps addProps,
    required List<double> params,
  }) = _GSConstellation;

  factory GSConstellation.fromJson(Map<String, dynamic> json) =>
      _GSConstellation.fromJson(json);

  get nameID => name.text(Lang.KEY);

  FightProps patchedFightProps() {
    var fp = addProps;
    switch (name.text(Lang.CHS)) {
      case "冒险憧憬":
        fp = fp.add(FightProp.ATTACK_ADD_RADIO, params[0]);
        break;
      case "猫爪冰摇":
        fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
        fp = fp.add(FightProp.SHIELD_COST_MINUS_RATIO, params[1]);
        break;
      case "旋风女仆":
        fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[1]);
        break;
    }
    return fp;
  }
}
