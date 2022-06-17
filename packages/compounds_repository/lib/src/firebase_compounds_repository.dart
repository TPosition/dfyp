// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:compounds_repository/compounds_repository.dart';
import 'entities/entities.dart';

class FirebaseCompoundsRepository implements CompoundsRepository {
  final compoundCollection =
      fs.FirebaseFirestore.instance.collection('compounds');

  @override
  Future<void> addNewCompound(Compound compound) {
    return compoundCollection
        .doc(compound.id)
        .set((compound.toEntity().toDocument()));
  }

  @override
  Future<void> deleteCompound(Compound compound) async {
    return compoundCollection.doc(compound.id).delete();
  }

  @override
  Stream<List<Compound>> compounds() {
    return compoundCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Compound.fromEntity(CompoundEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateCompound(Compound compound) {
    return compoundCollection
        .doc(compound.id)
        .update(compound.toEntity().toDocument());
  }
}
