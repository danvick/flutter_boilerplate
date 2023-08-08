import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';

import '../models/models.dart';
import '../utils/http_client.dart';

class DummyService {
  // Send un-cached http request
  static Future<List<Post>> getPosts() async {
    final response = await GetIt.I<HttpClient>().get<List<dynamic>>('/posts');
    return response.data!
        .map<Post>((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // This method implements an HTTP request with caching
  static Future<List<Post>> getPostsWithCaching({
    bool ignoreCache = false,
  }) async {
    final cacheOptions = HttpClient.defaultCacheOptions.copyWith(
      maxStale: const Nullable(Duration(days: 30)),
    );
    final response = await (GetIt.I<HttpClient>()
          ..interceptors.add(DioCacheInterceptor(options: cacheOptions)))
        .get<List<dynamic>>('/posts');
    return response.data!
        .map<Post>((e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
