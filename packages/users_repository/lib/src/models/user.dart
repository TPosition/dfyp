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
    required final this.address,
  });

  final String uid;
  final double balance;
  final String displayName;
  final String email;
  final String mobile;
  final String photoURL;
  final String address;

  User copyWith({
    final double? balance,
    final String? displayName,
    final String? email,
    final String? mobile,
    final String? photoURL,
    final String? address,
  }) =>
      User(
        uid: uid,
        balance: balance ?? this.balance,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
        photoURL: photoURL ?? this.photoURL,
        address: address ?? this.address,
      );

  @override
  String toString() =>
      'User{uid: $uid,balance: $balance,displayName: $displayName,email: $email,mobile: $mobile,photoURL: $photoURL,address: $address}';

  UserEntity toEntity() => UserEntity(
        uid: uid,
        balance: balance,
        displayName: displayName,
        email: email,
        mobile: mobile,
        photoURL: photoURL,
        address: address,
      );

  static User fromEntity(final UserEntity entity) => User(
        uid: entity.uid,
        balance: entity.balance,
        displayName: entity.displayName,
        email: entity.email,
        mobile: entity.mobile,
        photoURL: entity.photoURL,
        address: entity.address,
      );

  static User empty() => const User(
        uid: "",
        balance: 0,
        displayName: "",
        email: "",
        mobile: "",
        photoURL: "",
        address: "",
      );

  @override
  List<Object?> get props => [
        uid,
        balance,
        displayName,
        email,
        mobile,
        photoURL,
        address,
      ];
}
