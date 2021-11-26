import 'dart:convert';

import 'package:genshintools/genshindb/genshindb.dart';
import 'package:test/test.dart';

void main() {
  test('I18N', () {
    var i18n = I18n.fromJson({
      "EN": "en",
      "ID": "id",
    });

    print(jsonEncode(i18n));

    print(ElementType.Anemo.label());

    expect(i18n.text(Lang.EN), equals("en"));
    expect(i18n.text(Lang.ID), equals("id"));
  });

  test("Material", () {
    var m = GSMaterial(
      id: 1,
      name: I18n({}),
      desc: I18n({}),
      rarity: 5,
      rank: 10,
      materialType: GSMaterialType.AVATAR,
    );

    print(m.copyWith(count: 10));
  });
}
