import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blogs/blog_bloc.dart';
import 'bloc/users/user_bloc.dart';
import 'screen/blog_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(5.0),
            child: Align(
              child: Text('Lorem Ipsum'),
            ),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider<BlogBloc>(
              create: (BuildContext context) => BlogBloc(),
            ),
            BlocProvider<UserBloc>(
              create: (BuildContext context) => UserBloc(),
            ),
          ],
          child: const BlogScreen(),
        ),
      ),
    );
  }
}
