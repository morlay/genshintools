import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';
import 'package:genshintoolsapp/view/gameui.dart';

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
        .map(
          (k) => _buildFightProp(context, k, fightProps[k]!, asDashboard)?.let(
            (it) => ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 10 * 6,
                maxWidth: 10 * 8,
              ),
              child: it,
            ),
          ),
        )
        .whereType<Widget>();

    return Wrap(
      runSpacing: 0,
      spacing: 4,
      children: [
        ...views,
      ],
    );
  }

  Widget? _buildFightProp(
    BuildContext context,
    FightProp k,
    double v,
    bool asDashboard,
  ) {
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
                child: _buildFightProp(context, k, fightProps[k]!, false),
              ),
              expanded: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                ),
                child: Wrap(
                  runSpacing: 0,
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
                            ),
                          ),
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
    FightProp fightProp,
    double value, {
    FightProp? base,
    double? baseValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: FightPropView(
        fightProp: fightProp,
        value: value,
        highlight: shouldHighlight?.let((fn) => fn(fightProp)),
        calcValue: (fp, v) {
          if (baseValue != null) {
            return baseValue;
          }
          return null;
        },
      ),
    );
  }
}
