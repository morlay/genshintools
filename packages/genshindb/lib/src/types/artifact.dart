import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/constants.dart';

import 'equip_affix.dart';
import 'fight_props.dart';
import 'i18n.dart';
import 'package:collection/collection.dart';

part '__generated__/artifact.freezed.dart';
part '__generated__/artifact.g.dart';

@freezed
class GSArtifact with _$GSArtifact {
  GSArtifact._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSArtifact({
    required int id,
    required I18n name,
    required I18n desc,
    required String icon,
    required int rarity,
    @EquipTypeStringConverter() required EquipType equipType,
    required String setKey,
    required int appendPropDepotId,
    required int mainPropDepotId,
    int? maxLevel,
    int? appendPropNum,
  }) = _Artifact;

  factory GSArtifact.fromJson(Map<String, dynamic> json) =>
      _Artifact.fromJson(json);

  String get key => name.text(Lang.KEY);
}

@freezed
class GSArtifactSet with _$GSArtifactSet {
  GSArtifactSet._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSArtifactSet({
    required int id,
    required I18n name,
    required List<EquipAffix> equipAffixes,
    int? activeNum,
    Map<EquipType, GSArtifact>? artifacts,
  }) = _ArtifactSet;

  factory GSArtifactSet.fromJson(Map<String, dynamic> json) =>
      _ArtifactSet.fromJson(json);

  GSArtifact artifact(EquipType equipType) {
    return artifacts![equipType]!;
  }

  String get key => name.text(Lang.KEY);
}

@freezed
class GSArtifactAppendDepot with _$GSArtifactAppendDepot {
  GSArtifactAppendDepot._();

  @FightPropStringConverter()
  factory GSArtifactAppendDepot(
    Map<FightProp, List<double>> values,
  ) = _GSArtifactAppendDepot;

  factory GSArtifactAppendDepot.fromJson(Map<String, dynamic> json) =>
      _GSArtifactAppendDepot.fromJson({'values': json});

  List<double> get(FightProp fp) {
    return values[fp] ?? [];
  }

  Iterable<FightProp> get keys => values.keys;

  double calc(FightProp fp, List<int>? ns) {
    var values = get(fp);
    return sum((ns ?? []).map((i) => values[abs(i) - 1]));
  }

  static String format(
    double t, {
    bool percent = false,
    String percentSymbol = '%',
  }) {
    if (t < 1) {
      // to fix
      // 0.05249999836087227 should be .053
      t = t + 1e-5;
      if (percent) {
        return (t * 1e2).toStringAsFixed(1) + percentSymbol;
      }
      return t.toStringAsFixed(3).substring(1);
    }
    return t.toStringAsFixed(0);
  }

  double rank(
    FightProp fp,
    List<int> indexes,
    FightProps fightProps,
    String? location,
  ) {
    return sum(
      indexes.map((i) {
        double base = 1;

        double calcBase(double v, double p, bool isPercent) {
          if (isPercent) {
            if (p < v) {
              return p / v;
            }
          } else {
            if (v < p) {
              return v / p;
            }
          }
          return 1;
        }

        switch (fp) {
          case FightProp.ATTACK:
          case FightProp.ATTACK_PERCENT:
            var v = calc(FightProp.ATTACK, [i]);
            var p = calc(FightProp.ATTACK_PERCENT, [i]) *
                fightProps.get(FightProp.BASE_ATTACK);
            base = calcBase(v, p, fp == FightProp.ATTACK_PERCENT);

            if (location == 'HuTao') {
              base = base * 0.4;
            }

            break;
          case FightProp.DEFENSE:
          case FightProp.DEFENSE_PERCENT:
            var v = calc(FightProp.DEFENSE, [i]);
            var p = calc(FightProp.DEFENSE_PERCENT, [i]) *
                fightProps.get(FightProp.BASE_DEFENSE);

            base = calcBase(v, p, fp == FightProp.DEFENSE_PERCENT);
            break;
          case FightProp.HP:
          case FightProp.HP_PERCENT:
            var v = calc(FightProp.HP, [i]);
            var p = calc(FightProp.HP_PERCENT, [i]) *
                fightProps.get(FightProp.BASE_HP);
            base = calcBase(v, p, fp == FightProp.HP_PERCENT);
            break;
          default:
        }

        // 平均值
        return (calc(fp, [i]) / (avgValue(fp))) * base;
      }),
    ).toDouble();
  }

  List<int> valueNs(FightProp fp, String? s) {
    if (s == null) {
      return [];
    }

    var values = canValues(fp);

    if (s.contains('?')) {
      return values[s] ?? [];
    }

    for (int c = 1; c <= 6; c++) {
      var k = '$s?$c';
      if (values[k] != null) {
        return values[k]!;
      }
    }

    return [];
  }

  double valueFor(FightProp fp, String? s) {
    var ns = valueNs(fp, s);
    if (ns.isNotEmpty) {
      return calc(fp, valueNs(fp, s));
    }
    try {
      return double.parse(s ?? '');
    } catch (e) {
      return 0;
    }
  }

  String valueFix(FightProp fp, String? s) {
    var indexes = valueNs(fp, s);
    return '${format(calc(fp, indexes))}?${indexes.length}';
  }

  Map<String, List<int>> canValues(FightProp fp) {
    var fpKey = '$hashCode/$fp';

    if (_fpCanValues[fpKey] != null) {
      return _fpCanValues[fpKey] ?? {};
    }

    Map<String, List<int>> set = {};

    var canValues = get(fp);

    for (var n = 1; n <= 6; n++) {
      combination(canValues, n).forEach((ns) {
        if (fp == FightProp.HP ||
            fp == FightProp.ATTACK ||
            fp == FightProp.DEFENSE) {
          ns = ns.map((i) => -i).toList();
        }

        var t = sum(ns.map((i) => canValues[abs(i) - 1]));
        set['${format(t)}?${ns.length}'] = ns;
      });
    }

    var sortedKeys = set.keys..sorted((a, b) => a.compareTo(b));

    _fpCanValues[fpKey] = sortedKeys.fold<Map<String, List<int>>>(
      {},
      (previousValue, v) => {...previousValue, v: set[v]!},
    );

    return _fpCanValues[fpKey]!;
  }

  int abs(int i) {
    return i < 0 ? -i : i;
  }

  double avgValue(FightProp fp) {
    return calc(fp, [1, 2, 3, 4]) / 4;
  }
}

final Map<String, Map<String, List<int>>> _fpCanValues = {};

double sum(Iterable<double> values) {
  double v = 0;
  for (final d in values) {
    v = v + d;
  }
  return v;
}

List<List<int>> combination<T>(List<T> inputArr, int n) {
  List<List<int>> results = [];

  void combine(List<T> arr, List<int> m) {
    if (m.length == n) {
      results.add(m);
    } else {
      for (var i = 0; i < arr.length; i++) {
        combine(arr, [
          ...m,
          i + 1,
        ]);
      }
    }
  }

  combine(inputArr, []);

  return results;
}
