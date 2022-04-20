// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:licenses_repository/licenses_repository.dart';
import 'entities/entities.dart';

class FirebaseLicensesRepository implements LicensesRepository {
  final licenseCollection =
      fs.FirebaseFirestore.instance.collection('licenses');

  @override
  Future<void> addNewLicense(final License license) =>
      licenseCollection.doc(license.id).set(license.toEntity().toDocument());

  @override
  Future<void> deleteLicense(final License license) async =>
      licenseCollection.doc(license.id).delete();

  @override
  Stream<List<License>> licenses() =>
      licenseCollection.orderBy("timestamp", descending: true).snapshots().map(
            (final snapshot) => snapshot.docs
                .map(
                  (final doc) =>
                      License.fromEntity(LicenseEntity.fromSnapshot(doc)),
                )
                .toList(),
          );

  @override
  Future<void> updateLicense(final License license) =>
      licenseCollection.doc(license.id).update(license.toEntity().toDocument());
}
