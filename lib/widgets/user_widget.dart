import 'package:flutter/material.dart';
import 'package:photo_blog/models/user_model.dart';

class UserWidget extends StatelessWidget {
  final UserModel user;
  const UserWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Text(user.name);
  }
}
