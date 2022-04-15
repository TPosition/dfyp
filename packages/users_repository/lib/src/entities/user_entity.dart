// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final double balance;
  final String displayName;
  final String email;
  final String mobile;
  final String photoURL;

  const UserEntity({
    required this.uid,
    required this.balance,
    required this.displayName,
    required this.email,
    required this.mobile,
    required this.photoURL,
  });

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'balance': balance,
      'displayName': displayName,
      'email': email,
      'mobile': mobile,
      'photoURL': photoURL
    };
  }

  @override
  List<Object?> get props => [
        uid,
        balance,
        displayName,
        email,
        mobile,
        photoURL,
      ];

  @override
  String toString() {
    return 'UserEntity {uid: $uid,balance: $balance,displayName: $displayName,email: $email,mobile: $mobile,photoURL: $photoURL}';
  }

  static UserEntity fromJson(Map<String, Object> json) {
    return UserEntity(
      uid: json['uid'] as String,
      balance: json['balance'] as double,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      photoURL: json['photoURL'] as String,
    );
  }

  static UserEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return UserEntity(
      uid: data['uid'],
      balance: data['balance'],
      displayName: data['displayName'],
      email: data['email'],
      mobile: data['mobile'],
      photoURL: data['photoURL'],
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'uid': uid,
      'balance': balance,
      'displayName': displayName,
      'email': email,
      'mobile': mobile,
      'photoURL': photoURL
    };
  }
}
