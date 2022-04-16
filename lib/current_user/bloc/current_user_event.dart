part of 'current_user_bloc.dart';

abstract class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

// class CurrentUserLogoutRequested extends CurrentUserEvent {}

class CurrentUserChanged extends CurrentUserEvent {
  const CurrentUserChanged(this.currentUserStatus, this.currentUser);

  final CurrentUserStatus currentUserStatus;
  final User currentUser;

  @override
  List<Object> get props => [currentUserStatus, currentUser];
}
