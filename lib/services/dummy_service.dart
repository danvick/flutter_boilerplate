

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../models/models.dart';
import '../utils/http_client.dart';

class DummyService {
  // Send uncached http request
  static Future<List<Post>> getPosts() async {
    var response = await HttpClient.instance.dio
        .get('https://jsonplaceholder.typicode.com/posts');
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }

  // This method implements HTTP caching with caching
  static Future<List<Post>> getPostsWithCaching({ignoreCache = false}) async {
    var response = await HttpClient.instance.dio.get(
      'https://jsonplaceholder.typicode.com/posts',
      options: HttpClient.instance.cacheOptions.copyWith(policy: CachePolicy.request).toOptions(),
    );
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }
}
