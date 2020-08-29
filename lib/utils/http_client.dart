import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';

// FIXME: Use a legit dependency injector instead of a Singleton
class HttpClient {
  static final CacheConfig cacheConfig = CacheConfig();
  static final HttpClient _singleton = HttpClient._();

  static HttpClient get instance => _singleton;
  Dio _dio;

  HttpClient._();

  Dio get dio {
    if (_dio == null) {
      _dio = Dio();

      dio.interceptors
        ..add(AuthInterceptor())
        ..add(ErrorInterceptor())
        ..add(DioCacheManager(cacheConfig).interceptor);

      if (kDebugMode) {
        dio.interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            // responseBody: true,
          ),
        );
      }
    }
    return _dio;
  }
}
