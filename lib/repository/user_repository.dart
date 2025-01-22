import 'package:http/http.dart' as http;
import 'package:photo_blog/models/user_model.dart';

class UserRepository {
  final http.Client client;

  UserRepository({
    required this.client,
  });

  Future<List<UserModel>> fetchUsers() async {
    final url = Uri.parse(
      'https://jsonplaceholder.typicode.com/users',
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
