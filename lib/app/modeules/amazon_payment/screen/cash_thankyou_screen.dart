import 'package:boat/app/bottomapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../custome_widged/custom_button.dart';
import '../utils/assets.dart';
import '../utils/colors.dart';
import '../utils/strings.dart';

class CashThankYouScreen extends StatefulWidget {
  CashThankYouScreen({Key? key, this.cid}) : super(key: key);
  String? cid;
  @override
  State<CashThankYouScreen> createState() => _CashThankYouScreenState();
}

class _CashThankYouScreenState extends State<CashThankYouScreen> {
  // const ThankYouScreen({super.key});
  get editingController => null;

  String? id = "";
  final firestore = FirebaseFirestore.instance.collection("bookingRequestSend");

  @override
  void initState() {
    print("collecion id ${widget.cid}");

    firestore.doc(widget.cid).update({'paymethod': "cash"});
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
                Center(
                  child: Text(
                    "your Booking hasb been confirmed with cash payment based. For any avoiding inconvenience be on time otherwise your booking will be cancelled automatically.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      color: black6Color.withOpacity(.44),
                    ),
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
