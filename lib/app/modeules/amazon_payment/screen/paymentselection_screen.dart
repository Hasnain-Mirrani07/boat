import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custome_widged/custom_button.dart';
import '../custome_widged/custom_textfield.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';
import 'amazonpaymengt_screen.dart';
import 'cash_thankyou_screen.dart';
import 'home_screen.dart';

class PaymentSelectionScreen extends StatefulWidget {
  PaymentSelectionScreen({Key? key, this.amount}) : super(key: key);
  int? amount = 0;

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  // AmazonPayFlutter amazonPay = AmazonPayFlutter(sellerId: 'YOUR_SELLER_ID');
  String? matchCode = '';
  int? totalbill;
  var extracted = '';
  int afterDisc = 0;
  bool ismatch = false;
  final promocodeController = TextEditingController();
  int selected = 0;

  // void amazonPayment() async {
  //   var requestParam = {
  //     "amount": 100,
  //     "command": "AUTHORIZATION",
  //     "currency": "USD",
  //     "customer_email": "test@gmail.com",
  //     "language": "en",
  //     "merchant_reference": "your merchant reference",
  //     "sdk_token": "sdk token generated per transaction"
  //   };
  //   LinkedHashMap<Object?, Object?> result;
  //   try {
  //     result = await FlutterAmazonpaymentservices.normalPay(
  //         requestParam, EnvironmentType.production,
  //         isShowResponsePage: true);
  //   } on PlatformException catch (e) {
  //     print("Error ${e.message} details:${e.details}");
  //     return;
  //   }

  //   print("Success $result");
  // }

  bool iswait = false;

  // int indicator = 0;
  // var _timer;

  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //       oneSec,
  //       (Timer timer) => setState(() {
  //             if (indicator == 5) {
  //               timer.cancel();
  //               selected == 0
  //                   ? Get.to(const AmazonPaymentScreen())
  //                   : Get.to(const ThankYouScreen());

  //               setState(() {});
  //             } else {
  //               indicator = indicator + 1;
  //             }
  //           }));
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("amount ----${widget.amount}");
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
                    paymentSelectionString,
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
                    plzSelectPayString,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      color: greylight,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Center(
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.grey.shade100,
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 19.h, bottom: 7.h, left: 15.w, right: 15.w),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: contBorderColor, // red as border color
                                ),
                                borderRadius:
                                    BorderRadius.circular(10), // radius of 10
                                color: white // green as background color
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 170,
                                  child: CustomTextField(
                                    hintText: promoHintString,
                                    onChanged: (val) {
                                      setState(() {
                                        matchCode = val;
                                        extractDiscount();
                                      });
                                    },
                                    ismatch: ismatch,
                                  ),
                                ),
                                Listener(
                                  behavior: HitTestBehavior.translucent,
                                  onPointerDown: (event) {
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: ismatch != true
                                        ? Text(
                                            "Apply",
                                            style: TextStyle(
                                                color: pinkColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                "Applied!",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              Icon(
                                                Icons.check,
                                                color: Colors.green,
                                                size: 18.h,
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 1.h,
                                  bottom: 17.h,
                                  left: 40.w,
                                  right: 15.w),
                              child: ismatch != true && matchCode!.isNotEmpty
                                  ? Text(
                                      "Promot code is invalid or Expire",
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.w400,
                                        color: errColor,
                                      ),
                                    )
                                  : const SizedBox()),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
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
                                fontSize: 19.sp,
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
                                  fontSize: 14.sp,
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
                                  fontSize: 16.sp,
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
                                  fontSize: 14.sp,
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
                                  fontSize: 16.sp,
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
                                  fontSize: 14.sp,
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: .15.w,
                                  color: lightGrey2Color),
                            ),
                          ),
                          SizedBox(
                            width: 140.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.w, bottom: 18.h),
                            child: Text(
                              ismatch == true
                                  ? "\$${afterDisc.toString()}"
                                  : "\$${widget.amount}",
                              style: TextStyle(
                                  fontSize: 18.sp,
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
                  height: 37.h,
                ),
                Container(
                  color: white,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          payUsingString,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: "poppins",
                              fontWeight: FontWeight.w600,
                              color: darkBlue2Color),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: contBorderColor, // red as border color
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // radius of 10
                              color: white // green as background color
                              ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.h, bottom: 20.h, left: 20.w),
                            child: Listener(
                              behavior: HitTestBehavior.translucent,
                              onPointerDown: (event) {
                                setState(() {
                                  selected = 1;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cashPayString,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontFamily: "poppins",
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: .15.w,
                                        color: lighblack),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        right: 25.h,
                                      ),
                                      child: Radio(
                                          value: 1,
                                          groupValue: selected,
                                          onChanged: (int? value) {
                                            selected = value!;
                                            setState(() {});
                                          }))
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: contBorderColor, // red as border color
                              ),
                              borderRadius:
                                  BorderRadius.circular(10), // radius of 10
                              color: white // green as background color
                              ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 20.h, bottom: 20.h, left: 20.w),
                            child: Listener(
                              behavior: HitTestBehavior.translucent,
                              onPointerDown: (event) {
                                setState(() {
                                  selected = 0;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    amazonImg,
                                    width: 102.w,
                                    height: 20.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        right: 25.h,
                                      ),
                                      child: Radio(
                                          value: 0,
                                          groupValue: selected,
                                          onChanged: (int? value) {
                                            selected = value!;
                                            setState(() {});
                                            //selected value
                                          }))
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 27.h,
                ),
                Center(
                    child: BlueBtn(
                  title: selected == 0 ? payAmounString : " Will Pay Cash",
                  onPressed: () {
                    selected == 0
                        ? _showMyDialog()
                        : Get.offAll(const CashThankYouScreen());
                  },
                )),
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

// Dialog box for waiting
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 3), () {
          Get.off(AmazonPaymentScreen(
            amount: widget.amount,
          ));
        });
        return AlertDialog(
          backgroundColor: Colors.blue.shade100,
          content: Container(
            height: 90.h,
            color: Colors.blue.shade100,
            child: Column(children: [
              SizedBox(
                height: 10.h,
              ),
              const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Center(
                  child: Text(
                "Waiting...",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                    letterSpacing: .15.w,
                    color: white),
              ))
            ]),
          ),
          actions: const <Widget>[],
        );
      },
    );
  }

// //Dialog box for Cash pay Alert
//   Future<void> _showCashPayDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         // Future.delayed(const Duration(seconds: 3), () {
//         //   selected == 1
//         //       ? Get.off(const ThankYouScreen())
//         //       : Get.off(AmazonPaymentScreen(
//         //           amount: widget.amount,
//         //         ));
//         // });
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           content: Container(
//             height: 290.h,
//             color: Colors.white,
//             child: Column(children: [
//               SizedBox(
//                 height: 55.h,
//               ),
//               const Center(
//                 child: Text(
//                   thankyouString,
//                   style: TextStyle(
//                       fontSize: 23,
//                       fontFamily: "poppins",
//                       fontWeight: FontWeight.w600,
//                       color: blackTheme),
//                 ),
//               ),
//               SizedBox(
//                 height: 11.h,
//               ),
//               Center(
//                 child: Text(
//                   confirmString,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: "poppins",
//                     fontWeight: FontWeight.w400,
//                     color: greylight,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Center(
//                 child: Text(
//                   "Note",
//                   style: TextStyle(
//                       fontSize: 23,
//                       fontFamily: "poppins",
//                       fontWeight: FontWeight.w600,
//                       color: Colors.red),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Center(
//                 child: Text(
//                   "your Booking Will Expired in 60 minutes so be on location on time.",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: "poppins",
//                       fontWeight: FontWeight.w600,
//                       color: blackTheme),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Center(
//                 child: Text(
//                   "Thank you!",
//                   style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: "poppins",
//                       fontWeight: FontWeight.w600,
//                       color: Colors.green),
//                 ),
//               )
//             ]),
//           ),
//           actions: const <Widget>[],
//         );
//       },
//     );
//   }

  //Extracted from string bill and get percentage and calculate totall bill
  void extractDiscount() {
    totalbill = widget.amount;
    if (matchCode == "BTOFF30" || matchCode == "BTOFF50") {
      ismatch = true;
      extracted = matchCode!.replaceAll(RegExp(r'[^0-9]'), '');
      var parseExt = int.parse(extracted);
      var percent = (parseExt / 100) * totalbill!;
      afterDisc = totalbill! - percent.round();
    } else {
      ismatch = false;
    }
  }
}
