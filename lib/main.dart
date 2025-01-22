import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/blog_bloc.dart';
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
        body: BlocProvider(
          create: (context) => BlogBloc(),
          child: const BlogScreen(),
        ),
      ),
    );
  }
}
