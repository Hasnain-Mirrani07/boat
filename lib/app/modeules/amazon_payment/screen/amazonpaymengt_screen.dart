import 'package:boat/app/modeules/amazon_payment/screen/cash_thankyou_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custome_widged/custom_button.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import 'thankyou_screen.dart';

class AmazonPaymentScreen extends StatefulWidget {
  AmazonPaymentScreen({Key? key, this.amount}) : super(key: key);
  int? amount;
//  const AmazonPaymentScreen({super.key});

  @override
  State<AmazonPaymentScreen> createState() => _AmazonPaymentScreenState();
}

class _AmazonPaymentScreenState extends State<AmazonPaymentScreen> {
  get editingController => null;

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.5, vertical: 23.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (event) => Get.back(),
                  child: Image.asset(
                    backIcon,
                    width: 20.w,
                    height: 12.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0.h, left: 5),
                  child: const Text(
                    amazonPaymentString,
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
                    enterCreditNoString,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      color: greylight,
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // radius of 10
                        color: grey3Color // green as background color
                        ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.w, vertical: 15.h),
                      child: Column(
                        children: [
                          Container(
                            color: white,
                            child: Column(children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.w, top: 14.h, right: 141.w),
                                  child: Text(
                                    cardNameString,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontFamily: "poppins",
                                      fontWeight: FontWeight.w500,
                                      color: grey4Color,
                                    ),
                                  ),
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 14.w),
                                  hintText: 'John Doe',
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: "poppins",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            color: white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 14.w,
                                          top: 14.h,
                                        ),
                                        child: Text(
                                          cardNoString,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: "poppins",
                                            fontWeight: FontWeight.w500,
                                            color: grey4Color,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 180,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(left: 14.w),
                                            hintText: '5470 0004 0003 0002',
                                            hintStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "poppins",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: SizedBox(
                                    height: 30,
                                    width: 32,
                                    child: Image(
                                        image: AssetImage(mastercardIcon)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              expirydateString,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: "poppins",
                                fontWeight: FontWeight.w400,
                                color: blue2Color,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              Container(
                                color: white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 11.w,
                                          bottom: 7.h,
                                          right: 69.w,
                                          left: 14.w),
                                      child: Text(
                                        "Month",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.w400,
                                          color: grey5Color,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 7.h, right: 69.w, left: 14.w),
                                      child: SizedBox(
                                        height: 40,
                                        width: 60,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(left: 14.w),
                                            hintText: '12',
                                            hintStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "poppins",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 9.5.w,
                              ),
                              Container(
                                color: white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 11.w,
                                          bottom: 7.h,
                                          right: 69.w,
                                          left: 14.w),
                                      child: Text(
                                        "Year",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontFamily: "poppins",
                                          fontWeight: FontWeight.w400,
                                          color: grey5Color,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 7.h, right: 69.w, left: 14.w),
                                      child: SizedBox(
                                        height: 40,
                                        width: 60,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.only(left: 14.w),
                                            hintText: '2023',
                                            hintStyle: TextStyle(
                                              fontSize: 14.sp,
                                              fontFamily: "poppins",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              color: white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 11.w,
                                        bottom: 7.h,
                                        right: 69.w,
                                        left: 14.w),
                                    child: Text(
                                      "Security Code",
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.w400,
                                        color: grey5Color,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 7.h, right: 69.w, left: 14.w),
                                    child: SizedBox(
                                      height: 40,
                                      width: 60,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding:
                                              EdgeInsets.only(left: 14.w),
                                          hintText: '574',
                                          hintStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: "poppins",
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text(
                                remebermeString,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w400,
                                  color: black2Color,
                                ),
                              ),
                              SizedBox(
                                height: 19.h,
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 23.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        amounttoPayString,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: "poppins",
                          fontWeight: FontWeight.w400,
                          color: blackTheme.withOpacity(.4),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 192.w,
                    ),
                    Text(
                      "\$${widget.amount}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w500,
                        color: blackTheme,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                  ],
                ),
                Divider(
                  indent: 12.w,
                  endIndent: 10.w,
                  thickness: 1.5.h,
                  color: dividerColor,
                ),
                SizedBox(
                  height: 81.h,
                ),
                Center(
                  child: BlueBtn(
                    title: "Pay (${widget.amount}\$)",
                    onPressed: () => Get.to(const ThankYouScreen()),
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
