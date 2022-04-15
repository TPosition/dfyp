// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import '../users_repository.dart';
import 'entities/entities.dart';

class FirebaseUsersRepository implements UsersRepository {
  final fs.CollectionReference userCollection =
      fs.FirebaseFirestore.instance.collection('user');

  @override
  Future<void> addNewUser(final User user) =>
      userCollection.doc(user.uid).set(user.toEntity().toDocument());

  @override
  Future<void> deleteUser(final User user) async =>
      userCollection.doc(user.uid).delete();

  @override
  Stream<List<User>> users() => userCollection.snapshots().map(
        (final snapshot) => snapshot.docs
            .map((final doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
            .toList(),
      );

  @override
  Future<void> updateUser(final User user) =>
      userCollection.doc(user.uid).update(user.toEntity().toDocument());

  @override
  Stream<User> currentUser(final String uid) =>
      userCollection.doc(uid).snapshots().map((final doc) {
        if (doc.exists) {
          return User.fromEntity(UserEntity.fromSnapshot(doc));
        }
        return const User(
          uid: "",
          balance: 0,
          displayName: "",
          email: "",
          mobile: "",
          photoURL: "",
        );
      });
}
