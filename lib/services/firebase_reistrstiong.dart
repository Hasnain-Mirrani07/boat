import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app/bottomapp.dart';
import '../app/modeules/auth/profile_selection.dart';

class FirebaseMethods {
  static Future<void> generateTokenAndSaveToDb() async {
    debugPrint("***generating toke***");
    FirebaseMessaging.instance.getToken().then((value) => {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(FirebaseAuth.instance.currentUser?.uid ?? "")
              .set({"token": value}, SetOptions(merge: true)),
          debugPrint("fcm \n $value")
        });
  }

  static firebaseSign({required String email, required String password}) async {
    User? user;

    try {
      user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user;
      print(user!.uid);

      Get.to(() => Home());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  static firebaseSignup(
      {required String email, required String password}) async {
    User? user;
    try {
      user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user;
      Get.to(() => const Profile_Selection(
            isFromAuthScreen: true,
            // checking_editing: false,
          ));
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> signup(
    BuildContext context,
  ) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;

        FirebaseFirestore.instance.collection("Users").doc(user!.uid).set({
          "profile_img": user.photoURL,
          'name': user.displayName,
          'bookings': 0.toString(),
        });
        if (user != null) {
          Get.to(Home());
        }
        // for go to the HomePage screen
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
