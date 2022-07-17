// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CompoundEntity extends Equatable {
  final String id;
  final String uid;
  final num amount;
  final String reason;
  final String agency;
  final String plate;
  final DateTime timestamp;
  final bool isPaid;

  const CompoundEntity({
    required this.id,
    required this.uid,
    required this.amount,
    required this.agency,
    required this.reason,
    required this.plate,
    required this.timestamp,
    required this.isPaid,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'uid': uid,
      'amount': amount,
      'reason': reason,
      'agency': agency,
      'plate': plate,
      'timestamp': timestamp,
      'isPaid': isPaid,
    };
  }

  @override
  List<Object?> get props =>
      [id, uid, amount, agency, reason, plate, timestamp, isPaid];

  @override
  String toString() {
    return 'CompoundEntity { id: $id,uid:$uid, amount: $amount,agency: $agency,reason: $reason, plate: $plate,timestamp: $timestamp , isPaid,$isPaid,}';
  }

  static CompoundEntity fromJson(Map<String, Object> json) {
    return CompoundEntity(
      id: json['id'] as String,
      uid: json['uid'] as String,
      amount: json['amount'] as num,
      agency: json['agency'] as String,
      reason: json['reason'] as String,
      plate: json['plate'] as String,
      isPaid: json['isPaid'] as bool,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  static CompoundEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return CompoundEntity(
      id: data['id'],
      uid: data['uid'],
      amount: data['amount'],
      agency: data['agency'],
      plate: data['plate'],
      reason: data['reason'],
      isPaid: data['isPaid'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'uid': uid,
      'amount': amount,
      'reason': reason,
      'agency': agency,
      'plate': plate,
      'timestamp': timestamp,
      'isPaid': isPaid,
    };
  }
}
