part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UsersEvent {}

class AddUser extends UsersEvent {
  final User user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AddUser { user: $user }';
}

class UpdateUser extends UsersEvent {
  final User updatedUser;

  const UpdateUser(this.updatedUser);

  @override
  List<Object> get props => [updatedUser];

  @override
  String toString() => 'UpdateUser { updatedUser: $updatedUser }';
}

class UsersUpdated extends UsersEvent {
  final List<User> users;

  const UsersUpdated(this.users);

  @override
  List<Object> get props => [users];
}

// class DeleteUser extends UsersEvent {
//   final User user;

//   const DeleteUser(this.user);

//   @override
//   List<Object> get props => [user];

//   @override
//   String toString() => 'DeleteUser { user: $user }';
// }
