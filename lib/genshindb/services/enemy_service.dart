import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/types.dart';

part 'generated/enemy_service.freezed.dart';
part 'generated/enemy_service.g.dart';

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

  GSEnemy? find(String idOrName) {
    if (_indexes.isEmpty) {
      enemies?.forEach((key, value) {
        value.name.keys.forEach((lang) {
          _indexes[value.name.text(lang)] = value.id;
        });
      });
    }

    var m = enemies?[_indexes[idOrName]];

    if (m != null) {
      return m;
    }
  }

  final Map<String, List<String>> _dropTags = {};

  Iterable<GSEnemy> listByDropTags(List<String> dropTags) {
    if (_dropTags.isEmpty) {
      enemies?.forEach((key, value) {
        _dropTags[value.dropTag] = [...?_dropTags[value.dropTag], value.nameID];
      });
    }

    var ids = dropTags.map((dropTag) => _dropTags[dropTag]!).expand((e) => e);

    return [
      ...{...ids}
    ].map((id) => find(id)!);
  }

  List<GSEnemy> toList() => enemies?.values.toList() ?? [];
}
