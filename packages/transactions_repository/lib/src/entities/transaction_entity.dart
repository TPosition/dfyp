// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String category;
  final String receiverDisplayName;
  final String receiverUID;
  final String senderDisplayName;
  final String senderUID;
  final DateTime timestamp;

  const TransactionEntity(
      {required this.id,
      required this.amount,
      required this.category,
      required this.receiverDisplayName,
      required this.receiverUID,
      this.senderUID = "",
      this.senderDisplayName = "",
      required this.timestamp});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'receiverDisplayName': receiverDisplayName,
      'receiverUID': receiverUID,
      'senderDisplayName': senderDisplayName,
      'senderUID': senderUID,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [
        id,
        amount,
        category,
        receiverDisplayName,
        receiverUID,
        senderUID,
        senderDisplayName,
        timestamp
      ];

  @override
  String toString() {
    return 'TransactionEntity { id: $id,amount: $amount,category: $category,receiverDisplayName: $receiverDisplayName,receiverUID: $receiverUID,senderUID: $senderUID,senderDisplayName: $senderDisplayName,timestamp: $timestamp }';
  }

  static TransactionEntity fromJson(Map<String, Object> json) {
    return TransactionEntity(
      id: json['id'] as String,
      amount: json['amount'] as double,
      category: json['category'] as String,
      receiverDisplayName: json['receiverDisplayName'] as String,
      receiverUID: json['receiverUID'] as String,
      senderUID: json['senderUID'] as String,
      senderDisplayName: json['senderDisplayName'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  static TransactionEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return TransactionEntity(
      id: data['id'],
      amount: data['amount'],
      category: data['category'],
      receiverDisplayName: data['receiverDisplayName'],
      receiverUID: data['receiverUID'],
      senderUID: data['senderUID'],
      senderDisplayName: data['senderDisplayName'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'amount': amount,
      'category': category,
      'receiverDisplayName': receiverDisplayName,
      'receiverUID': receiverUID,
      'senderDisplayName': senderDisplayName,
      'senderUID': senderUID,
      'timestamp': timestamp,
    };
  }
}
