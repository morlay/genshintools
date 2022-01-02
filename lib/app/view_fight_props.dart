import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/genshindb.dart';
import 'package:genshintools/genshindb/utils.dart';

typedef ShouldHighlight = bool Function(FightProp fightProp);

Map<FightProp, bool> hiddenProps = {
  FightProp.ADD_ELEMENTAL_SKILL_LEVEL: true,
  FightProp.ADD_ELEMENTAL_BURST_LEVEL: true,
};

class ViewFightProps extends HookWidget {
  final FightProps fightProps;
  final bool asDashboard;
  final ShouldHighlight? shouldHighlight;

  const ViewFightProps({
    required this.fightProps,
    this.shouldHighlight,
    this.asDashboard = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sorted = fightProps.keys;

    Iterable<Widget> views = sorted
        .where((k) => fightProps.get(k) != 0)
        .map((k) => _buildFightProp(context, k, fightProps[k], asDashboard)
            ?.let((it) => ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 10 * 6,
                    maxWidth: 10 * 6,
                  ),
                  child: it,
                )))
        .whereType<Widget>();

    return Wrap(
      runAlignment: WrapAlignment.start,
      alignment: WrapAlignment.start,
      runSpacing: 4,
      spacing: 4,
      children: [
        ...views,
      ],
    );
  }

  Widget? _buildFightProp(
      BuildContext context, FightProp k, double v, bool asDashboard) {
    if (asDashboard) {
      switch (k) {
        case FightProp.ADD_ELEMENTAL_SKILL_LEVEL:
          return null;
        case FightProp.ADD_ELEMENTAL_BURST_LEVEL:
          return null;
        case FightProp.BASE_HP:
          return null;
        case FightProp.BASE_ATTACK:
          return null;
        case FightProp.BASE_DEFENSE:
          return null;
        case FightProp.HP:
          return _buildLabelAndValue(
            context,
            k,
            v,
            base: FightProp.BASE_HP,
            baseValue: fightProps.get(FightProp.BASE_HP),
          );
        case FightProp.ATTACK:
          return _buildLabelAndValue(
            context,
            k,
            v,
            base: FightProp.BASE_ATTACK,
            baseValue: fightProps.get(FightProp.BASE_ATTACK),
          );
        case FightProp.DEFENSE:
          return _buildLabelAndValue(
            context,
            k,
            v,
            base: FightProp.BASE_DEFENSE,
            baseValue: fightProps.get(FightProp.BASE_DEFENSE),
          );
        case FightProp.ELEMENT_MASTERY:
          return ExpandableNotifier(
            child: ExpandablePanel(
              collapsed: ExpandableButton(
                child: _buildFightProp(context, k, fightProps[k], false),
              ),
              expanded: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                ),
                child: Wrap(
                  runSpacing: 4,
                  children: [
                    ExpandableButton(
                      child:
                          _buildFightProp(context, k, fightProps.get(k), false),
                    ),
                    ViewFightProps(
                      fightProps: FightProps(
                        elementalReactionAddHurtTypes.map(
                          (ea, fp) => MapEntry(
                              fp,
                              ea.elementMasterAddHurt(
                                fightProps.get(k),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        default:
      }
    }

    return _buildLabelAndValue(context, k, v);
  }

  Widget _buildLabelAndValue(
    BuildContext context,
    FightProp k,
    double v, {
    FightProp? base,
    double? baseValue,
  }) {
    final formatValue = format(v, k.format());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Text(
              k.label(),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 9,
                color: Theme.of(context).hintColor,
                fontWeight: shouldHighlight
                        ?.let((fn) => fn(k))
                        .ifTrueOrNull(() => FontWeight.w900) ??
                    FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SizedBox(
              width: double.infinity,
              child: DefaultTextStyle.merge(
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                  fontWeight: shouldHighlight
                      ?.let((fn) => fn(k))
                      .ifTrueOrNull(() => FontWeight.bold),
                ),
                child: Stack(
                  children: [
                    ...?baseValue
                        ?.let((baseValue) => (baseValue != v))
                        .ifTrueOrNull(() => [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: Text(
                                  format(baseValue, base!.format()),
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                ),
                              )
                            ]),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: baseValue
                                ?.let((baseValue) => baseValue != v)
                                .ifTrueOrNull(
                                    () => const EdgeInsets.only(top: 9)) ??
                            const EdgeInsets.all(0),
                        child: Text.rich(TextSpan(
                          children: [
                            ...formatValue.split("%").mapIndexed((i, e) => i > 0
                                ? const TextSpan(
                                    text: "%",
                                    style: TextStyle(fontSize: 9),
                                  )
                                : TextSpan(text: e))
                          ],
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
