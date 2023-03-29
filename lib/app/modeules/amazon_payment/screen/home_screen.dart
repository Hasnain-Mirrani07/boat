import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custome_widged/custom_button.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import 'paymentselection_screen.dart';

class HomeScreen extends StatelessWidget {
  //const HomeScreen({super.key});
  int? amount;
  HomeScreen({Key? key, this.amount}) : super(key: key);

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
                  onPointerDown: (event) => Get.back(),
                  child: Image.asset(
                    backIcon,
                    width: 19.w,
                    height: 12.h,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 18.0.h,
                      bottom: 13.h,
                    ),
                    child: const Text(
                      wehaveBookedString,
                      style: TextStyle(
                          fontSize: 22,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w600,
                          color: blac),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 13.h),
                    child: Text(
                      dearGeorgeString,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w500,
                        color: greylight,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Image.asset(
                  walletImg,
                  width: 370.w,
                  height: 407.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 93.h,
                ),
                Center(
                  child: BlueBtn(
                    title: "$payAmountString \$ $amount",
                    onPressed: () => Get.to(PaymentSelectionScreen(
                      amount: amount,
                    )),
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
