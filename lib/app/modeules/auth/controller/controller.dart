// import 'dart:developer';
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../../../bottomapp.dart';
//
// class profile_upload extends GetxController {
//   bool? kk;
//
//   void change() {
//     kk = false;
//     update();
//   }
//
//   File? image;
//   String? uid;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController name = TextEditingController();
//
//   void send_data() async {
//     final User user = _auth.currentUser!;
//     uid = user.uid;
//
//     final storageReference = FirebaseStorage.instance.ref();
//     final reference = storageReference.child("profileImages/profileimage1");
//
//     UploadTask uploadTask = reference.putFile(image!);
//     final snapshot = await uploadTask.whenComplete(() {
//       kk = true;
//       update();
//
//       Get.to(Home());
//     });
//     final urlDownload = await snapshot.ref.getDownloadURL();
//
//     log("$urlDownload");
//
//     FirebaseFirestore.instance.collection("Users").doc(uid).set({
//       "p_image": urlDownload,
//       'p_name': name.text,
//       'total_bookings': 0.toString(),
//     });
//   }
// }
