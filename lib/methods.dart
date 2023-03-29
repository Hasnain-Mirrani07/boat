import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';

import 'app/global_widgets/image_view_picker.dart';

class Methods {
  static showAuthErrorMessage({required String message}){
    Get.snackbar(
      "Error",
      message,
      icon: const Icon(Icons.person, color: Colors.red),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  static Future<File> compressFile(String filepath) async {
    File compressedFile = await FlutterNativeImage.compressImage(filepath, quality: 50);
    return compressedFile;
  }

  static showImagePickerBS(context, {required model}) {
    showModalBottomSheet(
      context: context,
      elevation: 10.0,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
        ),
      ),
      builder: (context) => CameraImagePickerView(
        pickFromCamera: () {
          model.captureImage();
          Navigator.pop(context);
        },
        pickFromGallery: () {
          model.pickImage();
          Navigator.pop(context);
        },
      ),
    );
  }
}