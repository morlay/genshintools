import 'package:cached_network_image/cached_network_image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/genshindb.dart';
import 'package:genshintoolsapp/common/flutter.dart';

part '__generated__/image.freezed.dart';

@freezed
class GSImage extends HookWidget with _$GSImage {
  GSImage._();

  factory GSImage({
    required String domain,
    required String icon,
    @Default(1) final int rarity,
    @Default(56) final int size,
    @Default(0) final int borderSize,
    @Default(false) final bool rounded,
  }) = _GSImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: rounded
            ? BorderRadius.circular(size / 2)
            : BorderRadius.circular(4),
        color: Theme.of(context).dialogBackgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(borderSize.toDouble()),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: rounded
                ? BorderRadius.circular(size / 2)
                : BorderRadius.circular(4),
          ),
          clipBehavior: Clip.hardEdge,
          child: Container(
            decoration: BoxDecoration(
              gradient: linearGradientForRarity(rarity),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image(
              width: (size - borderSize).toDouble(),
              height: (size - borderSize).toDouble(),
              image: GSImageProvider(
                domain: domain,
                icon: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<List<Color>> bgs = [
  [const Color(0xff9da8b2), const Color(0xff4f5864)],
  [const Color(0xff60b881), const Color(0xff48575c)],
  [const Color(0xff3c94f6), const Color(0xff515474)],
  [const Color(0xffb87fcc), const Color(0xff595482)],
  [const Color(0xfff3b456), const Color(0xff695453)],
];

LinearGradient linearGradientForRarity(int rarity) {
  if (rarity == 0) {
    rarity = 1;
  }
  return LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: bgs[rarity - 1],
  );
}

class WithElement extends HookWidget {
  final ElementType element;
  final double size;
  final Widget child;

  const WithElement({
    Key? key,
    required this.element,
    required this.child,
    this.size = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          left: size / 8,
          top: size / 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size / 2),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image(
              width: size,
              height: size,
              image: AssetImage(
                  "assets/images/element/${element.toString().split(".").last}.png"),
            ),
          ),
        ),
      ],
    );
  }
}

class WithLevel extends HookWidget {
  final int level;
  final double size;
  final Widget child;

  const WithLevel({
    Key? key,
    required this.level,
    required this.child,
    this.size = 11,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return level < 0
        ? child
        : Stack(
            children: [
              child,
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(80),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: size,
                      minWidth: size,
                    ),
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Lv.',
                              style: TextStyle(
                                fontSize: 0.8 * size,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).backgroundColor,
                                fontFeatures: const [
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            ),
                            TextSpan(
                              text: '$level',
                              style: TextStyle(
                                fontSize: size,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).backgroundColor,
                                fontFeatures: const [
                                  FontFeature.tabularFigures()
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
  }
}

class WithCount extends HookWidget {
  final int count;
  final double size;
  final Widget child;
  final String prefix;
  final String suffix;
  final Alignment alignment;
  final bool active;

  const WithCount({
    Key? key,
    required this.count,
    required this.child,
    this.alignment = Alignment.topRight,
    this.size = 8,
    this.prefix = '',
    this.suffix = '',
    this.active = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return count < 0
        ? child
        : Stack(
            children: [
              child,
              Positioned(
                right: (alignment == Alignment.topRight ||
                        alignment == Alignment.bottomRight)
                    .ifTrueOrNull(() => 0),
                top: (alignment == Alignment.topRight ||
                        alignment == Alignment.topLeft)
                    .ifTrueOrNull(() => 0),
                left: (alignment == Alignment.topLeft ||
                        alignment == Alignment.bottomLeft)
                    .ifTrueOrNull(() => 0),
                bottom: (alignment == Alignment.bottomRight ||
                        alignment == Alignment.bottomLeft)
                    .ifTrueOrNull(() => 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: active
                        ? Colors.deepOrangeAccent.withOpacity(0.7)
                        : Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip.hardEdge,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  child: Center(
                    child: Text(
                      "$prefix${count > 1e4 ? "${(count / 1e4).toStringAsFixed(0)}w" : count}$suffix",
                      style: TextStyle(
                        fontSize: size,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).backgroundColor,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
  }
}

class GSImageProvider extends CachedNetworkImageProvider {
  static fromMiHoYo(String group, String icon) {
    return "https://upload-bbs.mihoyo.com/game_record/genshin/${group}/${icon}.png";
  }

  static fromAmbr(String group, String icon, {String prefix = ""}) {
    return "https://api.ambr.top/assets/UI/${prefix}${icon}.png";
  }

  static String image(String domain, String icon) {
    switch (domain) {
      case "weapon":
      case "artifact":
        return fromMiHoYo("equip", icon);
      // case "character":
      //   return mihoyoIcon("character_icon", icon);
      // case "constellation":
      //   return mihoyoIcon("constellation_icon", icon);
    }

    return fromAmbr(
      domain,
      icon,
      prefix: domain == "artifact" ? "reliquary/" : "",
    );
  }

  GSImageProvider({
    required String domain,
    required String icon,
  }) : super(GSImageProvider.image(domain, icon));
}

class GSImageConstellation extends HookWidget {
  final double size;
  final Color color;
  final String icon;

  const GSImageConstellation({
    required this.icon,
    this.size = 24,
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: color.withOpacity(0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Image(
          color: color,
          colorBlendMode: BlendMode.srcIn,
          image: GSImageProvider(
            domain: 'constellation',
            icon: icon,
          ),
        ),
      ),
    );
  }
}

class GSImageElement extends HookWidget {
  final ElementType element;
  final double size;

  const GSImageElement({
    required this.element,
    this.size = 24,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image(
        image: AssetImage(
            "assets/images/element/${element.toString().split('.').last}.png"),
      ),
    );
  }
}

class GSImageWeaponType extends HookWidget {
  final WeaponType weaponType;
  final double size;
  final Color color;

  const GSImageWeaponType({
    required this.weaponType,
    this.size = 24,
    this.color = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: size + 4,
      height: size + 4,
      color: color,
      colorBlendMode: BlendMode.srcIn,
      image: AssetImage(
          "assets/images/weapon_type/${weaponType.toString().split('.').last}.png"),
    );
  }
}

Map<ElementType, Color> _elementColors = {
  ElementType.Physical: Colors.blueGrey,
  ElementType.Pyro: Colors.red,
  ElementType.Electro: Colors.purple,
  ElementType.Hydro: Colors.blue,
  ElementType.Cryo: Colors.lightBlue,
  ElementType.Anemo: Colors.greenAccent,
  ElementType.Geo: Colors.orange,
  ElementType.Dendro: Colors.green,
};

Color elementColor(ElementType element) {
  return _elementColors[element] ?? Colors.blueGrey;
}
