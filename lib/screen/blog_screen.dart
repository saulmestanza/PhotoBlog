import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_blog/widgets/post_widget.dart';
import '../../../bloc/blog_bloc.dart';
import '../../../bloc/blog_event.dart';
import '../../../bloc/blog_state.dart';
import '../models/post_model.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
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
      context.read<BlogBloc>().add(LoadPosts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Placeholder'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _postList(),
                  const Center(
                    child: Text(''),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _postList() {
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
