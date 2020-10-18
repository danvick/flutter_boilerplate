import 'package:dio_http_cache/dio_http_cache.dart';

import '../models/models.dart';
import '../utils/http_client.dart';

class DummyService {
  // Send uncached http request
  static Future<List<Post>> getPosts() async {
    var response = await HttpClient.instance.dio
        .get('https://jsonplaceholder.typicode.com/posts');
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }

  // This method implements HTTP caching with dio_http_cache package
  static Future<List<Post>> getPostsWithCaching({ignoreCache = false}) async {
    var response = await HttpClient.instance.dio.get(
      'https://jsonplaceholder.typicode.com/posts',
      options: buildCacheOptions(
        Duration(days: 7), // Ignore cached data if more than 7 days old
        forceRefresh: ignoreCache, //Ignore local cache if this value is true
      ),
    );
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }
}
