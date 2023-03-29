import 'dart:io';

import 'package:boat/app/modeules/auth/controller/auth_controller.dart';
import 'package:boat/app/modeules/auth/views/Sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../methods.dart';
import '../../global_widgets/reuseable_button.dart';
import '../../models/myappuser.dart';
import '../../themes/AppColors.dart';
import '../../themes/styles/textstyle.dart';
import 'controller/profile_step_controller.dart';

class Profile_Selection extends StatelessWidget {
  final bool isFromAuthScreen;

  const Profile_Selection({Key? key, this.isFromAuthScreen = false}) : super(key: key);

  Widget _buildProfileImage(ProfileStepController controller) {
    if (controller.file != null) {
      return CircleAvatar(radius: 50, backgroundImage: FileImage(File(controller.file!.path)));
    } else if (MyAppUser.find.profileurl != null) {
      return CircleAvatar(radius: 50, backgroundImage: NetworkImage(MyAppUser.find.profileurl!));
    } else {
      return const CircleAvatar(radius: 50, backgroundColor: Colors.white, backgroundImage: AssetImage("assets/profile_img.png"));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("im from authscreen $isFromAuthScreen");
    return Scaffold(
        body: GetBuilder<ProfileStepController>(
      init: ProfileStepController(),
      builder: (controller) {
        return SafeArea(
          child: Form(
            key: controller.formKey,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 8,
                  child: SafeArea(child: BackButton(
                    onPressed: () async {
                      if (isFromAuthScreen == false) {
                        Get.back();
                        return;
                      }
                      await FirebaseAuth.instance.signOut();
                      Get.offAll(() => const Sign_in(), transition: Transition.fadeIn, binding: AuthBindings());
                    },
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Spacer(),
                      const SizedBox(height: 20),
                      const Text("Profile", style: AppTextStyles.kPrimaryTitle),
                      Spacer(),
                      const SizedBox(height: 35),
                      _buildProfileImage(controller),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          Methods.showImagePickerBS(context, model: controller);
                        },
                        child: const Text("Upload Image",
                            style: TextStyle(fontSize: 14, color: Colors.blueGrey, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 45),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 56,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Name';
                            }
                          },
                          controller: controller.usernameC,
                          decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            labelText: "Name",
                            hintStyle: AppTextStyles.kPrimaryS2W4,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Reuseable_button(
                          controller.isLoading ? "Processing, Please wait..." : "Next",
                          AppColors.Sdark_blue,
                          null,
                          controller.isLoading
                              ? null
                              : () {
                                  FocusScope.of(context).unfocus();
                                  controller.onSubmit();
                                  // if (formGlobalKey.currentState!.validate() &&
                                  //     !currentFocus.hasPrimaryFocus) {
                                  //   formGlobalKey.currentState!.save();
                                  //
                                  //   currentFocus.unfocus();
                                  //
                                  //   if (con.image == null) {
                                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  //       content: Text("Please Selecte Profile Image"),
                                  //     ));
                                  //   } else {
                                  //     Get.to(Home());
                                  //     con.send_data();
                                  //     con.change();
                                  //     log("${con.kk}");
                                  //   }
                                  // }
                                }),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));

    // return Scaffold(
    //   body: con.kk == false
    //       ? Center(child: CircularProgressIndicator())
    //       : Form(
    //           key: formGlobalKey,
    //           child: Center(
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 25.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Spacer(),
    //                   Text(
    //                     "Profile",
    //                     style: AppTextStyles.kPrimaryTitle,
    //                   ),
    //                   SizedBox(
    //                     height: 35,
    //                   ),
    //                   con.image == null
    //                       ? Image.asset(
    //                           "assets/profile_img.png",
    //                           width: 97,
    //                           height: 97,
    //                         )
    //                       : CircleAvatar(
    //                           radius: 50,
    //                           backgroundImage: FileImage(con.image!)),
    //                   SizedBox(
    //                     height: 10,
    //                   ),
    //                   InkWell(
    //                     onTap: () async {
    //                       print("im tapped");
    //                       await getImage();
    //                       print("im executed");
    //                     },
    //                     child: const Text(
    //                       "Upload Image",
    //                       style: TextStyle(
    //                           fontSize: 14,
    //                           color: Colors.blueGrey,
    //                           fontWeight: FontWeight.w600),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: 45,
    //                   ),
    //                   Container(
    //                     width: MediaQuery.of(context).size.width / 1.1,
    //                     height: 56,
    //                     child: TextFormField(
    //                       validator: (value) {
    //                         if (value!.isEmpty) {
    //                           return 'Please Enter Name';
    //                         }
    //                       },
    //                       controller: con.name,
    //                       decoration: InputDecoration(
    //                         errorBorder: OutlineInputBorder(
    //                           borderSide: const BorderSide(
    //                               width: 1, color: AppColors.S_text),
    //                           borderRadius: BorderRadius.circular(16),
    //                         ),
    //                         focusedErrorBorder: OutlineInputBorder(
    //                           borderSide: const BorderSide(
    //                               width: 1, color: AppColors.S_text),
    //                           borderRadius: BorderRadius.circular(16),
    //                         ),
    //                         labelText: "Name",
    //                         hintStyle: AppTextStyles.kPrimaryS2W4,
    //                         enabledBorder: OutlineInputBorder(
    //                           borderSide: const BorderSide(
    //                               width: 1, color: AppColors.S_text),
    //                           borderRadius: BorderRadius.circular(16),
    //                         ),
    //                         focusedBorder: OutlineInputBorder(
    //                           borderSide: const BorderSide(
    //                               width: 1, color: AppColors.S_text),
    //                           borderRadius: BorderRadius.circular(16),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Spacer(),
    //                   Reuseable_button(
    //                       "Next", AppColors.Sdark_blue, null,
    //                       () {
    //                     FocusScopeNode currentFocus = FocusScope.of(context);
    //                     if (formGlobalKey.currentState!.validate() &&
    //                         !currentFocus.hasPrimaryFocus) {
    //                       formGlobalKey.currentState!.save();
    //
    //                       currentFocus.unfocus();
    //
    //                       if (con.image == null) {
    //                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                           content: Text("Please Selecte Profile Image"),
    //                         ));
    //                       } else {
    //                         Get.to(Home());
    //                         con.send_data();
    //                         con.change();
    //                         log("${con.kk}");
    //                       }
    //                     }
    //                   }),
    //                   SizedBox(
    //                     height: 25,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    // );
  }
}