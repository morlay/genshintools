import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/app/gamedata/gamedata.dart';
import 'package:genshintools/app/gameui/gameui.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/utils.dart';

class ViewSkillValues extends HookWidget {
  final CharacterWithState characterWithState;
  final Skill skill;
  final int level;
  final FightProps fightProps;

  const ViewSkillValues({
    required this.characterWithState,
    required this.skill,
    required this.level,
    required this.fightProps,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      children: [
        ...?skill.paramNames?.map((p) {
          var parts = p.text(Lang.CHS).split("|");

          return Column(
            children: [
              SizedBox(
                height: 32,
                child: Row(
                  children: [
                    Text(
                      parts[0],
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        parseParamName(parts[1], skill.paramsForLevel(level)),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 9,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Wrap(
                runSpacing: 2,
                children: [
                  ..._skillValues(
                    parts[0],
                    parts[1],
                    skill.paramsForLevel(level),
                  ).map(
                    (e) => Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DefaultTextStyle.merge(
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            child: e,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        })
      ],
    );
  }

  Iterable<Widget> _skillValues(String label, String t, List<double> params) {
    if (t.endsWith("普通攻击伤害")) {
      return [];
    }

    if (label.endsWith("攻击力加成比例")) {
      return [
        Text(
          (fightProps.calc("$t基础攻击力", params) +
                  fightProps.calc(
                    "{param1:F2P}基础攻击力",
                    [fightProps.get(FightProp.ATTACK_ADD_RADIO)],
                  ))
              .toStringAsFixed(0),
        ),
      ];
    }

    if (label.endsWith("继承生命")) {
      return [
        Text(fightProps.calc(t + "生命值上限", params).toStringAsFixed(0)),
      ];
    }

    if (label.endsWith("攻击力提高")) {
      return [
        Text(
          fightProps.calc(t, params).toStringAsFixed(0),
        )
      ];
    }

    if (label.endsWith("吸收量")) {
      return [
        Text((fightProps.calc(t, params) *
                (1 + fightProps.get(FightProp.SHIELD_COST_MINUS_RATIO)))
            .toStringAsFixed(0))
      ];
    }

    if (label.contains("治疗")) {
      return [
        Text((fightProps.calc(t, params) *
                (1 + fightProps.get(FightProp.HEAL_ADD)))
            .toStringAsFixed(0))
      ];
    }

    if (label.contains("伤害") || label.contains("射击")) {
      var base = FightProp.ATTACK;
      var skillT = t;

      if (t.endsWith("防御力")) {
        base = FightProp.DEFENSE;
        skillT = t.replaceAll("防御力", "");
      }

      var skillVal = SkillVal(skillT, base: base, params: params);

      var canPhysicalHurt = skill.skillType == SkillType.NORMAL_ATTACK &&
          characterWithState.character.weaponType != WeaponType.CATALYST;

      var hurtType = HurtType.NormalAttack;

      switch (skill.skillType) {
        case SkillType.ELEMENTAL_BURST:
          hurtType = HurtType.ElementalBurst;
          break;
        case SkillType.ELEMENTAL_SKILL:
          hurtType = HurtType.ElementalSkill;
          break;
        default:
          if (skill.skillType == SkillType.NORMAL_ATTACK &&
              !label.contains("段")) {
            hurtType = HurtType.ElementalSkill;
          }

          if (label.contains("重击") ||
              label.contains("蓄力") ||
              label.contains("瞄准")) {
            hurtType = HurtType.ChangedAttack;
          }

          if (label.contains("下坠期间伤害") || label.contains("坠地冲击伤害")) {
            hurtType = HurtType.PlungingAttack;
          }
      }

      switch (hurtType) {
        case HurtType.NormalAttack:
          return [
            ...?canPhysicalHurt.ifTrueOrNull(
              () => skillVal.elementAttackAndCriticalHurtValues(
                ElementType.Physical,
                fightProps,
                [
                  FightProp.NORMAL_ATTACK_ADD_HURT,
                ],
              ),
            ),
            ...withPatchedFightProps(fightProps, hurtType, (patchedFightProps) {
              return skillVal.elementAttackAndCriticalHurtValues(
                characterWithState.character.element,
                patchedFightProps,
                [
                  FightProp.NORMAL_ATTACK_ADD_HURT,
                ],
              );
            }),
          ];
        case HurtType.ChangedAttack:
          return [
            ...?canPhysicalHurt.ifTrueOrNull(
              () => skillVal.elementAttackAndCriticalHurtValues(
                ElementType.Physical,
                fightProps,
                [
                  FightProp.CHARGED_ATTACK_ADD_HURT,
                ],
              ),
            ),
            ...withPatchedFightProps(fightProps, hurtType, (patchedFightProps) {
              return skillVal.elementAttackAndCriticalHurtValues(
                characterWithState.character.element,
                patchedFightProps,
                [
                  FightProp.CHARGED_ATTACK_ADD_HURT,
                ],
              );
            }),
          ];
        case HurtType.PlungingAttack:
          return [
            ...skillVal.elementAttackAndCriticalHurtValues(
              ElementType.Physical,
              fightProps,
              [
                FightProp.CHARGED_ATTACK_ADD_HURT,
              ],
            ),
          ];
        case HurtType.ElementalSkill:
          return [
            ...skillVal.elementAttackAndCriticalHurtValues(
              characterWithState.character.element,
              fightProps,
              [
                FightProp.ELEMENTAL_SKILL_ADD_HURT,
              ],
            ),
          ];
        case HurtType.ElementalBurst:
          return [
            ...skillVal.elementAttackAndCriticalHurtValues(
              characterWithState.character.element,
              fightProps,
              [
                FightProp.ELEMENTAL_BURST_ADD_HURT,
              ],
            ),
          ];
        default:
      }

      return [];
    }

    return [];
  }

  Widget withPrefix(String prefix, Widget e) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          child: Text(
            prefix,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Row(
          children: [Expanded(child: e)],
        )
      ],
    );
  }

  Iterable<Widget> withPatchedFightProps(
    FightProps fightProps,
    HurtType hurtType,
    Iterable<Widget> Function(FightProps fightProps) fn,
  ) {
    var characterName = characterWithState.character.name.text(Lang.CHS);

    switch (characterName) {
      case "宵宫":
        if (hurtType == HurtType.NormalAttack) {
          var paramsOfE = characterWithState.character.skills
              .firstWhere((e) => e.skillType == SkillType.ELEMENTAL_SKILL)
              .paramsForLevel(
                fightProps.fixSkillLevel(
                    SkillType.ELEMENTAL_SKILL,
                    characterWithState.state
                        .skillLevel(SkillType.ELEMENTAL_SKILL)),
              );

          return fn(
            fightProps.add(
              FightProp.NORMAL_ATTACK_ADD_HURT,
              paramsOfE[0],
            ),
          ).map((e) => withPrefix("E", e));
        }
        return fn(fightProps);
      default:
        Iterable<MapEntry<SkillType, double>> skillAttackAdds = [
          SkillType.ELEMENTAL_SKILL,
          SkillType.ELEMENTAL_BURST,
        ].map((st) =>
            characterWithState.character.skills
                .firstWhereOrNull((e) => e.skillType == st)
                ?.let(
                  (skill) => skill.paramNames
                      ?.firstWhereOrNull(
                        (e) => e.text(Lang.CHS).contains("攻击力提高"),
                      )
                      ?.let(
                        (p) => MapEntry(
                          st,
                          fightProps.calc(
                            p.text(Lang.CHS).split("|")[1],
                            skill.paramsForLevel(
                              fightProps.fixSkillLevel(
                                st,
                                characterWithState.state.skillLevel(st),
                              ),
                            ),
                          ),
                        ),
                      ),
                ) ??
            MapEntry(st, 0.0));

        for (var st in skillAttackAdds) {
          var attackAdd = st.value;

          if (attackAdd > 0) {
            switch (characterName) {
              case "胡桃":
                attackAdd = rangeLimit(
                  attackAdd,
                  0,
                  fightProps.get(FightProp.BASE_ATTACK) * 4,
                );
                break;
              default:
            }

            return fn(
              fightProps.add(FightProp.ATTACK, attackAdd),
            ).map((e) => withPrefix(st.key.string(), e));
          }
        }

        return fn(fightProps);
    }
  }
}

Map<ElementType, FightProp> elementFightProps = {
  ElementType.Pyro: FightProp.FIRE_ADD_HURT,
  ElementType.Electro: FightProp.ELEC_ADD_HURT,
  ElementType.Hydro: FightProp.WATER_ADD_HURT,
  ElementType.Cryo: FightProp.ICE_ADD_HURT,
  ElementType.Anemo: FightProp.WIND_ADD_HURT,
  ElementType.Geo: FightProp.ROCK_ADD_HURT,
  ElementType.Dendro: FightProp.GRASS_ADD_HURT,
  ElementType.Physical: FightProp.PHYSICAL_ADD_HURT,
};

Widget elementalContainer(
  Color color,
  Widget child, {
  ElementType? from,
  ElementType? to,
}) {
  return Container(
    constraints: const BoxConstraints(
      minHeight: 32,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 6),
    decoration: BoxDecoration(
      color: color.withOpacity(0.04),
    ),
    child: DefaultTextStyle.merge(
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
      child: Row(children: [
        Padding(
          padding: from?.let((from) => const EdgeInsets.only(right: 4)) ??
              const EdgeInsets.all(0),
          child: Stack(
            children: [
              Padding(
                padding: from?.let(
                        (from) => const EdgeInsets.only(top: 0, left: 7)) ??
                    const EdgeInsets.all(0),
                child:
                    to?.let((to) => (to != ElementType.Physical).ifTrueOrNull(
                              () => GSImageElement(element: to, size: 14),
                            )) ??
                        const Text(""),
              ),
              ...?from?.let((from) => [
                    Positioned(
                      left: 0,
                      child: GSImageElement(element: from, size: 14),
                    )
                  ])
            ],
          ),
        ),
        Expanded(
          child: child,
        ),
      ]),
    ),
  );
}

class SkillVal {
  final String t;
  final FightProp base;
  final List<double> params;

  const SkillVal(
    this.t, {
    required this.base,
    required this.params,
  });

  Iterable<Widget> elementAttackAndCriticalHurtValues(
    ElementType elementType,
    FightProps fightProps,
    List<FightProp> hurtAddFightTypes,
  ) {
    return [
      elementalContainer(
        elementColor(elementType),
        _attackAndCriticalHurtValueWith(
          fightProps,
          (r) =>
              r *
              fightProps.attackHurt(
                [elementFightProps[elementType]!, ...hurtAddFightTypes],
                base,
              ),
        ),
        to: elementType,
      ),
      ...elementType == ElementType.Anemo
          ? [
              _swirlHurt(fightProps),
            ]
          : [],
      ...elementType == ElementType.Pyro
          ? [
              _elementalReaction(
                fightProps,
                ElementalReaction.Vaporize,
                ElementType.Pyro,
                hurtAddFightTypes,
              ),
              _elementalReaction(
                fightProps,
                ElementalReaction.Melt,
                ElementType.Pyro,
                hurtAddFightTypes,
              ),
              _elementalReaction(
                fightProps,
                ElementalReaction.Overloaded,
                ElementType.Pyro,
                hurtAddFightTypes,
              )
            ]
          : [],
      ...elementType == ElementType.Electro
          ? [
              _elementalReaction(
                fightProps,
                ElementalReaction.ElectroCharged,
                ElementType.Electro,
                hurtAddFightTypes,
              ),
              _elementalReaction(
                fightProps,
                ElementalReaction.Overloaded,
                ElementType.Electro,
                hurtAddFightTypes,
              ),
              _elementalReaction(
                fightProps,
                ElementalReaction.SuperConduct,
                ElementType.Electro,
                hurtAddFightTypes,
              )
            ]
          : [],
      ...elementType == ElementType.Cryo
          ? [
              _elementalReaction(
                fightProps,
                ElementalReaction.Melt,
                ElementType.Cryo,
                hurtAddFightTypes,
              ),
              _elementalReaction(
                fightProps,
                ElementalReaction.SuperConduct,
                ElementType.Cryo,
                hurtAddFightTypes,
              )
            ]
          : [],
      ...elementType == ElementType.Hydro
          ? [
              _elementalReaction(
                fightProps,
                ElementalReaction.Vaporize,
                ElementType.Hydro,
                hurtAddFightTypes,
              ),
              _elementalReaction(
                fightProps,
                ElementalReaction.ElectroCharged,
                ElementType.Hydro,
                hurtAddFightTypes,
              ),
            ]
          : [],
    ];
  }

  Widget _elementalReaction(
    FightProps fightProps,
    ElementalReaction ea,
    ElementType from,
    List<FightProp> hurtAddFightTypes,
  ) {
    ElementType to = ElementType.Anemo;

    switch (ea) {
      case ElementalReaction.Vaporize:
        to = from == ElementType.Pyro ? ElementType.Hydro : ElementType.Pyro;

        return elementalContainer(
          elementColor(from),
          _attackAndCriticalHurtValueWith(
            fightProps,
            (r) => fightProps.vaporizeHurt(
                r *
                    fightProps.attackHurt(
                      [elementFightProps[from]!, ...hurtAddFightTypes],
                      base,
                    ),
                from),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.Melt:
        to = from == ElementType.Pyro ? ElementType.Cryo : ElementType.Pyro;

        return elementalContainer(
          elementColor(from),
          _attackAndCriticalHurtValueWith(
            fightProps,
            (r) => fightProps.meltHurt(
                r *
                    fightProps.attackHurt(
                      [elementFightProps[from]!, ...hurtAddFightTypes],
                      base,
                    ),
                from),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.ElectroCharged:
        to =
            from == ElementType.Hydro ? ElementType.Electro : ElementType.Hydro;
        return elementalContainer(
          elementColor(ElementType.Electro),
          Text(
            fightProps.elementalReactionHurt(ea).toStringAsFixed(0) +
                (ea == ElementalReaction.ElectroCharged ? " * 2" : ""),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.Overloaded:
        to = from == ElementType.Pyro ? ElementType.Electro : ElementType.Pyro;
        return elementalContainer(
          elementColor(ElementType.Pyro),
          Text(
            fightProps.elementalReactionHurt(ea).toStringAsFixed(0),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.SuperConduct:
        to = from == ElementType.Cryo ? ElementType.Electro : ElementType.Cryo;
        return elementalContainer(
          elementColor(ElementType.Cryo),
          Text(
            fightProps.elementalReactionHurt(ea).toStringAsFixed(0),
          ),
          from: from,
          to: to,
        );
      default:
    }

    return elementalContainer(
      elementColor(from),
      Text(
        fightProps.elementalReactionHurt(ea).toStringAsFixed(0),
      ),
      from: from,
      to: to,
    );
  }

  Widget _swirlHurt(FightProps fightProps) {
    return elementalContainer(
      elementColor(ElementType.Anemo),
      Row(
        children: [
          ...[
            ElementType.Pyro,
            ElementType.Cryo,
            ElementType.Electro,
          ].map((e) => Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: GSImageElement(element: e, size: 14),
                    ),
                    const Positioned(
                      left: 0,
                      child:
                          GSImageElement(element: ElementType.Anemo, size: 14),
                    )
                  ],
                ),
              )),
          Expanded(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    elementColor(ElementType.Pyro),
                    elementColor(ElementType.Cryo),
                    elementColor(ElementType.Electro),
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              blendMode: BlendMode.srcATop,
              child: Text(
                fightProps
                    .elementalReactionHurt(ElementalReaction.Swirl)
                    .toStringAsFixed(0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Iterable<Widget> _splitAndExpand(
      String t, String split, Iterable<Widget> Function(String part) each) {
    return t.split(split).expandIndexed(
          (i, part) => [
            ...?(i > 0).ifTrueOrNull(() => [Text(split)]),
            ...each(part),
          ],
        );
  }

  Widget _attackAndCriticalHurtValueWith(
    FightProps fightProps,
    double Function(double radio) fn,
  ) {
    return Wrap(
      alignment: WrapAlignment.end,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 2,
      runSpacing: -1,
      children: [
        ..._splitAndExpand(
            t,
            "/",
            (part) => _splitAndExpand(
                  part,
                  "+",
                  (p) => _splitAndExpand(
                      p,
                      "*",
                      (t) => [
                            _attackAndCriticalHurtValue(
                              fightProps,
                              fn,
                              t,
                              params,
                            )
                          ]),
                ))
      ],
    );
  }

  Widget _attackAndCriticalHurtValue(
    FightProps fightProps,
    double Function(double radio) fn,
    String t,
    List<double> params,
  ) {
    var v = exec(t, params, (radio, i) => fn(radio).toStringAsFixed(0));
    var crit = exec(t, params,
        (radio, i) => fightProps.criticalHurt(fn(radio)).toStringAsFixed(0));

    return Stack(
      children: [
        ...?(v != crit).ifTrueOrNull(() => [
              Positioned(
                top: 0,
                right: 0,
                child: Text(
                  v,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ]),
        Padding(
          padding:
              (v != crit).ifTrueOrNull(() => const EdgeInsets.only(top: 9)) ??
                  const EdgeInsets.all(0),
          child: Text(
            crit,
          ),
        ),
      ],
    );
  }
}
