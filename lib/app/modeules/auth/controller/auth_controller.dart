import 'package:boat/app/modeules/auth/controller/profile_step_controller.dart';
import 'package:boat/app/modeules/auth/controller/signin_controller.dart';
import 'package:boat/app/modeules/auth/controller/signup_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../methods.dart';
import '../../../../services/firebase_auth_services.dart';
import '../../../../services/firebase_firestore_services.dart';
import '../../../models/myappuser.dart';

enum AuthState {
  INITIAL,
  INPROGRESS,
  SIGNEDINSUCESS,
  SIGNEDINFAIL,
  REGISTRATIONSUCESS,
  REGISTRATIONFAIL,
}

class AuthController extends BaseController {
  String? errorMessage;
  final FirebaseAuthService _authService = Get.find<FirebaseAuthService>();
  final FirebaseFirestoreServices _firestoreService = Get.find<FirebaseFirestoreServices>();

  Stream<MyAppUser?> get authStateChanges => _authService.authStateChanges;

  Future<AuthState> signUpWithEmailPassword(MyAppUser myAppUser, String password) async {
    clearErrorMessage();
    isLoading = true;

    try {
      MyAppUser? user = await _authService.signUpWithEmailPassword(myAppUser: myAppUser, password: password);

      if (user == null) {
        errorMessage = "Failed to signup";
        isLoading = false;
        Methods.showAuthErrorMessage(message: errorMessage ?? "Failed to signup");
        return AuthState.REGISTRATIONFAIL;
      }

      isLoading = false;

      Get.find<MyAppUser>().update(user);
      return AuthState.REGISTRATIONSUCESS;
    } on FirebaseException catch (e) {
      print('User Exception: ' + e.code);
      isLoading = false;
      errorMessage = e.message;
      Methods.showAuthErrorMessage(message: errorMessage ?? "Failed to signup");

      return AuthState.REGISTRATIONFAIL;
    } catch (E) {
      print(E);
      errorMessage = "Something went wrong!";
      Methods.showAuthErrorMessage(message: errorMessage ?? "Failed to signup");

      return AuthState.REGISTRATIONFAIL;
    }
  }

 Future<void> _checkIfBoatOwner(MyAppUser user) async {
    if (user.isBoatOwner == true) {
      throw FirebaseException(message: "Only Users are allowed", plugin: 'firebase_auth', code: 'credentials-boat-owner');
    }
  }

  Future<AuthState> signInWithEmailPassword(String email, String password) async {
    isLoading = true;
    MyAppUser? user;
    try {
      clearErrorMessage();
      print('***signInWithEmailPassword***');
      user = await _authService.signInWithEmailPassword(email: email, password: password);
      debugPrint('***signInWithEmailPassword***');
      if (user == null) {
        errorMessage = "Either email or password is incorrect";
        isLoading = false;
        Methods.showAuthErrorMessage(message: errorMessage ?? "Failed to sign in");

        return AuthState.REGISTRATIONFAIL;
      }
      final myuser = await _firestoreService.loadMyAppUserData(uid: user.id.toString());
      //check either user is boatOwner or not
      await _checkIfBoatOwner(myuser!);

      debugPrint('userid after lloading : ${myuser.id}');
      Get.find<MyAppUser>().update(myuser);
      isLoading = false;

      return AuthState.SIGNEDINSUCESS;
    } on FirebaseException catch (e) {
      print(e);
      print("ewrererer");
      isLoading = false;

      errorMessage = e.message ?? "Something went wrong, please try again later.";
      Methods.showAuthErrorMessage(message: errorMessage ?? "Failed to sign in");

      return AuthState.SIGNEDINFAIL;
    } catch (e) {
      print(e);
      errorMessage = "Something went wrong, please try again later.";
      Methods.showAuthErrorMessage(message: errorMessage ?? "Failed to sign in");

      return AuthState.SIGNEDINFAIL;
    }
  }

  clearErrorMessage() {
    errorMessage = null;
    update();
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
