// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:storage_repository/storage_repository.dart';

abstract class StorageRepository {
  Future<void> addImage(Storage Storage);

  Future<String> getImageURL(Storage Storage);

  // Future<void> deleteImage(Transaction Transaction);

}
