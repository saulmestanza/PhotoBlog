import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:photo_blog/repository/post_repository.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late PostRepository postRepository;
  late MockClient mockClient;

  setUp(() {
    registerFallbackValue(FakeUri());
    mockClient = MockClient();
    postRepository = PostRepository(client: mockClient);
  });

  group('PostRepository', () {
    test('fetchPosts returns a list of posts when the response is successful',
        () async {
      final mockResponse = json.encode([
        {
          "userId": 1,
          "id": 1,
          "title":
              "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
          "body":
              "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
        },
        {
          "userId": 1,
          "id": 2,
          "title": "qui est esse",
          "body":
              "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
        },
      ]);

      when(() => mockClient.get(any())).thenAnswer(((_) async {
        return Response(mockResponse, 200);
      }));

      final posts = await postRepository.fetchPosts(1);

      expect(posts.length, 2);
      expect(posts.first.id, 1);
      expect(posts.last.id, 2);
      expect(posts.last.title, 'qui est esse');
    });
  });
}
