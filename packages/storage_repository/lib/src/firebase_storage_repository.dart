import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storage_repository/src/models/storage.dart';
import 'package:storage_repository/src/storage_repository.dart';

class FirebaseStorageRepository implements StorageRepository {
  Reference ref = FirebaseStorage.instance.ref();

  @override
  Future<void> addImage(final String path) async {
    final _picker = ImagePicker();
    var _image = await _picker.getImage(source: ImageSource.gallery);

    TaskSnapshot addImg = await ref.child(path).putFile(File(_image!.path));
    if (addImg.state == TaskState.success) {
      print("added to Firebase Storage");
    }
    return;
  }

  @override
  Future<String> getImageURL(final String path) async =>
      ref.child(path).getDownloadURL();
}
