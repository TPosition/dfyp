part of 'current_user_bloc.dart';

enum CurrentUserStatus { unauthenticated, incompleted, completed }

class CurrentUserState extends Equatable {
  const CurrentUserState._({
    required final this.status,
    final this.user = const User(
      uid: "",
      balance: 0,
      displayName: "",
      email: "",
      mobile: "",
      photoURL: "",
    ),
  });

  const CurrentUserState.unauthenticated()
      : this._(status: CurrentUserStatus.unauthenticated);

  const CurrentUserState.incompleted(final User user)
      : this._(status: CurrentUserStatus.incompleted, user: user);

  const CurrentUserState.completed(final User user)
      : this._(status: CurrentUserStatus.completed, user: user);

  final CurrentUserStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
