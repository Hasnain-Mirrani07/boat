import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../global_widgets/divider.dart';

class Get_Data extends GetxController {
  String? version;
 void versionChecker()async{
   PackageInfo packageInfo = await PackageInfo.fromPlatform();
   version = packageInfo.version;
    log(version.toString());
 }
  String? language;

  Future<void> showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async {
                    var locale_english=Locale('en','US');
                    Get.updateLocale(locale_english);
                    language='English';
                    Navigator.pop(context);
                  },
                  child: const Text('English'),
                ),
                const SizedBox(height: 9,),

                const Divider_con(),
                const SizedBox(height: 8,),

                GestureDetector(
                  onTap: () async {

                    var locale_arabic=Locale('ar','ae');
                    Get.updateLocale(locale_arabic);
                    language='Arabic';

                    Navigator.pop(context);
                  },child: const Text('Arabic'),),
              ],
            ),
          ),

        );
      },
    );
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String? uid;
  String? Profilename;
  String? Profileimg;
  Future<void> getdata() async {
    final User user = _auth.currentUser!;
    uid = user.uid;


    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot snap) {


        Profilename = snap['name'];
        Profileimg = snap['profile_img'];

    });
    update();


  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getdata();
  }

}