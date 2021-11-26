import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';
import 'characters.dart';

var file = new File('assets/genshindb/characters.json');

void main() {
  test('debug', () async {
    var ret = CharactersContainer.fromJson(jsonDecode(await file.readAsString()));

    print(jsonEncode(ret));
  });
}
