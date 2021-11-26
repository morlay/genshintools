import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_info.freezed.dart';
part 'generated/user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    List<Avatar>? avatars,
    List<Home>? homes,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _UserInfo.fromJson(json);
}

@freezed
class Avatar with _$Avatar {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Avatar({
    required int id,
    required int level,
    required String name,
    required int rarity,
    required int fetter,
    required int activedConstellationNum,
    required String element,
    Weapon? weapon,
    List<Reliquary>? reliquaries,
  }) = _Avatar;

  factory Avatar.fromJson(Map<String, dynamic> json) => _Avatar.fromJson(json);
}

@freezed
class Reliquary with _$Reliquary {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Reliquary({
    required int id,
    required int level,
    required String name,
    required int rarity,
    required int pos,
  }) = _Reliquary;

  factory Reliquary.fromJson(Map<String, dynamic> json) =>
      _Reliquary.fromJson(json);
}

@freezed
class Weapon with _$Weapon {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Weapon({
    required int id,
    required int level,
    required String name,
    required int rarity,
    required int affixLevel,
  }) = _Weapon;

  factory Weapon.fromJson(Map<String, dynamic> json) => _Weapon.fromJson(json);
}

@freezed
class Home with _$Home {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Home({
    required int level,
    required int visitNum,
    required int comfortNum,
    required int itemNum,
    required String name,
  }) = _Home;

  factory Home.fromJson(Map<String, dynamic> json) => _Home.fromJson(json);
}
