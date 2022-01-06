import 'dart:developer';

import 'package:genshintools/genshindb/utils.dart';
import 'package:test/test.dart';

void main() {
  test('exec', () {
    log(parseParamName("{param1:F2P}/{param1:F2P}", [0.11]));
  });
}
