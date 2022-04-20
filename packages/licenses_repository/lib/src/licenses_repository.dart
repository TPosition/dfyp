// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:licenses_repository/licenses_repository.dart';

abstract class LicensesRepository {
  Future<void> addNewLicense(final License license);

  Future<void> deleteLicense(final License license);

  Stream<List<License>> licenses();

  Future<void> updateLicense(final License license);
}
