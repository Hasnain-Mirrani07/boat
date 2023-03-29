import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/storagefile_services.dart';
import '../../../bottomapp.dart';
import '../../../firebase_paths.dart';
import '../../../global_widgets/mysnackbars.dart';
import '../../../models/myappuser.dart';

class ProfileStepController extends BaseController {
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  FirebaseStorageService storageService = FirebaseStorageService();

  final TextEditingController usernameC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  onInit(){
    super.onInit();
    usernameC.text = MyAppUser.find.name ??'';
  }
  onSubmit() {
    // if (isImagePicked() == false) {
    //   CustomSnackBar.showCustomErrorSnackBar(title: "Error", message: "Please select an image first to proceed");
    //   return;
    // }
    if (formKey.currentState?.validate() ?? false) {
      _uploadToFirebase();
    }
  }

  _uploadToFirebase() async {
    isLoading = true;
    try {
      String? profileUrl;
      if (isImagePicked()) {
        profileUrl =
            await storageService.uploadAFileToStorage(file!, StoragePath.userAvatar(FirebaseAuth.instance.currentUser?.uid ?? ""));
      }
      MyAppUser myAppUser = MyAppUser();
      myAppUser.email = FirebaseAuth.instance.currentUser?.email;
      myAppUser.name = usernameC.text;
      myAppUser.profileurl = profileUrl;
      myAppUser.totalBooking = "0";
      myAppUser.id = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance.collection("Users").doc(myAppUser.id).set(myAppUser.toMap());
      MyAppUser.find.update(myAppUser);
      isLoading = false;
      Get.off(() => Home());
    } catch (e) {
      String err = "Something went wrong";
      if (e is FirebaseException) {
        err = e.message ?? "something went wrong";
      }
      CustomSnackBar.showCustomErrorToast(message: err);
      debugPrint("err ocurred profilestepcontroller $e");
    }
  }

  captureImage() async {
    try {
      // if (await Permission.camera.isPermanentlyDenied) {
      //   openAppSettings();
      // }
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        file = image;
      }
      update();
    } catch (e) {
      print('Exception: ' + e.toString());
    }
  }

  pickImage() async {
    try {
      // if (await Permission.photos.isPermanentlyDenied) {
      //   openAppSettings();
      // }
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        file = image;
      }
      update();
    } catch (e) {
      print('Exception: ' + e.toString());
    }
  }

  bool isImagePicked() => file != null;
}

class BaseController extends GetxController {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  bool _isLoading2 = false;

  bool get isLoading2 => _isLoading2;

  set isLoading2(bool value) {
    _isLoading2 = value;
    update();
  }
}