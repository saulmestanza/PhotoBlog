import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_blog/bloc/users/user_bloc.dart';
import 'package:photo_blog/bloc/users/user_event.dart';
import 'package:photo_blog/models/user_model.dart';
import 'package:photo_blog/widgets/user_widget.dart';
import '../bloc/users/user_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(LoadUsers());
  }

  @override
  Widget build(BuildContext context) {
    List<UserModel> users = [];

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is UserLoaded) {
          users = state.users;
        }

        return ListView.builder(
          itemCount: users.length,
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
