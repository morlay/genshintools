import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/genshindb.dart';

part 'generated/image.freezed.dart';

@freezed
class GSImage extends HookWidget with _$GSImage {
  GSImage._();

  factory GSImage({
    required String domain,
    required String nameID,
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
                nameID: nameID,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

var bgs = [
  [const Color(0xFF838f99), const Color(0xFF4f5864)],
  [const Color(0xFF5e966c), const Color(0xFF48575c)],
  [const Color(0xFF499fb3), const Color(0xFF515474)],
  [const Color(0xFFb886ca), const Color(0xFF595482)],
  [const Color(0xFFe6ac54), const Color(0xFF695453)],
];

LinearGradient linearGradientForRarity(int rarity) {
  if (rarity == 0) {
    rarity = 1;
  }
  return LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: bgs[rarity - 1],
    tileMode: TileMode.clamp,
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
                  image: GSImageProvider(
                    domain: "element",
                    nameID: element.name,
                  ),
                ))),
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
                              text: "Lv.",
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
                              text: "$level",
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

  const WithCount({
    Key? key,
    required this.count,
    required this.child,
    this.size = 14,
    this.prefix = "",
    this.suffix = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return count < 0
        ? child
        : Stack(
            children: [
              child,
              Positioned(
                right: size / 8,
                top: size / 8,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(80),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  clipBehavior: Clip.hardEdge,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Center(
                    child: Text(
                      "$prefix$count$suffix",
                      style: TextStyle(
                        fontSize: 0.6 * size,
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

class GSImageConstellation extends HookWidget {
  final String nameID;
  final double size;
  final Color color;

  const GSImageConstellation({
    required this.nameID,
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
            width: 1,
            color: color.withOpacity(0.5),
          )),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Image(
          color: color,
          colorBlendMode: BlendMode.srcIn,
          image: GSImageProvider(
            domain: 'constellation',
            nameID: nameID,
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
        image: GSImageProvider(
          domain: 'element',
          nameID: element.string(),
        ),
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
      image: GSImageProvider(
        domain: "weapon_type",
        nameID: weaponType.toString().split(".").last,
      ),
    );
  }
}

const imageBaseURL = "https://gitee.com/morlay/genshinimages/raw/good/images";

class GSImageProvider extends CachedNetworkImageProvider {
  GSImageProvider({
    required String domain,
    required String nameID,
  }) : super("$imageBaseURL/$domain/$nameID.png");
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
