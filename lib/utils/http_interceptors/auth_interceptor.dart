import 'dart:io';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options) async {
    //TODO: Fetch your token from local storage and plug it in
    if (!options.path.contains("/login")) {
      var token = "some token";
      options.headers[HttpHeaders.authorizationHeader] = "Bearer ${token ?? ''}";
    }
    return options;
  }
}
