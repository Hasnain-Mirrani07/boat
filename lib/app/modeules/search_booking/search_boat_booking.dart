import 'dart:developer';

import 'package:boat/app/bottomapp.dart';
import 'package:boat/app/modeules/booking_boat/booking/controller.dart';
import 'package:boat/app/modeules/booking_boat/widget/boat_expenses.dart';
import 'package:boat/app/modeules/payment/payment.dart';
import 'package:boat/app/themes/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../global_widgets/back_arrow.dart';
import '../../global_widgets/divider.dart';
import '../../global_widgets/reuseable_button.dart';
import '../../models/boat_data.dart';
import '../../models/start_rating.dart';
import '../../themes/AppAssets.dart';
import '../../themes/styles/textstyle.dart';
import '../home_page/controller/controller.dart';



class SearchBooking_boat extends StatefulWidget {
  SearchBooking_boat(
      {required this.uid,
        required this.bname,
        required this.bimg,
        this.document_id});
  var uid;
  var bname;
  var bimg;
  String? document_id;
  @override
  State<SearchBooking_boat> createState() => _SearchBooking_boatState();
}

class _SearchBooking_boatState extends State<SearchBooking_boat> {
  var sender_token;
  Future<void> getdata() async {
    FirebaseFirestore.instance
        .collection('Users').doc(_auth.currentUser!.uid
    )
        .get()
        .then((querySnapshot) {
      querySnapshot(result) {
        sender_token = result["token"];
      }
    });

  }
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final con = Get.put(GetData());
  final booking_con = Get.put(Booking_controller());
  DateTime currentMonthDate = DateTime.now();
  double? start = 4;
  double? end = 16;
  var hours;
  var price;
  var i;
  var uuid = const Uuid();
  var load=true;

  var total_Pay;
  @override
  void initState() {
    // TODO: implement initState


    Future.delayed(const Duration(seconds: 2), () {
      setState((){
        load=false;
      }); // Prints after 1 second.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load==false?FutureBuilder(
          future:FirebaseFirestore.instance
              .collection('boats')
              .doc(widget.document_id)
              .get(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot){
           Map<String, dynamic> data =
                snapshot.data?.data() as Map<String, dynamic>;

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            if (!snapshot.hasData || snapshot.data == null ) {
              const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                  ));
            }


            return  ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Back_arrow(Colors.grey)),
                          GestureDetector(
                            onTap: (){
                              Get.to(Home());

                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_type),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    "${data['img1']}",
                                    width: 72,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data['boat_namae']}",
                                  style: AppTextStyles.kPrimaryS5W4,
                                ),
                                Text(
                                  data['overview'].substring(0,12),
                                  style: AppTextStyles.kPrimaryS7W4,
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                StarRating(
                                  rating: data['total_rating'],
                                )                                  ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: RichText(
                        text: TextSpan(
                            text: 'Boating Availability  ',
                            style: AppTextStyles.kPrimaryS12W3,
                            children: <TextSpan>[
                              TextSpan(
                                text: DateFormat('(MMMM, yyyy)')
                                    .format(currentMonthDate),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: AppColors.black_type),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 27.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 19,
                          ),
                          data['monday'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                              "${data['monday'] }",
                              style: AppTextStyles.weeks),
                          data['monday']  == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : const SizedBox(
                            height: 11,
                          ),
                          data['tuesday']  == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                            "${ data['tuesday']}",
                            style: AppTextStyles.weeks,
                          ),
                          data['tuesday'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : const SizedBox(
                            height: 11,
                          ),
                          data['wed'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                            "${ data['wed'] }",
                            style: AppTextStyles.weeks,
                          ),
                          data['wed']  == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : const SizedBox(
                            height: 11,
                          ),
                          data['thu']  == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                            "${ data['thu']}",
                            style: AppTextStyles.weeks,
                          ),
                          data['thu'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : const SizedBox(
                            height: 11,
                          ),
                          data['fri'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                              "${data['fri']}",
                              style: AppTextStyles.weeks),
                          data['fri'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : const SizedBox(
                            height: 11,
                          ),
                          data['sat'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                              "${ data['sat']}",
                              style: AppTextStyles.weeks),
                          data['sat'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : const SizedBox(
                            height: 11,
                          ),
                          data['sun'] == null
                              ? const SizedBox(
                            height: 0,
                          )
                              : Text(
                              "${data['sun']}",
                              style: AppTextStyles.weeks),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Boating Duration",
                        style: AppTextStyles.kPrimaryS7W5,
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${start!.toStringAsFixed(0)}:00",
                            style: AppTextStyles.kPrimaryS11W2,
                          ),
                          Text(
                            "${end!.toStringAsFixed(0)}:00",
                            style: AppTextStyles.kPrimaryS11W2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    RangeSlider(
                      min: 0,
                      values: RangeValues(start!, end!),
                      max: 24,

                      inactiveColor: const Color(0xffF4F5F7),
                      activeColor: AppColors.Sdark_blue,
                      // labels: RangeLabels(
                      //   _currentRangeValues.start.round().toString(),
                      //   _currentRangeValues.end.round().toString(),
                      // ),
                      onChanged: (value) {
                        setState(() {
                          start = value.start.toDouble();
                          end = value.end.toDouble();
                          i=   hours = end!.toInt() - start!.toInt();
                         total_Pay = hours*= int.parse( data['boat_price'] .toString());
                        });
                      },
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Start Time",
                            style: TextStyle(
                                color: AppColors.black_type,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "End Time",
                            style: TextStyle(
                                color: AppColors.black_type,
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 21.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${data['boating_duration_start']}:00",
                            style: const TextStyle(
                                color: AppColors.black_type,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "${data['boating_duration_end']}:00",
                            style: const TextStyle(
                                color: AppColors.black_type,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Divider_con(),
                    const SizedBox(
                      height: 14,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Total Expenses",
                        style: AppTextStyles.kPrimaryS7W5,
                      ),
                    ),
                    const SizedBox(
                      height: 23,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Boat_Expenses(
                        "Hours Per Day",
                        hours == null ? "12 hours" : "$i hours",
                      ),
                    ),
                    Divider_con(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Boat_Expenses("Amount Paid",
                          "\$${hours==null ? data['boat_price'] : total_Pay}"),
                    ),
                    Divider_con(),
                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Terms & Conditions",
                        style: AppTextStyles.kPrimaryS9W6,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Cras quis nulla commodo, aliquam lectus sed, blandit augue. Cras ullamcorper bibendum bibendum. Duis tincidunt urna non pretium porta. Nam condimentum vitae ligula vel ornare.aliquam lectus sed, blandit augue. Cras ullamcorper.",
                        style: AppTextStyles.Klight,
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Reuseable_button("Send Request",
                          AppColors.Sdark_blue, Appassets.icon_search1, () {
                            if (i == null ) {
                              Fluttertoast.showToast(
                                  msg: "Please decide hours",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM_LEFT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                              }else {
                                var g =  i *= int.parse( data['boat_price'] .toString());
                                Get.to(Home());
                                var dh=end!.toInt() - start!.toInt();
                                log('$dh');
                                log('$g');
                                booking_con.send_request(
                                  documnet_idforeview:widget.document_id ,
                                  sender_token: sender_token,
                                  token:  data['token'] ,
                                  sender_uid: _auth.currentUser!.uid,
                                  uid: widget.uid,
                                  boatname: widget.bname,
                                  boatimage: widget.bimg,
                                  hoursperday: dh,
                                  uuid: uuid.v4(),
                                  total_amount: g,
                                  start_time:   data['boating_duration_start'] ,
                                  end_time:data['boating_duration_end'],

                                  overview:data['overview'],
                                );
                              }
                            }
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ],
            );
          }):Center(child: CircularProgressIndicator()),
    );
  }
}
