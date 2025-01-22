import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/post_model.dart';
import '../../repository/post_repository.dart';
import 'package:http/http.dart' as http;

import 'blog_event.dart';
import 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  late PostRepository postRepository;
  int _page = 1;
  bool _hasNextPage = true;
  final List<PostModel> _posts = [];

  BlogBloc() : super(BlogInitial()) {
    postRepository = PostRepository(client: http.Client());
    on<LoadPosts>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<BlogState> emit) async {
    if (!_hasNextPage) return;

    try {
      if (state is! BlogLoading) {
        emit(BlogLoading(posts: _posts));
      }
      final newPosts = await postRepository.fetchPosts(_page);

      if (newPosts.isEmpty) {
        _hasNextPage = false;
      } else {
        _page++;
        _posts.addAll(newPosts);
      }

      emit(BlogLoaded(posts: _posts, hasNextPage: _hasNextPage));
    } catch (e) {
      emit(BlogError(error: e.toString()));
    }
  }
}
