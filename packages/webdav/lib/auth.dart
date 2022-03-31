import 'dart:convert';

import 'package:roundtripper/roundtripper.dart';

class HttpBaseAuth implements RoundTripBuilder {
  String username;
  String password;

  HttpBaseAuth({
    required this.username,
    required this.password,
  });

  @override
  RoundTrip build(RoundTrip next) {
    return (request) async {
      return await next(request.copyWith(
        headers: applyAuthHeader(request.headers ?? {}),
      ));
    };
  }

  Map<String, dynamic> applyAuthHeader(Map<String, dynamic> headers) {
    return {
      ...headers,
      "authorization":
          "Basic ${base64Encode(utf8.encode("$username:$password"))}"
    };
  }
}
