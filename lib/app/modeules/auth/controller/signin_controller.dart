import 'package:boat/app/modeules/auth/controller/profile_step_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../main.dart';
import '../../../../services/firebase_firestore_services.dart';
import '../../../bottomapp.dart';
import '../../../models/myappuser.dart';
import 'auth_controller.dart';

class SignInController extends BaseController {
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController emailC = TextEditingController();

  final TextEditingController passwordC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool _isObsecure = false;

  validate() async {
    //Focus.of(Get.context!).unfocus();
    if (formKey.currentState?.validate() ?? false) {
      isLoading = true;
      AuthState authState = await authController.signInWithEmailPassword(
          emailC.text, passwordC.text);
      isLoading = false;
      if (authState == AuthState.SIGNEDINSUCESS) {
        //TODO: goto home
        Get.off(() => Home());
      } else {
        print(authState);
      }
    }
  }

  Future<void> signWithGoogle(BuildContext context, bool checkinglooged) async {
    try {
      isLoading2 = true;
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
        UserCredential result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        User? user = result.user;
        FirebaseFirestore.instance.collection("Users").doc(user!.uid).set({
          "p_image": user.photoURL,
          'p_name': user.displayName,
          'total_bookings': 0.toString(),
        });
        // await storage.write(key: 'uid1', value: user.uid);

        MyAppUser? myUser = await FirebaseFirestoreServices()
            .loadMyAppUserData(uid: FirebaseAuth.instance.currentUser?.uid);
        if (myUser != null) {
          isLoading2 = false;
          Get.off(const WrapperWidget());
        } // if result not null we simply call the MaterialpageRoute,
        // for go to the HomePage screen
      }
    } on FirebaseAuthException catch (e) {
      isLoading2 = false;
      Get.snackbar("Error", e.message.toString(),
          icon: const Icon(Icons.person, color: Colors.red),
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading2 = false;
    }
  }

//Getter setters below exists...
  bool get isObsecure => _isObsecure;

  set isObsecure(bool value) {
    _isObsecure = value;
    update();
  }
}
