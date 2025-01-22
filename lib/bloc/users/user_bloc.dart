import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_blog/models/user_model.dart';
import 'package:photo_blog/repository/user_repository.dart';
import 'package:http/http.dart' as http;

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  late UserRepository userRepository;
  int _page = 1;
  bool _hasNextPage = true;
  final List<UserModel> _users = [];

  UserBloc() : super(UserInitial()) {
    userRepository = UserRepository(client: http.Client());
    on<LoadUsers>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(LoadUsers event, Emitter<UserState> emit) async {
    if (!_hasNextPage) return;

    try {
      if (state is! UserLoading) {
        emit(UserLoading(users: _users));
      }
      final newUsers = await userRepository.fetchUsers(_page);

      if (newUsers.isEmpty) {
        _hasNextPage = false;
      } else {
        _page++;
        _users.addAll(newUsers);
      }

      emit(UserLoaded(users: _users, hasNextPage: _hasNextPage));
    } catch (e) {
      emit(UserError(error: e.toString()));
    }
  }
}
