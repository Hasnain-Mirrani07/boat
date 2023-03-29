import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/firebase_paths.dart';
import '../app/models/myappuser.dart';
abstract class AuthService {
  Future<MyAppUser?> signUpWithEmailPassword({required MyAppUser myAppUser, required password});

  Future<MyAppUser?> signInWithEmailPassword({required email, required password});



  Stream<MyAppUser?> get authStateChanges;


  Future<void> signOut();
}

class FirebaseAuthService extends GetxService implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Future<MyAppUser?> signInWithEmailPassword({required email, required password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      debugPrint('User Exception: ' + e.toString());
      rethrow;
    }
  }

  @override
  Future<MyAppUser?> signUpWithEmailPassword({required myAppUser, required password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: myAppUser.email!, password: password);
      myAppUser.id = userCredential.user!.uid;
      myAppUser.createdAt = DateTime.now().millisecondsSinceEpoch;
      // myAppUser.updatedAt = DateTime.now().millisecondsSinceEpoch;
      createUserCollection(myAppUser);
      return myAppUser;
    } catch (e) {
      print('User Exception: ' + e.toString());
      rethrow;
    }
  }

  Future createUserCollection(MyAppUser myAppUser) async {
    try {

      await FirebasePaths.users(FirebaseAuth.instance.currentUser!.uid).set(myAppUser.toMap());

    } catch (e) {
      print("err occured at createUserCollection ");

    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }



  @override
  Stream<MyAppUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  /// private method to create `User` from `FirebaseUser`
  MyAppUser? _userFromFirebase(User? user) {
    if (user != null) {
      print("user. ${user.uid}");
      MyAppUser myAppUser = MyAppUser();
      myAppUser.id = user.uid;
      return myAppUser;
    }
  }


}
