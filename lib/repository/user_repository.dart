import 'package:http/http.dart' as http;
import 'package:photo_blog/models/user_model.dart';

class UserRepository {
  final http.Client client;
  final int pageSize;

  UserRepository({
    required this.client,
    this.pageSize = 10,
  });

  Future<List<UserModel>> fetchUsers(int page) async {
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/users?_page=$page&_limit=$pageSize',
    );

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final users = userModelFromMap(response.body);
      return users;
    } else {
      throw Exception(response.body);
    }
  }
}
