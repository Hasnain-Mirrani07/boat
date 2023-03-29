import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../customTextField2.dart';
import '../custome_widged/custom_button.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import 'cashpayment_screen.dart';

class PinVerificationScreen extends StatefulWidget {
//  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  get editingController => null;

  bool isChecked = false;

  var _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start == 0) {
                timer.cancel();
                _start = 60;
                setState(() {});
              } else {
                _start = _start - 1;
              }
            }));
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.5, vertical: 23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (event) => Get.back(),
                  child: Image.asset(
                    backIcon,
                    width: 19.w,
                    height: 12.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0.h, left: 5),
                  child: const Text(
                    pinVerifyString,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                        color: blac),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 13.h, left: 5.w),
                  child: Text(
                    plzEnterOinString,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      color: greylight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: CustomTextField2(
                    hintText: "123456",
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (event) => {},
                    child: Text.rich(
                      TextSpan(
                        text: '"Did not recieved code?',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w700,
                          color: darkBlue2Color,
                        ), // default text style
                        children: [
                          TextSpan(
                            text: ' $_start  ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w700,
                              letterSpacing: .5,
                              color: pinkColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const Spacer(
                //   flex: 1,
                // ),
                SizedBox(
                  height: 428.h,
                ),
                Center(
                  child: BlueBtn(
                    title: "Pay (175\$)",
                    onPressed: () => Get.to(const CashPaymentScreen()),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Center(
                  child: Container(
                      height: 5.h,
                      width: 134.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: blac)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
