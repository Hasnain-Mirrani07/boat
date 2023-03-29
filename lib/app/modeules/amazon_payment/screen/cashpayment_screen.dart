import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custome_widged/custom_button.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import 'home_screen.dart';
import 'cash_thankyou_screen.dart';

class CashPaymentScreen extends StatefulWidget {
  const CashPaymentScreen({Key? key}) : super(key: key);

  // const CashPaymentScreen({super.key});

  @override
  State<CashPaymentScreen> createState() => _CashPaymentScreenState();
}

class _CashPaymentScreenState extends State<CashPaymentScreen> {
  final editingController = TextEditingController();
  @override
  void initState() {
    editingController.text = 175.toString();
    // TODO: implement initState
    super.initState();
  }

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
                  onPointerDown: (event) => Get.to(() => HomeScreen()),
                  child: Image.asset(
                    backIcon,
                    width: 19.w,
                    height: 12.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0.h, left: 5),
                  child: const Text(
                    cashpayString,
                    style: TextStyle(
                        fontSize: 23,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w600,
                        color: blac),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    selecMethodString,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      color: greylight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pinkColor.withOpacity(.15),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.h, left: 22.w, bottom: 68.h),
                            child: Image.asset(
                              alertIcon,
                              width: 22.w,
                              height: 22.h,
                            ),
                          ),
                          SizedBox(
                            width: 11.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: 20.w, top: 18.h, bottom: 20.h),
                            child: SizedBox(
                              width: 170.w,
                              height: 72.h,
                              child: Text(
                                alertString,
                                maxLines: 4,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  color: black3Color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Card(
                  elevation: 5,
                  shadowColor: Colors.grey.shade100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 20.h,
                            bottom: 10.h,
                            left: 20.w,
                          ),
                          child: Text(
                            paymentSummryString,
                            style: TextStyle(
                                fontSize: 17.sp,
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w500,
                                color: lighblack),
                          )),
                      Divider(
                        indent: 20.w,
                        endIndent: 15,
                        thickness: 1.h,
                        color: dividerColor,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: Text(
                              payableString,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .15.w,
                                  color: lightGrey2Color),
                            ),
                          ),
                          SizedBox(
                            width: 131.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 10.w,
                            ),
                            child: Text(
                              "171\$",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  color: lightGrey2Color),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: Text(
                              "Tax",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .15.w,
                                  color: lightGrey2Color),
                            ),
                          ),
                          SizedBox(
                            width: 200.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, bottom: 18.h),
                            child: Text(
                              "5\$",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  color: lightGrey2Color),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        indent: 20.w,
                        endIndent: 15,
                        thickness: 1.h,
                        color: dividerColor,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 30.w,
                            ),
                            child: Text(
                              amountToPayString,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .15.w,
                                  color: lightGrey2Color),
                            ),
                          ),
                          SizedBox(
                            width: 147.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, bottom: 18.h),
                            child: Text(
                              "175\$",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  color: darkBlueColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 58.h,
                ),
                Container(
                  color: white,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          enterPaidString,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w500,
                              color: blackTheme),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: contBorderColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 44.0.h,
                            width: 170.w,
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 24.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  color: blackTheme),
                              controller: editingController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                // hintText: hintText,
                                hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: lightGreyColor),
                                contentPadding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                // enabledBorder: OutlineInputBorder(
                                //   borderSide: const BorderSide(width: 1, color: blac),
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //   borderSide: const BorderSide(
                                //       width: 1, color: Color.fromARGB(255, 132, 160, 216)),
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                              ),
                              onChanged: (val) {},
                            ),
                          )),
                      Container(
                        width: 69.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                            color: blueThemeColor,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: contBorderColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              "\$",
                              style: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w500,
                                  color: white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Center(
                  child: BlueBtn(
                    title: payAmounString,
                    onPressed: () {
                      Get.to(CashThankYouScreen());
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
