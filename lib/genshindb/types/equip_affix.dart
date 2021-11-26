import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';

import 'fight_props.dart';
import 'i18n.dart';

part 'generated/equip_affix.freezed.dart';
part 'generated/equip_affix.g.dart';

@freezed
class EquipAffix with _$EquipAffix {
  EquipAffix._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory EquipAffix({
    required I18n name,
    required I18n desc,
    required FightProps addProps,
    required List<double> params,
    int? level,
    int? activeWhenNum,
  }) = _EquipAffix;

  factory EquipAffix.fromJson(Map<String, dynamic> json) =>
      _$EquipAffixFromJson(json);

  FightProps patchedFightProps() {
    var fp = addProps;

    switch (activeWhenNum) {
      case 4:
        switch (name.text(Lang.CHS)) {
          case "苍白之火":
            fp = fp.add(FightProp.ATTACK_PERCENT, params[0] * 2);
            break;
          case "炽烈的炎之魔女":
            fp = fp.add(FightProp.OVERLOADED_ADD_HURT, params[0]);
            fp = fp.add(FightProp.SUPER_CONDUCT_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELECTRO_CHARGED_ADD_HURT, params[0]);
            fp = fp.add(FightProp.MELT_ADD_HURT, params[1]);
            fp = fp.add(FightProp.VAPORIZE_ADD_HURT, params[1]);
            break;
          case "如雷的盛怒":
            fp = fp.add(FightProp.OVERLOADED_ADD_HURT, params[0]);
            fp = fp.add(FightProp.SUPER_CONDUCT_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELECTRO_CHARGED_ADD_HURT, params[0]);
            break;
          case "被怜爱的少女":
            fp = fp.add(FightProp.HEALED_ADD, params[0]);
            break;
          case "冰风迷途的勇士":
            fp = fp.add(FightProp.CRITICAL, params[0]);
            break;
          case "平息鸣雷的尊者":
          case "渡过烈火的贤人":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.PLUNGING_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            break;
          case "逆飞的流星":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            break;
          case "沉沦之心":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            break;
          case "追忆之注连":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[1]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[1]);
            fp = fp.add(FightProp.PLUNGING_ATTACK_ADD_HURT, params[1]);
            break;
          case "流浪大地的乐团":
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            break;
          case "翠绿之影":
            fp = fp.add(FightProp.SWIRL_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ENEMY_SUB_RESISTANCE, params[1]);
            break;
          case "角斗士的终幕礼":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            break;
          case "绝缘之旗印":
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT_ON_CHARGE_EFFICIENCY,
                params[0]);
            break;
          case "行者之心":
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_CRITICAL, params[0]);
            break;
          case "战狂":
            fp = fp.add(FightProp.CRITICAL, params[0]);
            break;
          case "武人":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[2]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[2]);
            break;
          case "教官":
            fp = fp.add(FightProp.ELEMENT_MASTERY, params[1]);
            break;
        }
        break;
      case 2:
        switch (name.text(Lang.CHS)) {
          case "赌徒":
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_CRITICAL, params[0]);
            break;
          case "武人":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            break;
          case "昔日宗室之仪":
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            break;
        }
        break;
      default:
        switch (name.text(Lang.CHS)) {
          case "护国的无垢之心":
            fp = fp.add(FightProp.HP_PERCENT, params[0]);
            fp = fp.add(FightProp.ATTACK_PERCENT_ON_HP, params[1]);
            break;
          case "飞雷御执":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[3]);
            break;
          case "矢志不忘":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[1]);
            break;
          case "速射弓斗":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, -params[1]);
            break;
          case "「正义」":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            break;
          case "无矢之歌":
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            break;
          case "船歌":
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_CRITICAL, params[1]);
            break;
          case "名士振舞":
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
            break;
          case "踏火止水":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.PLUNGING_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            break;
          case "踏火息雷":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.PLUNGING_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            break;
          case "斩裂晴空的龙脊":
            fp = fp.add(FightProp.NORMAL_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.CHARGED_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.PLUNGING_ATTACK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_SKILL_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEMENTAL_BURST_ADD_HURT, params[0]);
            break;
          case "浮游四方的灵云":
          case "雾切御腰物":
            fp = fp.add(FightProp.WATER_ADD_HURT, params[0]);
            fp = fp.add(FightProp.FIRE_ADD_HURT, params[0]);
            fp = fp.add(FightProp.WIND_ADD_HURT, params[0]);
            fp = fp.add(FightProp.GRASS_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ROCK_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ICE_ADD_HURT, params[0]);
            fp = fp.add(FightProp.ELEC_ADD_HURT, params[0]);
            break;
          case "非时之梦·常世灶食":
            fp = fp.add(
                FightProp.ATTACK_PERCENT_ON_CHARGE_EFFICIENCY, params[0]);
        }
    }
    return fp;
  }
}
