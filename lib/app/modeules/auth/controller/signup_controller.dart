import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/myappuser.dart';
import '../profile_selection.dart';
import 'auth_controller.dart';

class SignUpController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailC = TextEditingController();

  final TextEditingController usernameC = TextEditingController();

  final TextEditingController passwordC = TextEditingController();

  final TextEditingController confirmPasswordC = TextEditingController();
  bool _isObsecure = true;

  validate() async {
    //  Focus.of(Get.context!).unfocus();
    if (formKey.currentState?.validate() ?? false) {
      final myAppUser = MyAppUser();
      myAppUser.name = usernameC.text.trim();
      myAppUser.email = emailC.text.trim();

      AuthState authState = await authController.signUpWithEmailPassword(
          myAppUser, passwordC.text);
      if (authState == AuthState.REGISTRATIONSUCESS) {
        authController.clearErrorMessage();

        //TODO: goto home
        Get.off(() => const Profile_Selection(
              isFromAuthScreen: true,
            ));
      } else {
        print(authState);
      }
    } else {
      print("not validated");
    }
  }

  //Getter setters below exists...
  bool get isObsecure => _isObsecure;

  set isObsecure(bool value) {
    _isObsecure = value;
    update();
  }
}
