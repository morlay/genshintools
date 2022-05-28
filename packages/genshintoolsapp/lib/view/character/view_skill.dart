import 'package:collection/collection.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/domain/gamedata.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/gameui.dart';

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
    var finalFightProps = fightProps.merge(FightProps({
      FightProp.ENEMY_LEVEL: 93,
      ...?BlocGameData.read(context).db.enemy.find('急冻树').addProps?.fightProps,
      FightProp.ENEMY_ICE_SUB_HURT: 0.1,
    }, name: '爆炎/急冻树',),);

    return Wrap(
      runSpacing: 8,
      children: [
        ...?skill.paramNames?.map((p) {
          var parts = p.text(Lang.CHS).split('|');

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
                    context,
                    parts[0],
                    parts[1],
                    skill.paramsForLevel(level),
                    finalFightProps,
                  ).map(
                    (e) => Row(
                      children: [
                        Expanded(
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

  Iterable<Widget> _skillValues(BuildContext ctx, String label, String t,
      List<double> params, FightProps fightProps,) {
    if (label == '元素能量') {
      var b = fightProps.calc(t, params);
      var c = fightProps.get(FightProp.CHARGE_EFFICIENCY);

      return [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '前台 (异/无/同)',
              style: TextStyle(fontSize: 8),
            ),
            Text(
              '${(b / (c * 1 / 3)).toStringAsFixed(0)} / ${(b / (c * 2 / 3)).toStringAsFixed(0)} / ${(b / c).toStringAsFixed(0)}',
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '后台 (异/无/同)',
              style: TextStyle(fontSize: 8),
            ),
            Text(
              '${(b / (c * 1 / 3 * 0.6)).toStringAsFixed(0)} / ${(b / (c * 2 / 3 * 0.6)).toStringAsFixed(0)} / ${(b / (c * 0.6)).toStringAsFixed(0)}',
            )
          ],
        )
      ];
    }

    if (t.endsWith('普通攻击伤害')) {
      return [];
    }

    if (label.endsWith('攻击力加成比例')) {
      return [
        BuffList(
          fightProps: fightProps,
          child: Text(
            fightProps.calcAttackAdd(t, params).toStringAsFixed(0),
          ),
        ),
      ];
    }

    if (label.endsWith('继承生命')) {
      return [
        Text(fightProps.calc('$t生命值上限', params).toStringAsFixed(0)),
      ];
    }

    if (label.endsWith('攻击力提高') || label.endsWith('伤害值提升')) {
      return [
        BuffList(
          fightProps: fightProps,
          child: elementalContainer(
            Colors.grey,
            Text(
              fightProps.calc(t, params).toStringAsFixed(0),
            ),
          ),
        )
      ];
    }

    if (label.endsWith('吸收量') || label.endsWith('吸收量上限')) {
      return [
        BuffList(
          fightProps: fightProps,
          child: elementalContainer(
            Colors.brown,
            Text((fightProps.calc(t, params) *
                    (1 + fightProps.get(FightProp.SHIELD_COST_MINUS_RATIO)))
                .toStringAsFixed(0),),
          ),
        )
      ];
    }

    if (label.contains('治疗')) {
      return [
        BuffList(
          fightProps: fightProps,
          child: elementalContainer(
            Colors.green,
            Text((fightProps.calc(t, params) *
                    (1 + fightProps.get(FightProp.HEAL_ADD)))
                .toStringAsFixed(0),),
          ),
        ),
      ];
    }

    if ((label.contains('伤害') && !label.contains('提升')) ||
        label.contains('射击')) {
      var base = FightProp.ATTACK;
      var skillT = t;

      if (t.contains('防御力')) {
        base = FightProp.DEFENSE;
        skillT = t.replaceAll('防御力', '');
      }

      if (t.contains('生命值上限')) {
        base = FightProp.HP;
        skillT = t.replaceAll('生命值上限', '');
      }

      var skillVal = SkillVal(skillT, base: base, params: params);

      var canPhysicalHurt = skill.skillType == SkillType.NORMAL_ATTACK &&
          characterWithState.character.weaponType != WeaponType.Catalyst;

      var hurtType = HurtType.NormalAttack;

      switch (skill.skillType) {
        case SkillType.ELEMENTAL_BURST:
          hurtType = HurtType.ElementalBurst;
          break;
        case SkillType.ELEMENTAL_SKILL:
          hurtType = HurtType.ElementalSkill;
          break;
        default:
          if (label.contains('下坠期间伤害') || label.contains('坠地冲击伤害')) {
            hurtType = HurtType.PlungingAttack;
          } else if (label.contains('段伤害')) {
            hurtType = HurtType.NormalAttack;
          } else {
            hurtType = HurtType.ChangedAttack;
          }
      }

      switch (hurtType) {
        case HurtType.NormalAttack:
          return [
            ...?canPhysicalHurt.ifTrueOrNull(
              () => skillVal.elementAttackAndCriticalHurtValues(
                ctx,
                ElementType.Physical,
                fightProps,
                [
                  FightProp.NORMAL_ATTACK_ADD_HURT,
                ],
              ),
            ),
            ...withPatchedFightProps(fightProps, hurtType, (patchedFightProps) {
              return skillVal.elementAttackAndCriticalHurtValues(
                ctx,
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
                ctx,
                ElementType.Physical,
                fightProps,
                [
                  FightProp.CHARGED_ATTACK_ADD_HURT,
                ],
              ),
            ),
            ...withPatchedFightProps(fightProps, hurtType, (patchedFightProps) {
              return skillVal.elementAttackAndCriticalHurtValues(
                ctx,
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
              ctx,
              ElementType.Physical,
              fightProps,
              [
                FightProp.PLUNGING_ATTACK_ADD_HURT,
              ],
            ),
            ...skillVal.elementAttackAndCriticalHurtValues(
              ctx,
              characterWithState.character.element,
              fightProps,
              [
                FightProp.PLUNGING_ATTACK_ADD_HURT,
              ],
            )
          ];
        case HurtType.ElementalSkill:
          return [
            ...skillVal.elementAttackAndCriticalHurtValues(
              ctx,
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
              ctx,
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
      case '宵宫':
        if (hurtType == HurtType.NormalAttack) {
          var paramsOfE = characterWithState.character.skills
              .firstWhere((e) => e.skillType == SkillType.ELEMENTAL_SKILL)
              .paramsForLevel(
                fightProps.fixSkillLevel(
                  SkillType.ELEMENTAL_SKILL,
                  characterWithState.c.skillLevel(SkillType.ELEMENTAL_SKILL),
                ),
              );

          return fn(
            fightProps.merge(FightProps({
              FightProp.NORMAL_ATTACK_RADIO: paramsOfE[3],
            }, name: '炽焰箭',),),
          ).map((e) => withPrefix('E', e));
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
                        (e) => e.text(Lang.CHS).contains('攻击力提高'),
                      )
                      ?.let(
                        (p) => MapEntry(
                          st,
                          fightProps.calc(
                            p.text(Lang.CHS).split('|')[1],
                            skill.paramsForLevel(
                              fightProps.fixSkillLevel(
                                st,
                                characterWithState.c.skillLevel(st),
                              ),
                            ),
                          ),
                        ),
                      ),
                ) ??
            MapEntry(st, 0),);

        for (final st in skillAttackAdds) {
          var attackAdd = st.value;

          if (attackAdd > 0) {
            switch (characterName) {
              case '胡桃':
                attackAdd = rangeLimit(
                  attackAdd,
                  0,
                  fightProps.get(FightProp.BASE_ATTACK) * 4,
                );
                return fn(
                  fightProps.merge(FightProps({
                    FightProp.ATTACK: attackAdd,
                  }, name: '蝶引来生',),),
                ).map((e) => withPrefix(st.key.string(), e));
              default:
            }

            return fn(fightProps).map((e) => withPrefix(st.key.string(), e));
          }
        }

        return fn(fightProps);
    }
  }
}

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
                        (from) => const EdgeInsets.only(left: 7),) ??
                    const EdgeInsets.all(0),
                child:
                    to?.let((to) => (to != ElementType.Physical).ifTrueOrNull(
                              () => GSImageElement(element: to, size: 14),
                            ),) ??
                        const Text(''),
              ),
              ...?from?.let((from) => [
                    Positioned(
                      left: 0,
                      child: GSImageElement(element: from, size: 14),
                    )
                  ],)
            ],
          ),
        ),
        Expanded(
          child: child,
        ),
      ],),
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
    BuildContext context,
    ElementType elementType,
    FightProps fightProps,
    List<FightProp> hurtAddFightTypes,
  ) {
    return [
      elementalContainer(
        elementColor(elementType),
        _attackAndCriticalHurtValueWith(
          fightProps,
          (r) => fightProps.attackHurt(
            elementType,
            r,
            hurtAddFightTypes,
            base,
          ),
        ),
        to: elementType,
      ),
      ...?(elementType == ElementType.Anemo).ifTrueOrNull(() => [
            _elementalReaction(
              fightProps,
              ElementalReaction.Swirl,
              ElementType.Pyro,
              hurtAddFightTypes,
            ),
            _elementalReaction(
              fightProps,
              ElementalReaction.Swirl,
              ElementType.Cryo,
              hurtAddFightTypes,
            ),
            _elementalReaction(
              fightProps,
              ElementalReaction.Swirl,
              ElementType.Electro,
              hurtAddFightTypes,
            )
          ],),
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
    ].map((e) => BuffList(fightProps: fightProps, child: e));
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
                fightProps.attackHurt(
                  from,
                  r,
                  hurtAddFightTypes,
                  base,
                ),
                from,),
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
                fightProps.attackHurt(
                  from,
                  r,
                  hurtAddFightTypes,
                  base,
                ),
                from,),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.Swirl:
        return elementalContainer(
          elementColor(from),
          Text(
            fightProps
                .elementalReactionHurt(
                  from,
                  ElementalReaction.Swirl,
                )
                .toStringAsFixed(0),
          ),
          from: ElementType.Anemo,
          to: from,
        );
      case ElementalReaction.ElectroCharged:
        to =
            from == ElementType.Hydro ? ElementType.Electro : ElementType.Hydro;
        return elementalContainer(
          elementColor(ElementType.Electro),
          Text(
            fightProps.elementalReactionHurt(from, ea).toStringAsFixed(0) +
                (ea == ElementalReaction.ElectroCharged ? ' * 2' : ''),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.Overloaded:
        to = from == ElementType.Pyro ? ElementType.Electro : ElementType.Pyro;
        return elementalContainer(
          elementColor(ElementType.Pyro),
          Text(
            fightProps.elementalReactionHurt(from, ea).toStringAsFixed(0),
          ),
          from: from,
          to: to,
        );
      case ElementalReaction.SuperConduct:
        to = from == ElementType.Cryo ? ElementType.Electro : ElementType.Cryo;
        return elementalContainer(
          elementColor(ElementType.Cryo),
          Text(
            fightProps.elementalReactionHurt(from, ea).toStringAsFixed(0),
          ),
          from: from,
          to: to,
        );
      default:
    }

    return elementalContainer(
      elementColor(from),
      Text(
        fightProps.elementalReactionHurt(from, ea).toStringAsFixed(0),
      ),
      from: from,
      to: to,
    );
  }

  Iterable<Widget> _splitAndExpand(
      String t, String split, Iterable<Widget> Function(String part) each,) {
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
            '/',
            (part) => _splitAndExpand(
                  part,
                  '+',
                  (p) => _splitAndExpand(
                      p,
                      '*',
                      (t) => [
                            _attackAndCriticalHurtValue(
                              fightProps,
                              fn,
                              t,
                              params,
                            )
                          ],),
                ),)
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
        (radio, i) => fightProps.criticalHurt(fn(radio)).toStringAsFixed(0),);

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
            ],),
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

class BuffList extends StatelessWidget {
  final Widget child;
  final FightProps fightProps;

  const BuffList({
    Key? key,
    required this.child,
    required this.fightProps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Column(
                children: [
                  const ListTile(title: Text('环境与增益')),
                  const Divider(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...fightProps.allFrom
                              .where((fps) => fps.name != null)
                              .map(fightProps.fightPropsConvert)
                              .map((e) => ListTile(
                                    title: Text(e.name ?? ''),
                                    subtitle: Text(e.keys
                                        .map((fp) =>
                                            '${fp.label()}: ${format(e.get(fp), fp.format())}',)
                                        .join('; '),),
                                  ),),
                          const ListTile(title: Text(''))
                        ],
                      ),
                    ),
                  )
                ],
              );
            },);
      },
      child: child,
    );
  }
}
