import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  CurrentUserBloc({
    required final UsersRepository usersRepository,
    required final String uid,
  })  : _usersRepository = usersRepository,
        _uid = uid,
        super(const CurrentUserState.unauthenticated()) {
    on<CurrentUserChanged>(_onUserChanged);
    if (uid.isEmpty) {
      add(CurrentUserChanged(CurrentUserStatus.unauthenticated, User.empty()));
      return;
    }
    _currentUserSubscription =
        _usersRepository.currentUser(_uid).listen((final User currentUser) {
      if (currentUser.uid.isEmpty) {
        _usersRepository.addNewUser(
          User(
            uid: _uid,
            balance: 0,
            displayName: "",
            email: "",
            mobile: "",
            photoURL: "",
          ),
        );
        add(CurrentUserChanged(CurrentUserStatus.incompleted, currentUser));
      }

      if (currentUser.displayName.isEmpty ||
          currentUser.mobile.isEmpty ||
          currentUser.email.isEmpty ||
          currentUser.photoURL.isEmpty) {
        add(CurrentUserChanged(CurrentUserStatus.incompleted, currentUser));
      } else {
        add(CurrentUserChanged(CurrentUserStatus.completed, currentUser));
      }
    });
  }

  final UsersRepository _usersRepository;
  final String _uid;
  late final StreamSubscription<User> _currentUserSubscription;

  void _onUserChanged(
    final CurrentUserChanged event,
    final Emitter<CurrentUserState> emit,
  ) {
    switch (event.currentUserStatus) {
      case CurrentUserStatus.unauthenticated:
        return emit(const CurrentUserState.unauthenticated());
      case CurrentUserStatus.incompleted:
        return emit(CurrentUserState.incompleted(event.currentUser));
      case CurrentUserStatus.completed:
        return emit(CurrentUserState.completed(event.currentUser));
    }
  }

  @override
  Future<void> close() {
    _currentUserSubscription.cancel();
    return super.close();
  }
}
