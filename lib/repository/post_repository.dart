import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostRepository {
  final http.Client client;
  final int pageSize;

  PostRepository({
    required this.client,
    this.pageSize = 10,
  });

  Future<List<PostModel>> fetchPosts(int page) async {
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$pageSize',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final posts = blogFromMap(response.body);
      return posts;
    } else {
      throw Exception(response.body);
    }
  }
}
