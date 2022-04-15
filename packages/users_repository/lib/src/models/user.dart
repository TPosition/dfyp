import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class User extends Equatable {
  const User({
    required final this.uid,
    required final this.balance,
    required final this.displayName,
    required final this.email,
    required final this.mobile,
    required final this.photoURL,
  });

  final String uid;
  final double balance;
  final String displayName;
  final String email;
  final String mobile;
  final String photoURL;

  User copyWith({
    final double? balance,
    final String? displayName,
    final String? email,
    final String? mobile,
    final String? photoURL,
  }) =>
      User(
        uid: uid,
        balance: balance ?? this.balance,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        photoURL: photoURL ?? this.photoURL,
      );

  @override
  String toString() =>
      'User{uid: $uid,balance: $balance,displayName: $displayName,email: $email,mobile: $mobile,photoURL: $photoURL}';

  UserEntity toEntity() => UserEntity(
        uid: uid,
        balance: balance,
        displayName: displayName,
        email: email,
        mobile: mobile,
        photoURL: photoURL,
      );

  static User fromEntity(final UserEntity entity) => User(
      uid: entity.uid,
      balance: entity.balance,
      displayName: entity.displayName,
      email: entity.email,
      mobile: entity.mobile,
      photoURL: entity.photoURL);

  static User empty() => const User(
      uid: "",
      balance: 0,
      displayName: "",
      email: "",
      mobile: "",
      photoURL: "");

  @override
  List<Object?> get props => [
        uid,
        balance,
        displayName,
        email,
        mobile,
        photoURL,
      ];
}
