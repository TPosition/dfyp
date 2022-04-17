// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:storage_repository/storage_repository.dart';

abstract class StorageRepository {
  Future<void> addImage(String path);

  Future<String> getImageURL(String path);

  // Future<void> deleteImage(Transaction Transaction);

}
