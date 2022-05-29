import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';

class EquipCard extends HookWidget {
  final String name;
  final Widget avatar;
  final Widget? title;
  final Widget info;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;

  const EquipCard({
    required this.name,
    required this.avatar,
    this.title,
    required this.info,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: 0,
                    left: -10,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        name,
                        style: const TextStyle(fontSize: 6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: avatar,
                  ),
                ],
              ),
              ...?title?.let((t) => [t]),
            ],
          ),
          info,
        ],
      ),
    );
  }
}

class FightPropView extends HookWidget {
  static String shortName(FightProp fightProp) {
    switch (fightProp) {
      case FightProp.LEVEL:
        return "等级";
      case FightProp.CHARGE_EFFICIENCY:
        return '充';
      case FightProp.ELEMENT_MASTERY:
        return '精';
      case FightProp.CRITICAL:
        return '％暴';
      case FightProp.CRITICAL_HURT:
        return '暴伤';
      default:
        if (fightProp.name.contains('BASE_')) {
          // 基础
          return '基${fightPropAlias(fightProp)}';
        }
        if (fightProp.name.contains('_EXTRA_HURT')) {
          return '附${fightPropAlias(fightProp)}';
        }
        if (fightProp.name.contains('_SUB_HURT')) {
          return '减${fightPropAlias(fightProp)}';
        }
        if (fightProp.name.contains('_ADD_HURT')) {
          return '加${fightPropAlias(fightProp)}';
        }
        if (fightProp.name.contains('PERCENT')) {
          return '％${fightPropAlias(fightProp)}';
        }
        return fightPropAlias(fightProp);
    }
  }

  static String fightPropAlias(FightProp fightProp) {
    if (fightProp.name.contains('PLUNGING_ATTACK')) {
      return '落';
    }
    if (fightProp.name.contains('ELEMENTAL_SKILL')) {
      return 'E';
    }
    if (fightProp.name.contains('ELEMENTAL_BURST')) {
      return 'Q';
    }

    return fightProp.label()[0];
  }

  const FightPropView({
    Key? key,
    required this.fightProp,
    required this.value,
    this.highlight,
    this.calcValue,
  }) : super(key: key);

  final FightProp fightProp;
  final double value;
  final double? Function(FightProp fp, double value)? calcValue;
  final bool? highlight;

  @override
  Widget build(BuildContext context) {
    final formatValue = format(value, fightProp.format());

    return DefaultTextStyle.merge(
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: highlight?.ifTrueOrNull(() => FontWeight.bold),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -5,
              child: Text(fightProp.label(), style: TextStyle(fontSize: 6)),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 1,
                    bottom: -12,
                    child: Text(
                      formatValue.contains('%') ? '%' : '',
                      style: const TextStyle(
                        fontSize: 6,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 2,
                    top: 0,
                    child: Text(
                      calcValue
                              ?.let((calc) => calc(fightProp, value))
                              ?.let((v) => '${v.toInt()}') ??
                          '',
                      style: const TextStyle(
                        fontSize: 6,
                        fontWeight: FontWeight.normal,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    height: 1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                formatValue.replaceAll('%', ''),
                style: const TextStyle(
                  fontSize: 11,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
