import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';
import 'http_interceptors/user_agent_interceptor.dart';

// Consider using a legit dependency injector instead of a Singleton
class HttpClient {
  // static final CacheConfig cacheConfig = CacheConfig();
  static final HttpClient _singleton = HttpClient._();

  static String get serverUrl => dotenv.env['SERVER_URL']!;

  static HttpClient get instance => _singleton;
  Dio? _dio;

  HttpClient._();

  // Global options
  final cacheOptions = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),
    // Default.
    policy: CachePolicy.noCache,
    // Optional. Returns a cached response on error but for statuses 401 & 403.
    hitCacheOnErrorExcept: [401, 403],
    // Optional. Overrides any HTTP directive to delete entry past this duration.
    maxStale: const Duration(days: 1),
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

  Dio get dio {
    if (_dio == null) {
      _dio = Dio();

      dio.interceptors.addAll([
        ErrorInterceptor(),
        //FIXME-danvick: make caching optional depending on
        DioCacheInterceptor(options: cacheOptions),
        AuthInterceptor(),
        UserAgentInterceptor(),
        DioFirebasePerformanceInterceptor(),
      ]);

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
    return _dio!;
  }
}
