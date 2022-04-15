// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:transactions_repository/transactions_repository.dart';
import 'entities/entities.dart';

class FirebaseTransactionsRepository implements TransactionsRepository {
  final transactionCollection =
      fs.FirebaseFirestore.instance.collection('transactions');

  @override
  Future<void> addNewTransaction(Transaction transaction) {
    return transactionCollection
        .doc(transaction.id)
        .set((transaction.toEntity().toDocument()));
  }

  @override
  Future<void> deleteTransaction(Transaction transaction) async {
    return transactionCollection.doc(transaction.id).delete();
  }

  @override
  Stream<List<Transaction>> transactions() {
    return transactionCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Transaction.fromEntity(TransactionEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateTransaction(Transaction transaction) {
    return transactionCollection
        .doc(transaction.id)
        .update(transaction.toEntity().toDocument());
  }
}
