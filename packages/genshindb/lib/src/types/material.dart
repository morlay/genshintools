import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';
import 'package:genshindb/extension.dart';

import 'i18n.dart';

part '__generated__/material.freezed.dart';
part '__generated__/material.g.dart';

const resetTime = Duration(hours: 5);

@freezed
class GSMaterial with _$GSMaterial {
  GSMaterial._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSMaterial({
    required int id,
    required I18n name,
    required I18n desc,
    @GSMaterialTypeStringConverter() required GSMaterialType materialType,
    required int rarity,
    required int rank,
    List<I18n>? sources,
    List<String>? dropFromTags,
    GSMonsterRarity? dropFromRarity,
    List<int>? openWeekdays,
    int? count,
  }) = _GSMaterial;

  factory GSMaterial.fromJson(Map<String, dynamic> json) =>
      _GSMaterial.fromJson(json);

  String get key => name.text(Lang.KEY);

  String get dropBy =>
      dropFromTags?.let((dropFromTags) =>
          dropFromTags.isNotEmpty ? dropFromTags.join() : key,) ??
      key;

  bool isTodayOpen() {
    return openWeekdays
            ?.map((d) => d == 0 ? 7 : d)
            .contains(DateTime.now().subtract(resetTime).weekday) ??
        true;
  }

  bool isTomorrowOpen() {
    return openWeekdays?.map((d) => d == 0 ? 7 : d).contains(
              DateTime.now()
                  .subtract(resetTime)
                  .add(const Duration(days: 1))
                  .weekday,
            ) ??
        true;
  }
}

@freezed
class GSMaterialCost with _$GSMaterialCost {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSMaterialCost({
    required String materialKey,
    required int count,
  }) = _MaterialCost;

  factory GSMaterialCost.fromJson(Map<String, dynamic> json) =>
      _MaterialCost.fromJson(json);
}
