// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:users_repository/users_repository.dart';

abstract class UsersRepository {
  Future<void> addNewUser(final User user);

  Future<void> deleteUser(final User user);

  Stream<List<User>> users();

  Future<void> updateUser(final User user);

  Stream<User> currentUser(final String uid);
}
