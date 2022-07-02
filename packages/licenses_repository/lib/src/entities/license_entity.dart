// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LicenseEntity extends Equatable {
  final String id;
  final String uid;
  final String type;
  final String lclass;
  final int period;
  final String department;
  final DateTime expiry;
  final String status;
  final DateTime timestamp;

  const LicenseEntity({
    required this.id,
    required this.uid,
    required this.type,
    required this.lclass,
    required this.period,
    required this.department,
    required this.expiry,
    required this.status,
    required this.timestamp,
  });

  Map<String, Object?> toJson() => {
        'id': id,
        'uid': uid,
        'type': type,
        'lclass': lclass,
        'period': period,
        'department': department,
        'expiry': expiry,
        'status': status,
        'timestamp': timestamp,
      };

  @override
  List<Object?> get props => [
        id,
        uid,
        type,
        lclass,
        period,
        department,
        expiry,
        status,
        timestamp,
      ];

  @override
  String toString() =>
      'LicenseEntity { id: $id,uid: $uid, type: $type, lclass: $lclass, period: $period, department: $department, expiry: $expiry, status: $status,timestamp: $timestamp }';

  static LicenseEntity fromJson(Map<String, Object> json) => LicenseEntity(
        id: json['id'] as String,
        uid: json['uid'] as String,
        type: json['type'] as String,
        lclass: json['lclass'] as String,
        period: json['period'] as int,
        department: json['department'] as String,
        expiry: (json['expiry'] as Timestamp).toDate(),
        status: json['status'] as String,
        timestamp: (json['timestamp'] as Timestamp).toDate(),
      );

  static LicenseEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return LicenseEntity(
      id: data['id'],
      uid: data['uid'],
      type: data['type'],
      lclass: data['lclass'],
      period: data['period'],
      department: data['department'],
      expiry: (data['expiry'] as Timestamp).toDate(),
      status: data['status'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toDocument() => {
        'id': id,
        'uid': uid,
        'type': type,
        'lclass': lclass,
        'period': period,
        'department': department,
        'expiry': expiry,
        'status': status,
        'timestamp': timestamp,
      };
}
