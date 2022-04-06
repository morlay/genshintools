import 'package:flutter/widgets.dart';

void safePop(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
