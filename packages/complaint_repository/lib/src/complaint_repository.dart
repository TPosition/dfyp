// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:complaints_repository/complaint_repository.dart';

abstract class ComplaintsRepository {
  Future<void> addNewComplaint(Complaint Complaint);

  Future<void> deleteComplaint(Complaint Complaint);

  Stream<List<Complaint>> complaints();

  Future<void> updateComplaint(Complaint Complaint);
}
