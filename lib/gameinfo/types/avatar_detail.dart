import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/avatar_detail.freezed.dart';
part 'generated/avatar_detail.g.dart';

@freezed
class AvatarDetail with _$AvatarDetail {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory AvatarDetail({
    required AvatarDetailWeapon weapon,
    required List<AvatarDetailSkill> skillList,
    required List<AvatarDetailReliquary> reliquaryList,
  }) = _AvatarDetail;

  factory AvatarDetail.fromJson(Map<String, dynamic> json) =>
      _AvatarDetail.fromJson(json);
}

@freezed
class AvatarDetailSkill with _$AvatarDetailSkill {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory AvatarDetailSkill({
    required int id,
    required int groupId,
    required String name,
    required String icon,
    required int maxLevel,
    required int levelCurrent,
  }) = _AvatarDetailSkill;

  factory AvatarDetailSkill.fromJson(Map<String, dynamic> json) =>
      _AvatarDetailSkill.fromJson(json);
}

@freezed
class AvatarDetailWeapon with _$AvatarDetailWeapon {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory AvatarDetailWeapon({
    required int id,
    required int weaponCatId,
    required String name,
    required String icon,
    required int weaponLevel,
    required int levelCurrent,
    required int maxLevel,
  }) = _AvatarDetailWeapon;

  factory AvatarDetailWeapon.fromJson(Map<String, dynamic> json) =>
      _AvatarDetailWeapon.fromJson(json);
}

@freezed
class AvatarDetailReliquary with _$AvatarDetailReliquary {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory AvatarDetailReliquary({
    required int id,
    required int reliquaryCatId,
    required String name,
    required String icon,
    required int reliquaryLevel,
    required int levelCurrent,
    required int maxLevel,
  }) = _AvatarDetailReliquary;

  factory AvatarDetailReliquary.fromJson(Map<String, dynamic> json) =>
      _AvatarDetailReliquary.fromJson(json);
}
