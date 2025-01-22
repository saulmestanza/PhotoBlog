import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_blog/widgets/post_widget.dart';
import '../bloc/blogs/blog_bloc.dart';
import '../bloc/blogs/blog_event.dart';
import '../bloc/blogs/blog_state.dart';
import '../models/post_model.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<BlogBloc>().add(LoadPosts());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final blogBloc = context.read<BlogBloc>();

      if (blogBloc.state is! BlogLoading) {
        blogBloc.add(LoadPosts());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<PostModel> posts = [];
    var hasNextPage = false;

    return BlocBuilder<BlogBloc, BlogState>(
      builder: (context, state) {
        if (state is BlogInitial ||
            (state is BlogLoading && state.posts.isEmpty)) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BlogError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is BlogLoaded) {
          posts = state.posts;
          hasNextPage = state.hasNextPage;
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: posts.length + (hasNextPage ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == posts.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final post = posts[index];
            return PostWidget(
              post: post,
            );
          },
        );
      },
    );
  }
}
