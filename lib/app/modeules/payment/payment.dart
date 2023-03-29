import 'dart:developer';
import 'dart:io';

import 'package:boat/app/global_widgets/back_arrow.dart';
import 'package:boat/app/global_widgets/reuseable_button.dart';
import 'package:boat/app/modeules/booking_boat/thankyou_screen.dart';
import 'package:boat/app/modeules/payment/widgets/reuseable_widget2.dart';
import 'package:boat/app/modeules/settings/widgets/divider.dart';
import 'package:boat/app/themes/AppAssets.dart';
import 'package:boat/app/themes/AppColors.dart';
import ''
    'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkApms.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../services/fcm_services.dart';
import '../../bottomapp.dart';

import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokenFormat.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTokeniseType.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_paytabs_bridge/IOSThemeConfiguration.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkTransactionClass.dart';

import '../../bottomapp.dart';

class Payment_screen extends StatefulWidget {
  Payment_screen(
      {this.total_amount,
      this.i,
      this.documnet_id,
      this.start_time,
      this.token_for_completetheorder,
      this.boat_name});
  var total_amount;
  var documnet_id;
  var start_time;
  var token_for_completetheorder;
  var boat_name;
  int? i;
  State<Payment_screen> createState() => _Payment_screenState();
}

class _Payment_screenState extends State<Payment_screen> {
  bool isChecked = false;
  String serverKey = 'SDJN2N6DHK-JDWH2DR9ZH-6D2BDGHNMG';
  String clientKey = 'CNKMQD-9MTT6D-VHMDRP-2HBR7N';
  var amount = 100.0;

  PaymentSdkConfigurationDetails generateConfig() {
    List<PaymentSdkAPms> apms = [];
    apms.add(PaymentSdkAPms.STC_PAY);
    var configuration = PaymentSdkConfigurationDetails(
      profileId: "91081",
      serverKey: serverKey,
      clientKey: clientKey,
      cartId: "12433",
      cartDescription: "Flowers",
      merchantName: "Kashmal ali",
      screentTitle: "Pay with Card",
      amount: double.parse(widget.total_amount.toString()),
      showBillingInfo: true,
      forceShippingInfo: false,
      currencyCode: "SAR",
      merchantCountryCode: "SA",
      alternativePaymentMethods: apms,
    );
    return configuration;
  }

  Future<void> payPressed() async {
    FlutterPaytabsBridge.startCardPayment(
      generateConfig(),
      (event) {
        setState(
          () {
            if (event["status"] == "success") {
              Navigator.pop(context);
              var transactionDetails = event["data"];
              log(transactionDetails);
            } else if (event["status"] == "error") {
              // Handle error here.
            } else if (event["status"] == "event") {
              // Handle events here.
            }
          },
        );
      },
    );
  }

  int i = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> applePayPressed() async {
    var configuration = PaymentSdkConfigurationDetails(
        profileId: "91081",
        serverKey: serverKey,
        clientKey: clientKey,
        cartId: "1243389",
        cartDescription: "Flowers",
        merchantName: "Flowers Store",
        amount: 22.0, //widget.total_amount,
        currencyCode: "SAR",
        merchantCountryCode: "sa",
        merchantApplePayIndentifier: "merchant.abher.com",
        simplifyApplePayValidation: true);

    FlutterPaytabsBridge.startApplePayPayment(configuration, (event) {
      setState(() {
        if (event["status"] == "success") {
          // Handle transaction details here.
          var transactionDetails = event["data"];
          Navigator.pop(context);
          log(transactionDetails.toString());
        } else if (event["status"] == "error") {
          log(event.toString());
        } else if (event["status"] == "event") {
          // Handle events here.
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Back_arrow(
                        AppColors.black_type,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(Home());
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: AppColors.black_type,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                const Text(
                  "Payment",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 23,
                      color: AppColors.black_type),
                ),
                SizedBox(
                  height: 29,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Platform.isIOS
                          ? Expanded(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.white_type),
                                ),
                                onPressed: () {
                                  setState(() {
                                    i = 1;
                                  });
                                  applePayPressed();
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 11),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/logo_apple.svg")
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.Sdark_blue),
                          ),
                          onPressed: () {
                            setState(() {
                              i = 1;
                            });
                            payPressed();
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pay with Card",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.white_type,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Re_useable_widget2("Card Holder’s Name", "Banu Elson"),
                      SizedBox(
                        height: 10,
                      ),
                      Re_useable_widget2("Card Number", "5470 0004 0003 0002"),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Expire Date",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_type),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(child: Re_useable_widget2("Month", "12")),
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(child: Re_useable_widget2("Year", "25")),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, right: 122, bottom: 19),
                        child: Re_useable_widget2("Security Code", "574"),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            //  fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,

                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Text(
                            "Remember my card  for \n next purchases.",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.black_type),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount to Pay",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black_type),
                      ),
                      Text(
                        "\$${widget.total_amount}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_type),
                      )
                    ],
                  ),
                ),
                Divider_con(),
                SizedBox(
                  height: 24,
                ),
                Reuseable_button(
                    "Pay Now", AppColors.Sdark_blue, Appassets.icon_search1,
                    () {
                  FcmPushNotiService.fetchFcmDetail(
                    message:
                        'Please Complete the Order which boat name is ${widget.boat_name} and '
                        'Price is ${widget.total_amount} start time is ${widget.start_time} :00',
                    friendFcmToken: widget.token_for_completetheorder,
                    title: widget.boat_name,
                  );

                  Get.to(Thankyou_screen(
                    index: widget.i,
                    doc_id: widget.documnet_id,
                  ));
                }),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
