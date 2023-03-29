import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;


class FirebasePaths {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  //collections
  static CollectionReference userC = db.collection('Users');



  //documents

  static DocumentReference users(String useruid) => userC.doc(useruid);




}


class StoragePath {
  static FirebaseStorage storage = FirebaseStorage.instance;

  static Reference userAvatar(String useruid) => storage.ref().child("users/$useruid/avatar.png");

  static Reference userImages(String useruid, String filePath) =>
      storage.ref().child("users/$useruid/userImages/${p.basename(filePath)}");

}