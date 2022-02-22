import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';

import 'fight_props.dart';
import 'i18n.dart';

part '__generated__/constellation.freezed.dart';
part '__generated__/constellation.g.dart';

@freezed
class GSConstellation with _$GSConstellation {
  GSConstellation._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSConstellation({
    required I18n name,
    required I18n desc,
    required FightProps addProps,
    required List<FightProps> additionalProps,
  }) = _GSConstellation;

  factory GSConstellation.fromJson(Map<String, dynamic> json) =>
      _GSConstellation.fromJson(json);

  get nameID => name.text(Lang.KEY);

  FightProps patchedFightProps() {
    return addProps;
    // switch (name.text(Lang.CHS)) {
    //   case "冒险憧憬":
    //     return addProps.merge(FightProps({
    //       FightProp.ATTACK_ADD_RADIO: params[0],
    //     }, name: name.text(Lang.CHS)));
    //   case "孤舟斩蛟":
    //     return addProps.merge(FightProps({
    //       FightProp.ELEMENTAL_SKILL_RADIO: 1.5,
    //     }, name: name.text(Lang.CHS)));
    //   case "猫爪冰摇":
    //     return addProps.merge(FightProps({
    //       FightProp.ELEMENTAL_SKILL_ADD_HURT: params[0],
    //       FightProp.SHIELD_COST_MINUS_RATIO: params[1]
    //     }, name: name.text(Lang.CHS)));
    //   case "旋风女仆":
    //     return addProps.merge(FightProps({
    //       FightProp.CHARGED_ATTACK_ADD_HURT: params[1],
    //     }, name: name.text(Lang.CHS)));
    // }
    // return addProps;
  }
}
