import 'package:flutterreststarter/models/models.dart';
import 'package:flutterreststarter/utils/http_client.dart';

class DummyService {
  static Future<List<Post>> getPosts() async {
    var response = await HttpClient.instance.dio
        .get('https://jsonplaceholder.typicode.com/posts');
    return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  }
}
