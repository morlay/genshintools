import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshindb/types.dart';

part '__generated__/enemy_service.freezed.dart';
part '__generated__/enemy_service.g.dart';

@freezed
class EnemyService with _$EnemyService {
  EnemyService._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory EnemyService({
    Map<int, GSEnemy>? enemies,
  }) = _EnemyService;

  factory EnemyService.fromJson(Map<String, dynamic> json) =>
      _EnemyService.fromJson(json);

  final Map<String, int> _indexes = {};

  GSEnemy find(String keyOrName) {
    return findOrNull(keyOrName)!;
  }

  GSEnemy? findOrNull(String keyOrName) {
    if (_indexes.isEmpty) {
      enemies?.forEach((key, value) {
        for (var lang in value.name.keys) {
          _indexes[value.name.text(lang)] = value.id;
        }
      });
    }

    var m = enemies?[_indexes[keyOrName]];

    return m;
  }

  final Map<String, List<String>> _dropTags = {};

  Iterable<GSEnemy> listByDropTags(List<String> dropTags) {
    if (_dropTags.isEmpty) {
      enemies?.forEach((key, value) {
        _dropTags[value.dropTag] = [...?_dropTags[value.dropTag], value.key];
      });
    }

    var ids = dropTags.map((dropTag) => _dropTags[dropTag]!).expand((e) => e);

    return [
      ...{...ids}
    ].map((id) => find(id));
  }

  List<GSEnemy> toList() => enemies?.values.toList() ?? [];
}
