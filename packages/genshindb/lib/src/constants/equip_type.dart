import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/annotations.dart';

part '__generated__/equip_type.g.dart';

class EquipTypeStringConverter extends _$EquipTypeStringConverter {
  const EquipTypeStringConverter() : super();
}

@JsonEnum(alwaysCreate: true)
enum EquipType {
  @EnumMeta(label: '花')
  @JsonValue('EQUIP_BRACER')
  BRACER,

  @EnumMeta(label: '羽')
  @JsonValue('EQUIP_NECKLACE')
  NECKLACE,

  @EnumMeta(label: '沙')
  @JsonValue('EQUIP_SHOES')
  SHOES,

  @EnumMeta(label: '杯')
  @JsonValue('EQUIP_RING')
  RING,

  @EnumMeta(label: '头')
  @JsonValue('EQUIP_DRESS')
  DRESS,
}
