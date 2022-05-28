import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genshingameinfo/genshingameinfo.dart';
import 'package:genshintoolsapp/common/flutter.dart';

part '__generated__/auth_state.freezed.dart';
part '__generated__/auth_state.g.dart';

@freezed
class AuthStateV1 with _$AuthStateV1 {
  AuthStateV1._();

  factory AuthStateV1({
    required String encodedCookie,
    @Default([]) List<GameRole> gameRoles,
  }) = _AuthStateV1;

  factory AuthStateV1.fromJson(Map<String, dynamic> json) =>
      _AuthStateV1.fromJson(json);

  AuthState convertToNew() {
    var roles =
        gameRoles.asMap().map((key, value) => MapEntry(value.gameUid, value));

    return AuthState(
      currentUID: gameRoles[0].gameUid,
      channel: 'stable',
      roles: roles,
      cookies: roles.map((uid, value) => MapEntry(uid, encodedCookie)),
    );
  }
}

@freezed
class AuthState with _$AuthState {
  AuthState._();

  factory AuthState({
    required String currentUID,
    @Default({}) Map<String, String> cookies,
    @Default({}) Map<String, GameRole> roles,
    String? channel,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _AuthState.fromJson(json);

  MiHoYoBBSClient authedClient() {
    if (currentUID == '') {
      throw 'need login';
    }
    return client(currentEncodedCookie);
  }

  MiHoYoBBSClient client(String cookie) {
    return MiHoYoBBSClient(
      dio: Dio(),
      encodedCookie: cookie,
      useProxy: kIsWeb,
    );
  }

  bool hasLogon() => currentUID != '';

  int chosenUid() {
    return int.parse(currentUID == '' ? '0' : currentUID);
  }

  String get currentEncodedCookie => cookies[currentUID]!;

  String get currentChannel => channel ?? 'stable';

  GameRole get currentGameRole => roles[currentUID]!;

  AuthState mergeFrom(List<GameRole> gameRoles, String encodedCookie) {
    var nextRoles =
        gameRoles.asMap().map((key, value) => MapEntry(value.gameUid, value));

    var nextCookies =
        nextRoles.map((uid, value) => MapEntry(uid, encodedCookie));

    return copyWith(
      currentUID: gameRoles[0].gameUid,
      roles: {
        ...roles,
        ...nextRoles,
      },
      cookies: {
        ...cookies,
        ...nextCookies,
      },
    );
  }

  AuthState remove(String uidToRemove) {
    var nextRoles = roles..removeWhere((uid, value) => uid == uidToRemove);
    var nextCookies = cookies..removeWhere((key, value) => key == uidToRemove);

    return copyWith(
      currentUID: uidToRemove == currentUID
          ? (roles.keys.isNotEmpty ? roles.keys.first : '')
          : currentUID,
      roles: nextRoles,
      cookies: nextCookies,
    );
  }
}
