import 'package:freezed_annotation/freezed_annotation.dart';

part '__generated__/prop_grow_curve.freezed.dart';
part '__generated__/prop_grow_curve.g.dart';

@freezed
class PropGrowCurveAndInitial with _$PropGrowCurveAndInitial {
  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory PropGrowCurveAndInitial({
    required String growCurve,
    required double initial,
  }) = _PropGrowCurveAndInitial;

  factory PropGrowCurveAndInitial.fromJson(Map<String, dynamic> json) =>
      _$PropGrowCurveAndInitialFromJson(json);
}

@freezed
class PropGrowCurveValueSet with _$PropGrowCurveValueSet {
  PropGrowCurveValueSet._();

  factory PropGrowCurveValueSet(
    Map<String, List<double>> values,
  ) = _PropGrowCurveValueSet;

  factory PropGrowCurveValueSet.fromJson(Map<String, dynamic> json) =>
      _$PropGrowCurveValueSetFromJson({"values": json});

  double multi(String growCurve, double initial, int level) {
    if (level < 1) {
      level = 1;
    }
    // arith_multi
    return initial * values[growCurve]![level - 1];
  }
}
