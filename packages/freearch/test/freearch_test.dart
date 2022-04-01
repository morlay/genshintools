import 'package:freearch/freearch.dart';
import 'package:test/test.dart';

void main() {
  test("latest", () {
    var g = Github("morlay/genshintools", "release-stable");

    print(g.rawURL("android/latest.json"));
    print(g.rawURL("android/latest.json", nocache: true));
  });

  test("image", () {
    var g = Github(
      "morlay/genshinimages",
      "882da7db6d7424e882bbe32c6ba18d58da200878",
    );

    print(g.rawURL("/images/element/Anemo.png"));
  });
}
