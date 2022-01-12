import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:version/version.dart';

part 'generated/release.freezed.dart';
part 'generated/release.g.dart';

@freezed
class Release with _$Release {
  Release._();

  @JsonSerializable()
  factory Release({
    required String packageName,
    required String version,
    required String buildNumber,
    required String downloadURL,
    String? description,
  }) = _Release;

  factory Release.fromJson(Map<String, dynamic> json) =>
      _Release.fromJson(json);

  bool shouldUpgrade(String currentVersion, String currentBuildNumber) {
    Version v = Version.parse(version);
    Version cv = Version.parse(currentVersion);
    if (v > cv) {
      return true;
    }
    try {
      return int.parse(buildNumber) > int.parse(currentBuildNumber);
    } catch (e) {
      return true;
    }
  }
}
