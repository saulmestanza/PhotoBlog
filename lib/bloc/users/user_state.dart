import 'package:photo_blog/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {
  final List<UserModel> users;

  UserLoading({
    required this.users,
  });
}

class UserLoaded extends UserState {
  final List<UserModel> users;
  final bool hasNextPage;

  UserLoaded({
    required this.users,
    required this.hasNextPage,
  });
}

class UserError extends UserState {
  final String error;

  UserError({required this.error});
}
