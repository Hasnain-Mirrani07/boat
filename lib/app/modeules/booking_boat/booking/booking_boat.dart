import 'dart:developer';

import 'package:boat/app/bottomapp.dart';
import 'package:boat/app/modeules/booking_boat/booking/controller.dart';
import 'package:boat/app/modeules/booking_boat/widget/boat_expenses.dart';
import 'package:boat/app/themes/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../global_widgets/back_arrow.dart';
import '../../../global_widgets/divider.dart';
import '../../../global_widgets/reuseable_button.dart';
import '../../../models/boat_data.dart';
import '../../../models/start_rating.dart';
import '../../../themes/AppAssets.dart';
import '../../../themes/styles/textstyle.dart';
import '../../home_page/controller/controller.dart';

class Booking_boat extends StatefulWidget {
  Booking_boat({required this.uid, required this.bname, required this.bimg, required this.index, this.document_id});

  var uid;
  var bname;
  var bimg;
  int index;
  String? document_id;

  @override
  State<Booking_boat> createState() => _Booking_boatState();
}

class _Booking_boatState extends State<Booking_boat> {
  var sender_token;

  Future<void> getdata() async {
    FirebaseFirestore.instance.collection('Users').doc(_auth.currentUser!.uid).get().then((querySnapshot) {
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
  var uuid = Uuid();
  var load = true;
  Future<List<Boat_data>>? employeeList;
  List<Boat_data>? retrievedEmployeeList;

  Future<void> _initRetrieval() async {
    GetData service = GetData();

    employeeList = service.retrieveEmployees();
    retrievedEmployeeList = await service.retrieveEmployees();
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _initRetrieval();
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        load = false;
      }); // Prints after 1 second.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load == false
          ? FutureBuilder(
              future: employeeList,
              builder: (context, snapshot) {
                return ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 26),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Back_arrow(Colors.grey)),
                              GestureDetector(
                                onTap: () {
                                  Get.to(Home());
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.black_type),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "${retrievedEmployeeList![widget.index].image}",
                                        width: 72,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${retrievedEmployeeList![widget.index].boatname}",
                                      style: AppTextStyles.kPrimaryS5W4,
                                    ),
                                    Text(
                                      retrievedEmployeeList![widget.index].overview!.substring(0, 12),
                                      style: AppTextStyles.kPrimaryS7W4,
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    StarRating(
                                      rating: retrievedEmployeeList![widget.index].total_rating,
                                    )
                                  ],
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
                            text: TextSpan(text: 'Boating Availability  ', style: AppTextStyles.kPrimaryS12W3, children: <TextSpan>[
                              TextSpan(
                                text: DateFormat('(MMMM, yyyy)').format(currentMonthDate),
                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: AppColors.black_type),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
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
                              retrievedEmployeeList![widget.index].mon == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text("${retrievedEmployeeList![widget.index].mon}", style: AppTextStyles.weeks),
                              retrievedEmployeeList![widget.index].mon == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedEmployeeList![widget.index].tue == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedEmployeeList![widget.index].tue}",
                                      style: AppTextStyles.weeks,
                                    ),
                              retrievedEmployeeList![widget.index].tue == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedEmployeeList![widget.index].wed == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedEmployeeList![widget.index].wed}",
                                      style: AppTextStyles.weeks,
                                    ),
                              retrievedEmployeeList![widget.index].wed == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedEmployeeList![widget.index].thu == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedEmployeeList![widget.index].thu}",
                                      style: AppTextStyles.weeks,
                                    ),
                              retrievedEmployeeList![widget.index].thu == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedEmployeeList![widget.index].fri == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text("${retrievedEmployeeList![widget.index].fri}", style: AppTextStyles.weeks),
                              retrievedEmployeeList![widget.index].fri == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedEmployeeList![widget.index].sat == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text("${retrievedEmployeeList![widget.index].sat}", style: AppTextStyles.weeks),
                              retrievedEmployeeList![widget.index].sat == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedEmployeeList![widget.index].sun == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text("${retrievedEmployeeList![widget.index].sun}", style: AppTextStyles.weeks),
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

                          inactiveColor: Color(0xffF4F5F7),
                          activeColor: AppColors.Sdark_blue,
                          // labels: RangeLabels(
                          //   _currentRangeValues.start.round().toString(),
                          //   _currentRangeValues.end.round().toString(),
                          // ),
                          onChanged: (value) {
                            setState(() {
                              start = value.start.toDouble();
                              end = value.end.toDouble();
                              i = hours = end!.toInt() - start!.toInt();
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
                                style: TextStyle(color: AppColors.black_type, fontSize: 11, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                "End Time",
                                style: TextStyle(color: AppColors.black_type, fontSize: 11, fontWeight: FontWeight.w400),
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
                                "${retrievedEmployeeList![widget.index].boat_start}:00",
                                style: TextStyle(color: AppColors.black_type, fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${retrievedEmployeeList![widget.index].boat_end}:00",
                                style: TextStyle(color: AppColors.black_type, fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Divider_con(),
                        SizedBox(
                          height: 14,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Total Expenses",
                            style: AppTextStyles.kPrimaryS7W5,
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Boat_Expenses(
                            "Hours Per Day",
                            hours == null ? "12 hours" : "$hours hours",
                          ),
                        ),
                        Divider_con(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Boat_Expenses("Amount Paid",
                              "\$${hours == null ? retrievedEmployeeList![widget.index].boatprice : hours *= int.parse(retrievedEmployeeList![widget.index].boatprice.toString())}"),
                        ),
                        Divider_con(),
                        SizedBox(
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
                        SizedBox(
                          height: 19,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Reuseable_button("Send Request", AppColors.Sdark_blue, Appassets.icon_search1, () async {



                            if (i == null || i == 0) {
                              Fluttertoast.showToast(
                                  msg: "Please decide hours",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM_LEFT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {

                              var g = i *= int.parse(retrievedEmployeeList![widget.index].boatprice.toString());
                              Get.to(Home());
                              var dh = end!.toInt() - start!.toInt();
                              log('$dh');
                              log('$g');
                              booking_con.send_request(
                                documnet_idforeview: widget.document_id,
                                sender_token: sender_token,
                                token: retrievedEmployeeList![widget.index].token,
                                sender_uid: _auth.currentUser!.uid,
                                uid: widget.uid,
                                boatname: widget.bname,
                                boatimage: widget.bimg,
                                hoursperday: dh,
                                uuid: uuid.v4(),
                                total_amount: g,
                                start_time: retrievedEmployeeList![widget.index].boat_start,
                                end_time: retrievedEmployeeList![widget.index].boat_end,
                                overview: retrievedEmployeeList![widget.index].overview,
                              );

                             Fluttertoast.showToast(
                                 msg: "Request sent",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.BOTTOM_LEFT,
                                 timeInSecForIosWeb: 1,
                                 backgroundColor: Colors.black,
                                 textColor: Colors.white,
                                 fontSize: 16.0);
                            }
                          }),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                );
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}