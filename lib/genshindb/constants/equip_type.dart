import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/annotations.dart';

part 'generated/equip_type.g.dart';

class EquipTypeStringConverter extends _$EquipTypeStringConverter {
  const EquipTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum EquipType {
  @EnumMeta(label: "花")
  @JsonValue("EQUIP_BRACER")
  FLOWER,

  @EnumMeta(label: "羽")
  @JsonValue("EQUIP_NECKLACE")
  FEATHER,

  @EnumMeta(label: "沙")
  @JsonValue("EQUIP_SHOES")
  SANDS,

  @EnumMeta(label: "杯")
  @JsonValue("EQUIP_RING")
  GOBLET,

  @EnumMeta(label: "头")
  @JsonValue("EQUIP_DRESS")
  CIRCLET,
}
