import 'package:boat/app/bottomapp.dart';
import 'package:boat/app/modeules/auth/controller/auth_controller.dart';
import 'package:boat/app/modeules/auth/views/Sign_in.dart';
import 'package:boat/app/modeules/settings/widgets/divider.dart';
import 'package:boat/app/modeules/settings/widgets/reuseable_widget.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../tracking_odrer/controller/get_data.dart';

class Settings_screen extends StatefulWidget {
  @override
  State<Settings_screen> createState() => _Settings_screenState();
}

class _Settings_screenState extends State<Settings_screen> {
  bool isSwitched = false;
  final con = Get.put(Get_Data());
@override
  void initState() {
    // TODO: implement initState
  con.versionChecker();
  super.initState();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.back();
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => Home(),
          //     ));

          return true;
          //we need to return a future
        },
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:5, bottom: 25, top: 20),
                  child: Row(
                    children: [
                      BackButton(

                        onPressed: (){
                          Get.back();
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Home(),
                          //     ));
                        },
                      ),
                      SizedBox(width: 10,),
                      Text(
                        "text54".tr,
                        style: AppTextStyles.ktitle,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/icons/notification.svg"),
                  title:  Text(
                    "text38".tr,
                    style: AppTextStyles.kPrimaryS7W4,
                  ),
                  subtitle: Text(
                    "text39".tr,
                    style: AppTextStyles.kPrimaryS8W5,
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.blue,
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                  ),
                ),
                const Divider_con(),
                GestureDetector(
                  onTap: (){

                    con.showMyDialog(context);
                  },
                  child: Reuseable_widget("text40".tr, con.language ?? 'English', "language"),
                ),
                Reuseable_widget("text41".tr, "text42".tr, "help"),
                Reuseable_widget("text43".tr, "text48".tr, "faq"),
                Reuseable_widget(
                    "text49".tr, "text50".tr, "privacy"),
                Reuseable_widget("text51".tr, "Version ${con.version ?? '1.0.0'}", "about_app"),
                ListTile(
                  leading: SvgPicture.asset("assets/icons/logout.svg"),
                  title: GestureDetector(
                      onTap: () async {

                            GoogleSignIn().signOut();
                        await FirebaseAuth.instance.signOut();
                        Get.to(const Sign_in(),binding: AuthBindings());
                      },
                      child: Text(
                        "text53".tr,
                        style: AppTextStyles.kPrimaryS8W5,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}