import 'package:flutterreststarter/utils/http_client.dart';

class DummyService {
  static Future<List<dynamic>> getPosts() async {
    var response = await HttpClient.instance.dio
        .get('https://jsonplaceholder.typicode.com/posts');
    return response.data;
  }
}
