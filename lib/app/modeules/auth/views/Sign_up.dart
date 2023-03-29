
import 'package:boat/app/modeules/auth/views/phone-auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../services/firebase_reistrstiong.dart';
import '../../../global_widgets/reuseable_button.dart';
import '../../../themes/AppAssets.dart';
import '../../../themes/AppColors.dart';
import '../../../themes/AppDimensions.dart';
import '../../../themes/styles/textstyle.dart';
import '../controller/signup_controller.dart';

class Sign_up extends StatefulWidget {
  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  // final formGlobalKey = GlobalKey<FormState>();
  //
  // final TextEditingController conOne = TextEditingController();
  //
  // final TextEditingController conTwo = TextEditingController();
  //
  // final TextEditingController conThree = TextEditingController();
  final con = Get.put(FirebaseMethods());

  bool _obsuretext = true;
  bool _obsuretext2 = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              GetBuilder<SignUpController>(
                  init: SignUpController(),
                  builder: (controller) {
                    return Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 70),
                          Text('Registration'.tr, style: AppTextStyles.kPrimaryTitle),
                          const SizedBox(height: 8),
                          Text('Please enter your account here'.tr, style: AppTextStyles.kPrimaryS2W4),
                          const SizedBox(height: 30),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            // height: 56,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter email'.tr;
                                } else if (value.length <= 2) return 'Email too short'.tr;
                                return null;
                              },
                              controller: controller.emailC,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  prefixIcon: SizedBox(width: 20, height: 10, child: Appassets.icon_mail),
                                  hintText: "Email".tr,
                                  hintStyle: AppTextStyles.kPrimaryS2W4,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Password'.tr;
                                } else if (value.length <= 6) return 'Password too short'.tr;
                                return null;
                              },
                              obscureText: _obsuretext2,
                              controller: controller.passwordC,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  prefixIcon: SizedBox(width: 20, height: 10, child: Appassets.icon_lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obsuretext2 = !_obsuretext2;
                                      });
                                    },
                                  ),
                                  hintText: "Password".tr,
                                  hintStyle: AppTextStyles.kPrimaryS2W4,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: TextFormField(
                              validator: (val) {
                                if (val != controller.passwordC.text) return 'Password Not Match'.tr;
                                return null;
                              },
                              obscureText: _obsuretext,
                              controller: controller.confirmPasswordC,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  prefixIcon: SizedBox(width: 20, height: 10, child: Appassets.icon_lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obsuretext = !_obsuretext;
                                      });
                                    },
                                  ),
                                  hintText: "Confirm Password".tr,
                                  hintStyle: AppTextStyles.kPrimaryS2W4,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1, color: AppColors.S_text),
                                    borderRadius: BorderRadius.circular(16),
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 39,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Reuseable_button("Sign up".tr, AppColors.Sdark_blue, null, () {
                                Fluttertoast.showToast(
                                    msg: "Please wait..".tr,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM_RIGHT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                controller.validate();
                                // if (formGlobalKey.currentState!.validate()) {
                                //   formGlobalKey.currentState!.save();
                                //   FirebaseMethods.firebaseSignup(
                                //       email: conOne.text, password: conTwo.text);
                                // }
                              })),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 26.0),
                            child: Text(
                              "Or continue with".tr,
                              style: AppTextStyles.kPrimaryS2W4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    child: Reuseable_button("Google", AppColors.red, null, () {
                                      con.signup(context);
                                    }),
                                  ),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: GestureDetector(
                                    child: Reuseable_button("Phone Number".tr, AppColors.Sdark_blue, null, () {
                                      Get.to(Phone_auth(true));
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 26),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: RichText(
                              text: TextSpan(
                                  text: 'Already have an account?'.tr,
                                  style: const TextStyle(color: AppColors.Proyel_blue, fontSize: AppDimensions.kMediumSize),
                                  children: <TextSpan>[
                                    TextSpan(text: ' ' + 'Login'.tr, style: AppTextStyles.kPrimaryS4W4),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}