import 'package:genshintoolsapp/common/flutter.dart';

ThemeData base = ThemeData.from(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.brown,
    backgroundColor: Colors.white,
  ),
);

TextTheme textTheme = base.textTheme.apply(
  displayColor: Colors.grey.shade700,
  bodyColor: Colors.grey.shade600,
);

ThemeData theme = base.copyWith(
  focusColor: Colors.grey.shade200,
  unselectedWidgetColor: Colors.grey.shade500,
  iconTheme: base.iconTheme.copyWith(
    color: Colors.grey.shade500,
    opacity: 0.8,
  ),
  textTheme: textTheme.copyWith(
    bodyText2: textTheme.bodyText2?.copyWith(
      fontSize: 11,
    ),
    subtitle1: textTheme.subtitle1?.copyWith(
      fontSize: 14,
    ),
    subtitle2: textTheme.subtitle2?.copyWith(
      fontSize: 12,
    ),
  ),
  chipTheme: base.chipTheme.copyWith(
    backgroundColor: Colors.grey.shade200,
    labelStyle: textTheme.bodyText2?.let(
      (it) => it.copyWith(
        color: Colors.grey.shade800,
      ),
    ),
  ),
);
