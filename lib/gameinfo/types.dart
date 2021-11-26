import 'package:json_annotation/json_annotation.dart';

part 'types.g.dart';

@JsonSerializable()
class UserInfo {
  List<Avatar>? avatars;
  List<Home>? homes;

  UserInfo();

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Avatar {
  int? id;
  int? level;
  String? name;
  int? rarity;

  int? fetter;

  @JsonKey(name: "actived_constellation_num")
  int? activeConstellationNum;

  String? element;

  Weapon? weapon;
  List<Reliquary>? reliquaries;

  Avatar();

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}

@JsonSerializable()
class Reliquary {
  int? id;
  int? level;
  String? name;
  int? rarity;

  Reliquary();

  factory Reliquary.fromJson(Map<String, dynamic> json) =>
      _$ReliquaryFromJson(json);

  Map<String, dynamic> toJson() => _$ReliquaryToJson(this);
}

@JsonSerializable()
class Weapon {
  int? id;
  int? level;
  String? name;
  int? rarity;

  @JsonKey(name: "affix_level")
  int? affixLevel;

  Weapon();

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);

  Map<String, dynamic> toJson() => _$WeaponToJson(this);
}

@JsonSerializable()
class Home {
  int? id;
  int? level;
  @JsonKey(name: "comfort_num")
  int? comfortNum;
  @JsonKey(name: "visit_num")
  int? visitNum;

  String? name;
  String? type;

  Home();

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}
