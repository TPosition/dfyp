// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:complaints_repository/complaint_repository.dart';
import 'entities/entities.dart';

class FirebaseComplaintsRepository implements ComplaintsRepository {
  final complaintCollection =
      fs.FirebaseFirestore.instance.collection('complaints');

  @override
  Future<void> addNewComplaint(Complaint complaint) {
    return complaintCollection
        .doc(complaint.id)
        .set((complaint.toEntity().toDocument()));
  }

  @override
  Future<void> deleteComplaint(Complaint complaint) async {
    return complaintCollection.doc(complaint.id).delete();
  }

  @override
  Stream<List<Complaint>> complaints() {
    return complaintCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Complaint.fromEntity(ComplaintEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateComplaint(Complaint complaint) {
    return complaintCollection
        .doc(complaint.id)
        .update(complaint.toEntity().toDocument());
  }
}
