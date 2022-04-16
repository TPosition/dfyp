import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository _usersRepository;

  UsersBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(UsersLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<AddUser>(_onAddUser);
    on<UsersUpdated>(_onUsersUpdated);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UsersState> emit) {
    return emit.onEach<List<User>>(
      _usersRepository.users(),
      onData: (users) => add(UsersUpdated(users)),
    );
  }

  void _onAddUser(AddUser event, Emitter<UsersState> emit) {
    _usersRepository.addNewUser(event.user);
  }

  void _onUsersUpdated(UsersUpdated event, Emitter<UsersState> emit) {
    emit(UsersLoaded(event.users));
  }

  void _onUpdateUser(UpdateUser event, Emitter<UsersState> emit) {
    _usersRepository.updateUser(event.updatedUser);
  }
}
