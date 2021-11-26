import 'dart:developer';

import 'package:genshintools/genshindb/utils.dart';
import 'package:test/test.dart';

void main() {
  test('exec', () {
    // print(exec("{param1:I}", [0.11]));
    // print(exec("{param1:F}", [0.11]));
    // print(exec("{param1:P}", [0.11]));
    // print(exec("{param1:F1P}", [0.11]));
    // print(exec("{param1:F2P}", [0.11]));
    log(parseParamName("{param1:F2P}/{param1:F2P}", [0.11]));
  });
}
