import '../models/post_model.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {
  final List<PostModel> posts;

  BlogLoading({required this.posts});
}

class BlogLoaded extends BlogState {
  final List<PostModel> posts;
  final bool hasNextPage;

  BlogLoaded({
    required this.posts,
    required this.hasNextPage,
  });
}

class BlogError extends BlogState {
  final String error;

  BlogError({required this.error});
}
