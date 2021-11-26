import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Auth {
  String uid;
  String encodedCookie;

  Auth({
    required this.uid,
    required this.encodedCookie,
  });

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);

  Map<String, dynamic> toJson() => _$AuthToJson(this);
}

class AuthCubit extends HydratedCubit<Auth> {
  AuthCubit() : super(Auth(uid: "", encodedCookie: ""));

  bool hasLogon() => state.uid != "";

  void login(Auth auth) => emit(auth);

  void logout() => emit(Auth(uid: "", encodedCookie: ""));

  @override
  Auth? fromJson(Map<String, dynamic> json) {
    return Auth.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Auth state) {
    return state.toJson();
  }
}
