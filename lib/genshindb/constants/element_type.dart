import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/annotations.dart';

part '__generated__/element_type.g.dart';

class ElementTypeStringConverter extends _$ElementTypeStringConverter {
  const ElementTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum ElementType {
  @EnumMeta(label: "火")
  Pyro,

  @EnumMeta(label: "冰")
  Cryo,

  @EnumMeta(label: "雷")
  Electro,

  @EnumMeta(label: "水")
  Hydro,

  @EnumMeta(label: "风")
  Anemo,

  @EnumMeta(label: "岩")
  Geo,

  @EnumMeta(label: "草")
  Dendro,

  @EnumMeta(label: "物理")
  Physical,
}
