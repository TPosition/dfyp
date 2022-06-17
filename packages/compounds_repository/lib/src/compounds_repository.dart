// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:compounds_repository/compounds_repository.dart';

abstract class CompoundsRepository {
  Future<void> addNewCompound(Compound Compound);

  Future<void> deleteCompound(Compound Compound);

  Stream<List<Compound>> compounds();

  Future<void> updateCompound(Compound Compound);
}
