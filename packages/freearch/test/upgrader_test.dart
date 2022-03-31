import 'package:freearch/freearch.dart';
import 'package:freearch/upgrader.dart';
import 'package:test/test.dart';

void main() {
  test("latest", () async {
    var u = Upgrader(Github("morlay/genshintools", "release-stable"));
    print(await u.latestRelease());
  });
}
