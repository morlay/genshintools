import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/extension/extension.dart';
import 'package:genshintools/genshindb/utils.dart';

import 'fight_props.dart';
import 'material.dart';

part '__generated__/promote.freezed.dart';
part '__generated__/promote.g.dart';

@freezed
class GSPromoteSet with _$GSPromoteSet {
  GSPromoteSet._();

  factory GSPromoteSet(
    Map<int, List<GSPromote>> promotes,
  ) = _PromoteSet;

  factory GSPromoteSet.fromJson(Map<String, dynamic> json) =>
      _PromoteSet.fromJson({"promotes": json});

  FightProps promotedFightProps(int promoteId, int currentLevel) {
    return promotes[promoteId]?.let((it) {
          var promoteList = it.reversed;
          var currentPromoteLevel = promoteList.length;

          for (var p in promoteList) {
            if (currentLevel > p.unlockMaxLevel) {
              break;
            }
            currentPromoteLevel--;
          }

          return it
              .elementAt(
                  rangeLimit(currentPromoteLevel, 0, promoteList.length - 1))
              .addProps;
        }) ??
        FightProps({});
  }

  List<GSMaterialCost> promoteCosts(
    int promoteId,
    int currentLevel,
    int to,
  ) {
    return promotes[promoteId]?.let((list) {
          var promoteList = list.reversed;
          var currentPromoteLevel = promoteList.length;

          for (var p in promoteList) {
            if (currentLevel > p.unlockMaxLevel) {
              break;
            }
            currentPromoteLevel--;
          }

          if (currentPromoteLevel >= (promoteList.length - 1)) {
            return [];
          }

          return list.elementAt(currentPromoteLevel + 1).allMaterialCosts();
        }) ??
        [];
  }
}

@freezed
class GSPromote with _$GSPromote {
  GSPromote._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSPromote({
    required int unlockMaxLevel,
    required List<GSMaterialCost> materialCosts,
    required FightProps addProps,
  }) = _Promote;

  factory GSPromote.fromJson(Map<String, dynamic> json) =>
      _Promote.fromJson(json);

  List<GSMaterialCost> allMaterialCosts() {
    return [...materialCosts];
  }
}
