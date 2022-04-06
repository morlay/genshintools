import 'package:collection/collection.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';

typedef ShouldHighlight = bool Function(FightProp fightProp);
typedef ShouldCalc = double Function(FightProp fightProp, double value);

Map<FightProp, bool> hiddenProps = {
  FightProp.ADD_ELEMENTAL_SKILL_LEVEL: true,
  FightProp.ADD_ELEMENTAL_BURST_LEVEL: true,
};

class ViewFightProps extends HookWidget {
  final FightProps fightProps;
  final bool asDashboard;
  final ShouldHighlight? shouldHighlight;
  final ShouldCalc? shouldCalc;

  const ViewFightProps({
    required this.fightProps,
    this.shouldHighlight,
    this.shouldCalc,
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
                    maxWidth: 10 * 8,
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
        case FightProp.ADD_ELEMENTAL_BURST_LEVEL:
        case FightProp.BASE_HP:
        case FightProp.BASE_ATTACK:
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

    if (shouldCalc == null) {
      return _buildLabelAndValue(context, k, v);
    }

    switch (k) {
      case FightProp.HP_PERCENT:
        return _buildLabelAndValue(
          context,
          k,
          v,
          base: FightProp.HP,
          baseValue: shouldCalc!(k, v),
        );
      case FightProp.ATTACK_PERCENT:
        return _buildLabelAndValue(
          context,
          k,
          v,
          base: FightProp.ATTACK,
          baseValue: shouldCalc!(k, v),
        );
      case FightProp.DEFENSE_PERCENT:
        return _buildLabelAndValue(
          context,
          k,
          v,
          base: FightProp.DEFENSE,
          baseValue: shouldCalc!(k, v),
        );
      default:
        return _buildLabelAndValue(context, k, v);
    }
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
      child: DefaultTextStyle.merge(
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).primaryColor,
          fontFeatures: const [FontFeature.tabularFigures()],
          fontWeight: shouldHighlight
              ?.let((fn) => fn(k))
              .ifTrueOrNull(() => FontWeight.bold),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                k.label(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 9,
                  color: Theme.of(context).hintColor,
                  fontWeight: shouldHighlight
                      ?.let((fn) => fn(k))
                      .ifTrueOrNull(() => FontWeight.w900),
                ),
              ),
            ),
            Wrap(
              spacing: 2,
              runSpacing: -1,
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: asDashboard ? double.infinity : null,
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
                ...?baseValue
                    ?.let((baseValue) => (baseValue != v))
                    .ifTrueOrNull(
                      () => [
                        Text(
                          format(baseValue, base!.format()),
                          style: const TextStyle(
                            fontSize: 8,
                          ),
                        )
                      ],
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
