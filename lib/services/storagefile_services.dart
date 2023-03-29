import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../methods.dart';

abstract class StorageService {
  Future<String> uploadAFileToStorage(XFile file, Reference storageRef);
}

class FirebaseStorageService extends GetxService implements StorageService {
  @override
  Future<String> uploadAFileToStorage(XFile xfile, storageRef) async {

    File file = await Methods.compressFile(xfile.path);
    UploadTask uploadTask = storageRef.putFile(
        File(file.path), SettableMetadata(contentType: 'image/png'));

    final downloadUrl = await (await uploadTask).ref.getDownloadURL();
    return downloadUrl;
  }
}