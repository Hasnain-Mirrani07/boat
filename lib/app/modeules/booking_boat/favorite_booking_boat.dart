import 'dart:developer';

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

import '../../../singaltonClass.dart';
import '../../global_widgets/back_arrow.dart';
import '../../global_widgets/divider.dart';
import '../../global_widgets/reuseable_button.dart';
import '../../models/favorites_model.dart';
import '../../models/start_rating.dart';
import '../../themes/AppAssets.dart';
import '../../themes/styles/textstyle.dart';
import '../bookings and favorites/booking_page.dart';
import '../home_page/controller/controller.dart';

class Favorite_Booking_Boat extends StatefulWidget {
  Favorite_Booking_Boat(
      {Key? key,
      required this.uid,
      this.bname,
      required this.bimg,
      required this.index,
      this.totalrating,
      this.doc_id})
      : super(key: key);
  var uid;
  var bname;
  var bimg;
  int index;
  var oldvalue;
  var totalrating;
  var doc_id;

  @override
  State<Favorite_Booking_Boat> createState() => _Favorite_Booking_BoatState();
}

class _Favorite_Booking_BoatState extends State<Favorite_Booking_Boat> {
  final con = Get.put(GetData());
  final booking_con = Get.put(Booking_controller());
  DateTime currentMonthDate = DateTime.now();
  double? start = 4;
  double? end = 16;
  var hours;
  var price;
  var hoursPerDay;
  var totalAmount;

  GetData service1 = GetData();

  Future<List<Favorites_Boat_data>>? favList;
  List<Favorites_Boat_data>? retrievedfavList;
  Future<void> _favlists() async {
    favList = service1.retrievefavoritesBoatdata();
    retrievedfavList = await service1.retrievefavoritesBoatdata();
  }

  var uuid = const Uuid();
  var load = true;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _favlists();
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        load = false;
      }); // Prints after 1 second.
    });
    super.initState();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var i;
  var startTime;
  var endTime;
  //firestore firebase initialize
  final firestore = FirebaseFirestore.instance.collection("bookingRequestSend");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load == false
          ? FutureBuilder(
              future: favList,
              builder: (context, snapshot) {
                return ListView(
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
                              Text(
                                "Cancel ${retrievedfavList![widget.index].owneruid}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_type),
                              )
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${retrievedfavList![widget.index].fimage}",
                                      width: 72,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${retrievedfavList![widget.index].fboatname}",
                                    style: AppTextStyles.kPrimaryS5W4,
                                  ),
                                  Text(
                                    retrievedfavList![widget.index]
                                        .foverview!
                                        .substring(0, 12),
                                    style: AppTextStyles.kPrimaryS7W4,
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  StarRating(
                                    rating: widget.totalrating,
                                  ),
                                ],
                              ),
                            ],
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
                              retrievedfavList![widget.index].fmon == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].fmon}",
                                      style: AppTextStyles.weeks),
                              retrievedfavList![widget.index].fmon == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedfavList![widget.index].ftue == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].ftue}",
                                      style: AppTextStyles.weeks,
                                    ),
                              retrievedfavList![widget.index].ftue == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedfavList![widget.index].fwed == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].fwed}",
                                      style: AppTextStyles.weeks,
                                    ),
                              retrievedfavList![widget.index].fwed == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedfavList![widget.index].fthu == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].fthu}",
                                      style: AppTextStyles.weeks,
                                    ),
                              retrievedfavList![widget.index].fthu == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedfavList![widget.index].ffri == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].ffri}",
                                      style: AppTextStyles.weeks),
                              retrievedfavList![widget.index].ffri == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedfavList![widget.index].fsat == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].fsat}",
                                      style: AppTextStyles.weeks),
                              retrievedfavList![widget.index].fsat == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : const SizedBox(
                                      height: 11,
                                    ),
                              retrievedfavList![widget.index].fsun == null
                                  ? const SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "${retrievedfavList![widget.index].fsun}",
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
                                "${retrievedfavList![widget.index].fstart}:00",
                                style: const TextStyle(
                                    color: AppColors.black_type,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${retrievedfavList![widget.index].fend}:00",
                                style: const TextStyle(
                                    color: AppColors.black_type,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const Divider_con(),
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
                          child: Boat_Expenses("Hours Per Day",
                              hours == null ? "12 hours" : "$hours hours"),
                        ),
                        const Divider_con(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Boat_Expenses("Amount Paid",
                              "\$${hours != null ? hours *= int.parse(retrievedfavList![widget.index].fboatprice.toString()) : retrievedfavList![widget.index].fboatprice}"),
                        ),
                        const Divider_con(),
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
                            totalAmount = hours *= int.parse(
                                retrievedfavList![widget.index]
                                    .fboatprice
                                    .toString());
                            print(
                                "hrs $hours ---before-----------  amount $totalAmount");
                            var g = i *= int.parse(
                                retrievedfavList![widget.index]
                                    .fboatprice
                                    .toString());
                            var dh = end!.toInt() - start!.toInt();
                            hoursPerDay = dh;

                            startTime = "${start!.toStringAsFixed(0)}:00";
                            endTime = "${end!.toStringAsFixed(0)}:00";
                            try {
                              String id = DateTime.now().millisecond.toString();
                              //  debugPrint('press');
                              //*****------request Store in Firestore---------*********/
                              print(
                                  "img  ${DateFormat('(dd, MMMM, yyyy)').format(currentMonthDate)}=${widget.bimg}=${retrievedfavList![widget.index].fstart} =${retrievedfavList![widget.index].fend}}");

                              var date = DateFormat('dd, MMMM, yyyy')
                                  .format(currentMonthDate);
                              firestore.doc(id).set({
                                'id': id,
                                'uid': retrievedfavList![widget.index].uid,
                                'hours': dh,
                                'price': g,
                                'request': "pending",
                                'boatname':
                                    retrievedfavList![widget.index].fboatname,
                                'senderuid': SessionController().userId,
                                'imgurl':
                                    retrievedfavList![widget.index].fimage,
                                'starttime': startTime!,
                                'endtime': endTime!,
                                'date': date,
                                'owneruid': SessionControllerOwner().owneruid,
                                'paymethod': ""
                              }).then((value) {
                                //  ReUse().loginErrorToast("Data Added Succfully");
                                Get.to(Booking_page(id));
                                setState(() {});
                              });
                            } catch (e) {
                              debugPrint(e.toString());
                              Text(e.toString());
                              print("data store Fail amount ");
                              //  ReUse().loginErrorToast(e.toString());
                              setState(() {});
                            }
                            hoursPerDay = 0;
                            totalAmount = null;
                            setState(() {});
//*****---------------*********/
                            if (i == null) {
                              Fluttertoast.showToast(
                                  msg: "Please decide hours",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM_LEFT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              log(i.toString());
                            } else {
                              var g = i *= int.parse(
                                  retrievedfavList![widget.index]
                                      .fboatprice
                                      .toString());
                              var dh = end!.toInt() - start!.toInt();
                              hoursPerDay = dh;
                              log(i.toString());
                              //    Get.to(Home());

                              log('$g');
                              booking_con.send_request(
                                documnet_idforeview: widget.doc_id,
                                uid: widget.uid,
                                boatname: widget.bname,
                                boatimage: widget.bimg,
                                overview:
                                    retrievedfavList![widget.index].foverview,
                                hoursperday: dh,
                                uuid: uuid.v4(),
                                total_amount: g,
                                start_time:
                                    retrievedfavList![widget.index].fstart,
                                end_time: retrievedfavList![widget.index].fend,
                                token: retrievedfavList![widget.index].token,
                              );
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ],
                );
              })
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
