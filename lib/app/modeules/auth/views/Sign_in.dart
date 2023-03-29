import 'package:boat/app/modeules/auth/views/phone-auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../services/firebase_reistrstiong.dart';
import '../../../global_widgets/loading_indicator.dart';
import '../../../global_widgets/reuseable_button.dart';
import '../../../themes/AppAssets.dart';
import '../../../themes/AppColors.dart';
import '../../../themes/AppDimensions.dart';
import '../../../themes/styles/textstyle.dart';
import '../controller/signin_controller.dart';
import 'Sign_up.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController conOne = TextEditingController();

  final TextEditingController conTwo = TextEditingController();
  final con = Get.put(FirebaseMethods());

  bool _obsuretext = true;
  bool isLoading = false;

  toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: GetBuilder<SignInController>(
          init: SignInController(),
          builder: (controller) => Form(
            key: controller.formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      Text('Welcome Back!'.tr, style: AppTextStyles.kPrimaryTitle),
                      const SizedBox(height: 8),
                      Text('Please enter your account here'.tr, style: AppTextStyles.kPrimaryS2W4),
                      const SizedBox(height: 30),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter email'.tr;
                            }
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
                            }
                            return null;
                          },
                          obscureText: _obsuretext,
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
                                    _obsuretext = !_obsuretext;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Forgot password?".tr,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff2E3E5C)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 78),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child:
                            Reuseable_button(controller.isLoading ? LoadingIndicator() : "Login".tr, AppColors.Sdark_blue, null, () {
                          // Fluttertoast.showToast(
                          //     msg: "Please wait..".tr,
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM_RIGHT,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.black,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0);

                          controller.validate();
                          // if (formKey.currentState!.validate()) {
                          //   formKey.currentState!.save();
                          //   FirebaseMethods.firebaseSign(email: conOne.text, password: conTwo.text);
                          // }
                        }),
                      ),
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
                                child: Reuseable_button(controller.isLoading2 ? LoadingIndicator() : "Google".tr, AppColors.red, null,
                                    () {
                                  controller.signWithGoogle(context, true);
                                  // con.signup(context, true);
                                }),
                              ),
                            ),
                            SizedBox(width: 14),
                            Expanded(
                              child: GestureDetector(
                                child: Reuseable_button("Phone Number".tr, AppColors.Sdark_blue, null, () {
                                  Get.to(Phone_auth(false));
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => Sign_up());
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'Don’t have any account?'.tr,
                              style: TextStyle(color: AppColors.Proyel_blue, fontSize: AppDimensions.kMediumSize),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' ' + 'Sign up'.tr,
                                  style: AppTextStyles.kPrimaryS4W4,
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}