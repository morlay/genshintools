import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/types.dart';

part '__generated__/material_service.freezed.dart';
part '__generated__/material_service.g.dart';

@freezed
class MaterialService with _$MaterialService {
  MaterialService._();

  final Map<String, int> _indexes = {};

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory MaterialService({
    Map<int, GSMaterial>? materials,
  }) = _MaterialService;

  GSMaterial find(String keyOrName) {
    var f = findOrNull(keyOrName);
    if (f == null) {
      throw 'Material not found `$keyOrName`';
    }
    return f;
  }

  GSMaterial? findOrNull(String keyOrName) {
    if (_indexes.isEmpty) {
      materials?.forEach((key, value) {
        for (final lang in value.name.keys) {
          _indexes[value.name.text(lang)] = value.id;
        }
      });
    }

    return materials?[_indexes[keyOrName]];
  }

  List<GSMaterial> toList() => materials?.values.toList() ?? [];

  factory MaterialService.fromJson(Map<String, dynamic> json) =>
      _$MaterialServiceFromJson(json);
}
