import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';

import '../models/models.dart';
import '../utils/http_client.dart';

class DummyService {
  // Send un-cached http request
  static Future<List<Post>> getPosts() async {
    var response = await GetIt.I<HttpClient>().dio.get('/posts');
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }

  // This method implements an HTTP request with caching
  static Future<List<Post>> getPostsWithCaching({ignoreCache = false}) async {
    final cacheOptions = HttpClient.defaultCacheOptions.copyWith(
      maxStale: const Nullable(Duration(days: 30)),
    );
    var response = await (GetIt.I<HttpClient>().dio
      ..interceptors.add(DioCacheInterceptor(options: cacheOptions))
    )
        .get('/posts');
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }
}
