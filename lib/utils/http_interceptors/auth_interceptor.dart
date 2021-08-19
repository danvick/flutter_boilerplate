import 'dart:io';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //TODO: Put the paths you want the interceptor to ignore
    if (!options.path.contains('/login')) {
      //TODO: Fetch your token from local storage (or wherever) and plug it in
      var token = '<YOUR-TOKEN-HERE>';
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer $token';
    }
    handler.next(options);
  }
}
