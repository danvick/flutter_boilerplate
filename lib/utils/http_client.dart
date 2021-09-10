import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';
import 'http_interceptors/user_agent_interceptor.dart';


class HttpClient {
  static String get serverUrl => dotenv.env['SERVER_URL']!;

  static CacheOptions defaultCacheOptions = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),
    // Default.
    policy: CachePolicy.request,
    // Optional. Returns a cached response on error but for statuses 401 & 403.
    // hitCacheOnErrorExcept: [401, 403, 500],
    // Optional. Overrides any HTTP directive to delete entry past this duration.
    maxStale: const Duration(hours: 1),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended.
    allowPostMethod: false,
  );

  static Dio create({BaseOptions? options, CacheOptions? cacheOptions}) {
    var dio = Dio(options);

    dio.interceptors.addAll([
      ErrorInterceptor(),
      if (cacheOptions != null) DioCacheInterceptor(options: cacheOptions),
      AuthInterceptor(),
      UserAgentInterceptor(),
      DioFirebasePerformanceInterceptor(),
    ]);

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: false,
        responseHeader: true,
        responseBody: false,
        request: false,
        requestBody: false,
      ));
    }

    return dio;
  }
}
