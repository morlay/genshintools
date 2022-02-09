import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshintools/genshindb/genshindb.dart';

part 'generated/enemy.freezed.dart';
part 'generated/enemy.g.dart';

@freezed
class GSEnemy with _$GSEnemy {
  GSEnemy._();

  @JsonSerializable(fieldRename: FieldRename.pascal)
  factory GSEnemy({
    required int id,
    required I18n name,
    required String dropTag,
    required String type,
    required GSMonsterRarity monsterRarity,
    I18n? title,
    I18n? specialName,
    FightProps? addProps,
  }) = _Enemy;

  factory GSEnemy.fromJson(Map<String, dynamic> json) => _Enemy.fromJson(json);

  String get key => name.text(Lang.KEY);
}
