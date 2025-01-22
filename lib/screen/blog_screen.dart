import 'package:flutter/material.dart';
import 'package:photo_blog/screen/post_screen.dart';
import 'package:photo_blog/screen/user_screen.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Posts'),
                Tab(text: 'Users'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PostScreen(),
                  UserScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
