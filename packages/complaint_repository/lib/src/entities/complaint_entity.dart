// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ComplaintEntity extends Equatable {
  final String id;
  final String uid;
  final String title;
  final String comment;
  final DateTime timestamp;

  const ComplaintEntity(
      {required this.id,
      required this.uid,
      required this.title,
      required this.comment,
      required this.timestamp});

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'comment': comment,
      'timestamp': timestamp,
    };
  }

  @override
  List<Object?> get props => [id, uid, title, comment, timestamp];

  @override
  String toString() {
    return 'ComplaintEntity {id: $id,uid: $uid,title: $title,comment: $comment}';
  }

  static ComplaintEntity fromJson(Map<String, Object> json) {
    return ComplaintEntity(
      id: json['id'] as String,
      uid: json['uid'] as String,
      title: json['title'] as String,
      comment: json['comment'] as String,
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  static ComplaintEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return ComplaintEntity(
      id: data['id'],
      uid: data['uid'],
      title: data['title'],
      comment: data['comment'],
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'uid': uid,
      'title': title,
      'comment': comment,
      'timestamp': timestamp,
    };
  }
}
