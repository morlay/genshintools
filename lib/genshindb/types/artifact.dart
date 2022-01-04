import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/constants.dart';

import 'equip_affix.dart';
import 'i18n.dart';

part 'generated/artifact.freezed.dart';
part 'generated/artifact.g.dart';

@freezed
class GSArtifact with _$GSArtifact {
  GSArtifact._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSArtifact({
    required int id,
    required I18n name,
    required I18n desc,
    required int rarity,
    @EquipTypeStringConverter() required EquipType equipType,
    required int setId,
    required int appendPropDepotId,
    required int mainPropDepotId,
    int? maxLevel,
    int? appendPropNum,
  }) = _Artifact;

  factory GSArtifact.fromJson(Map<String, dynamic> json) =>
      _Artifact.fromJson(json);

  get key => name.text(Lang.ID);
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

  String get key => name.text(Lang.ID);
}

@freezed
class GSArtifactAppendDepot with _$GSArtifactAppendDepot {
  GSArtifactAppendDepot._();

  @FightPropStringConverter()
  factory GSArtifactAppendDepot(
    Map<FightProp, List<double>> values,
  ) = _GSArtifactAppendDepot;

  factory GSArtifactAppendDepot.fromJson(Map<String, dynamic> json) =>
      _GSArtifactAppendDepot.fromJson({"values": json});

  List<double> get(FightProp fp) {
    return values[fp] ?? [];
  }

  Iterable<FightProp> get keys => values.keys;

  double calc(FightProp fp, List<int>? indexes) {
    var values = get(fp);
    return sum((indexes ?? []).map((i) => values[i]));
  }

  final Map<FightProp, Map<String, List<int>>> _fpCanValues = {};

  static String format(double t, [percent = false]) {
    if (t < 1) {
      // to fix
      // 0.05249999836087227 should be .053
      t = (t + 1e-5);
      if (percent) {
        return (t * 1e2).toStringAsFixed(1) + "%";
      }
      return t.toStringAsFixed(3).substring(1);
    }
    return t.toStringAsFixed(0);
  }

  List<int> valueIndexes(FightProp fp, String? s) {
    if (s == null) {
      return [];
    }

    var values = canValues(fp);

    if (s.contains("?")) {
      return values[s] ?? [];
    }

    for (int c = 1; c <= 6; c++) {
      var k = "$s?$c";
      if (values[k] != null) {
        return values[k]!;
      }
    }

    return [];
  }

  double valueFor(FightProp fp, String? s) {
    return calc(fp, valueIndexes(fp, s));
  }

  String valueFix(FightProp fp, String? s) {
    var indexes = valueIndexes(fp, s);
    return "${format(calc(fp, indexes))}?${indexes.length}";
  }

  Map<String, List<int>> canValues(FightProp fp) {
    if (_fpCanValues[fp] != null) {
      return _fpCanValues[fp] ?? {};
    }

    Map<String, List<int>> set = {};

    var values = get(fp);

    for (var n = 1; n <= 6; n++) {
      combination(values, n).forEach((indexes) {
        var t = sum(indexes.map((i) => values[i]));
        set["${format(t)}?${indexes.length}"] = indexes;
      });
    }

    var sortedKeys = set.keys..sorted((a, b) => a.compareTo(b));

    _fpCanValues[fp] = sortedKeys.fold<Map<String, List<int>>>(
        {}, (previousValue, v) => {...previousValue, v: set[v]!});

    return _fpCanValues[fp]!;
  }
}

double sum(Iterable<double> values) {
  double v = 0;
  for (var d in values) {
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
          i,
        ]);
      }
    }
  }

  combine(inputArr, []);

  return results;
}
