import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_blog/bloc/users/user_event.dart';
import 'package:photo_blog/models/user_model.dart';
import 'package:photo_blog/widgets/post_widget.dart';
import 'package:photo_blog/widgets/user_widget.dart';
import '../bloc/blogs/blog_bloc.dart';
import '../bloc/blogs/blog_event.dart';
import '../bloc/blogs/blog_state.dart';
import '../bloc/users/user_bloc.dart';
import '../bloc/users/user_state.dart';
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
    context.read<UserBloc>().add(LoadUsers());
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Users'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _postList(),
                  _usersList(),
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

  _usersList() {
    List<UserModel> users = [];
    var hasNextPage = false;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial ||
            (state is UserLoading && state.users.isEmpty)) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is UserLoaded) {
          users = state.users;
          hasNextPage = state.hasNextPage;
        }

        return ListView.builder(
          controller: _scrollController,
          itemCount: users.length + (hasNextPage ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == users.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = users[index];
            return UserWidget(
              user: user,
            );
          },
        );
      },
    );
  }
}
