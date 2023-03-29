import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../../main.dart';
import '../../../bottomapp.dart';
import '../../../global_widgets/loading_indicator.dart';
import '../../../global_widgets/reuseable_button.dart';
import '../../../themes/AppAssets.dart';
import '../../../themes/AppColors.dart';
import '../../../themes/styles/textstyle.dart';
import '../profile_selection.dart';

class Phone_auth extends StatefulWidget {
  bool? checklooged;

  Phone_auth(this.checklooged);

  @override
  State<Phone_auth> createState() => _Phone_authState();
}

class _Phone_authState extends State<Phone_auth> {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController phone_number = TextEditingController();

  final TextEditingController otp = TextEditingController();
  bool otpVisibility = false;
  User? user;
  String verificationID = "";
  var phone;
  bool opt_vald = false;
  bool isLoading = false;

  toggleLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void loginWithPhone() async {
    toggleLoading(true);
    await auth.verifyPhoneNumber(
      phoneNumber: phone.toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          log("You are logged in successfully");
        });
        toggleLoading(false);
      },
      verificationFailed: (FirebaseAuthException e) {
        Fluttertoast.showToast(
          msg: "${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        toggleLoading(false);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {
          opt_vald = true;
        });
        toggleLoading(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

  }

  void verifyOTP() async {
    toggleLoading(true);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otp.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () async {
        toggleLoading(false);
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully".tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );

          Get.to(()=>const WrapperWidget(isSignUp: true));
          // widget.checklooged == true ? Get.to(Profile_Selection()) : Get.to(Home());
        } else {
          Fluttertoast.showToast(
            msg: "Your login is failed".tr,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 29,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(Icons.arrow_back_ios))),
                      Spacer(),
                      Text('JOIN US'.tr, style: AppTextStyles.kPrimaryTitle),
                      SizedBox(height: 8),
                      Text('Please enter your Phone number here'.tr, style: AppTextStyles.kPrimaryS2W4),
                      const SizedBox(height: 40),
                      opt_vald == false
                          ? InternationalPhoneNumberInput(
                              onInputValidated: (bool value) => print(value),
                              autoValidateMode: AutovalidateMode.disabled,
                              ignoreBlank: false,
                              onInputChanged: (value) {
                                setState(() {
                                  phone = value;
                                });
                              },
                              cursorColor: Colors.black,
                              formatInput: false,
                              selectorConfig: const SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                              inputDecoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone number'.tr,
                                hintStyle: const TextStyle(color: Colors.black26),
                                contentPadding: const EdgeInsets.only(left: -25, bottom: 15),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter otp'.tr;
                                  }
                                  return null;
                                },
                                controller: otp,
                                keyboardType: TextInputType.number,
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
                                    hintText: "Enter Otp".tr,
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
                      SizedBox(height: 56),
                      SizedBox(height: 56),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              child: Reuseable_button(
                                isLoading?const LoadingIndicator() :  opt_vald == false ? "Send OTP".tr : "Log In", AppColors
                                  .Sdark_blue, SvgPicture
                                  .asset(''), () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  opt_vald == false ? loginWithPhone() : verifyOTP();
                                  log(opt_vald.toString());
                                }
                              }),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}