import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_interceptors/auth_interceptor.dart';
import 'http_interceptors/error_interceptor.dart';
import 'http_interceptors/user_agent_interceptor.dart';

class HttpClient with DioMixin implements Dio {
  HttpClient({BaseOptions? baseOptions}) {
    options = (baseOptions ?? BaseOptions()).copyWith(
      validateStatus: (int? status) {
        return status != null && status >= 200 && status < 400;
      },
    );
    httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: const Duration(seconds: 10),
        onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
      ),
    );
    interceptors.addAll([
      ErrorInterceptor(),
      AuthInterceptor(),
      UserAgentInterceptor(),
      DioFirebasePerformanceInterceptor(),
      /*CookieManager(PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage("${GetIt.I<Directory>().path}/.cookies/"),
      )),*/
    ]);

    if (kDebugMode) {
      interceptors.add(
        PrettyDioLogger(
          responseHeader: true,
          responseBody: false,
          request: false,
        ),
      );
    }
    // _dio.addSentry();
  }

  static CacheOptions defaultCacheOptions = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),
    // Optional. Returns a cached response on error but for statuses 401 & 403.
    // hitCacheOnErrorExcept: [401, 403, 500],
    // Optional. Overrides HTTPs directive to delete entry past this duration.
    maxStale: const Duration(hours: 1),
  );
}
