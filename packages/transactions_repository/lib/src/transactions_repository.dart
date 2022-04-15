// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:transactions_repository/transactions_repository.dart';

abstract class TransactionsRepository {
  Future<void> addNewTransaction(Transaction Transaction);

  Future<void> deleteTransaction(Transaction Transaction);

  Stream<List<Transaction>> transactions();

  Future<void> updateTransaction(Transaction Transaction);
}
