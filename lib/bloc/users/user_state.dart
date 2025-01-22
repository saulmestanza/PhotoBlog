import 'package:photo_blog/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoaded extends UserState {
  final List<UserModel> users;

  UserLoaded({
    required this.users,
  });
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}
