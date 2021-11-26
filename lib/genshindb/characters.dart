import 'package:genshintools/genshindb/i18n.dart';
import 'package:json_annotation/json_annotation.dart';

part 'characters.g.dart';

class CharactersContainer {
  final Map<String, Character> _m;

  CharactersContainer(this._m);

  factory CharactersContainer.fromJson(Map<String, dynamic> json) =>
      CharactersContainer(
        (json).map(
          (k, e) => MapEntry(k, Character.fromJson(e as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toJson() => _m.map(
        (k, e) => MapEntry(k, e.toJson()),
      );

  List<Character> toList() {
    return _m.values.toList();
  }
}

@JsonSerializable(fieldRename: FieldRename.pascal)
class Character {
  final int id;
  final I18N name;
  final I18N desc;

  Character({
    required this.id,
    required this.name,
    required this.desc,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
