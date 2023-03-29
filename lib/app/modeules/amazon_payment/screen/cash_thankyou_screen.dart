import 'package:boat/app/bottomapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custome_widged/custom_button.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';

class CashThankYouScreen extends StatelessWidget {
  const CashThankYouScreen({Key? key}) : super(key: key);

  // const ThankYouScreen({super.key});

  get editingController => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.5, vertical: 23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (event) => Get.offAll(Home()),
                  child: Image.asset(
                    crossIcon,
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
                SizedBox(
                  height: 55.h,
                ),
                const Center(
                  child: Text(
                    thankyouString,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                        color: blackTheme),
                  ),
                ),
                SizedBox(
                  height: 11.h,
                ),
                Center(
                  child: Text(
                    confirmString,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      color: greylight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 42.h,
                ),
                Image.asset(
                  thankyouImg,
                  width: 364.w,
                  height: 319.h,
                ),
                const SizedBox(
                  height: 6,
                ),
                const Center(
                  child: Text(
                    "Note",
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "your Booking Will Expired in 60 minutes so be on location on time.",
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                        color: blackTheme),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Thank you!",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ),
                SizedBox(
                  height: 44.h,
                ),
                Center(
                  child: BlueBtn(
                    title: "Go Home",
                    onPressed: () {
                      Get.offAll(Home());
                    },
                  ),
                ),
                SizedBox(
                  height: 26.36.h,
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
