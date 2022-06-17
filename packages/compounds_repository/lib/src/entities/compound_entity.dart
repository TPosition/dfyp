// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CompoundEntity extends Equatable {
  final String id;
  final double amount;
  final String reason;
  final String agency;
  final DateTime timestamp;

  const CompoundEntity(
      {required this.id,
      required this.amount,
      this.agency = "",
      this.reason = "",
      required this.timestamp});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'amount': amount,
      'reason': reason,
      'agency': agency,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [id, amount, agency, reason, timestamp];

  @override
  String toString() {
    return 'CompoundEntity { id: $id,amount: $amount,agency: $agency,reason: $reason,timestamp: $timestamp }';
  }

  static CompoundEntity fromJson(Map<String, Object> json) {
    return CompoundEntity(
      id: json['id'] as String,
      amount: json['amount'] as double,
      agency: json['agency'] as String,
      reason: json['reason'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  static CompoundEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return CompoundEntity(
      id: data['id'],
      amount: data['amount'],
      agency: data['agency'],
      reason: data['reason'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'amount': amount,
      'reason': reason,
      'agency': agency,
      'timestamp': timestamp,
    };
  }
}
