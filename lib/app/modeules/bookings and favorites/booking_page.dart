import 'dart:developer';

import 'package:boat/app/models/bookings_boats.dart';
import 'package:boat/app/modeules/bookings%20and%20favorites/controller/booking_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../singaltonClass.dart';
import '../../themes/AppColors.dart';
import '../../themes/styles/textstyle.dart';
import '../amazon_payment/screen/home_screen.dart';

class Booking_page extends StatefulWidget {
  Booking_page(this.uid, {Key? key}) : super(key: key);

  String? uid;

  @override
  State<Booking_page> createState() => _Booking_pageState();
}

class _Booking_pageState extends State<Booking_page> {
  @override
  Booking_request_controller service = Booking_request_controller();
  Future<List<Booking_Boats>>? boatsList;
  List<Booking_Boats>? retrievedboatsList;

  Future<void> _initRetrieval() async {
    boatsList = service.retrievebookingBoatdata();
    retrievedboatsList = await service.retrievebookingBoatdata();
  }

  final firestore = FirebaseFirestore.instance.collection("bookingRequestSend");

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final con = Get.put(Booking_request_controller());
  var load = true;
  String? userUid = '';
  @override
  void initState() {
    SessionController().userId = _auth.currentUser!.uid;
    _initRetrieval();

    log(widget.uid.toString());
    super.initState();
  }

  var collectionid;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final databaseRef = FirebaseFirestore.instance
      .collection("bookingRequestSend")
      .where('senderuid', isEqualTo: SessionController().userId)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Listener(
                    onPointerDown: (event) => Get.back(),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Go Back",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 32),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text("text18".tr, style: AppTextStyles.ktitle)),
              StreamBuilder<QuerySnapshot>(
                stream: databaseRef,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return const Text('FireStore fddrgdg DAta Load Errorr');
                  } else {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final String cid =
                            snapshot.data!.docs[index]['id'] ?? "".toString();
                        collectionid = cid;
                        var hrs = snapshot.data!.docs[index]['hours'] ??
                            "".toString();
                        var price = snapshot.data!.docs[index]['price'] ??
                            "".toString();
                        var request = snapshot.data!.docs[index]['request'] ??
                            "".toString();
                        var date =
                            snapshot.data!.docs[index]['date'] ?? "".toString();
                        var imgurl = snapshot.data!.docs[index]['imgurl'] ??
                            "".toString();

                        var startTime = snapshot.data!.docs[index]
                                ['starttime'] ??
                            "".toString();
                        var endTime = snapshot.data!.docs[index]['endtime'] ??
                            "".toString();
                        var boatName = snapshot.data!.docs[index]['boatname'] ??
                            "".toString();
                        var paymentmethod = snapshot.data!.docs[index]
                                ['paymethod'] ??
                            "".toString();
                        var paymentverify = snapshot.data!.docs[index]
                                ['paymentverify'] ??
                            "".toString();
                        return request == "accept"
                            ? GestureDetector(
                                onTap: () async {
                                  print("collecion $collectionid ");
                                  SharedPreferences pref =
                                      await SharedPreferences.getInstance();
                                  pref.setString("collectionId", cid);
                                  Get.to(HomeScreen(
                                    id: cid,
                                    amount: price,
                                  ));
                                },
                                child: Card(
                                  elevation: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 25),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Container(
                                                  height: 90.h,
                                                  width: 90.w,
                                                  color: Colors.green,
                                                  child: Image.network(
                                                    imgurl,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                //
                                                // Image.network(
                                                //           "${retrievedboatsList?[index].image}",
                                                //           width: 76,
                                                //           height: 80,
                                                //           fit: BoxFit.cover),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Booking ID: $cid",
                                                      style: const TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 11),
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment
                                                    //           .spaceBetween,
                                                    //   children: const [
                                                    //     Text(
                                                    //       "View Details",
                                                    //       style: TextStyle(
                                                    //           color: Colors.white,
                                                    //           fontWeight:
                                                    //               FontWeight.w600,
                                                    //           fontSize: 11),
                                                    //     ),
                                                    //     Icon(
                                                    //         Icons
                                                    //             .arrow_forward_ios_outlined,
                                                    //         color: Colors.white,
                                                    //         size: 15)
                                                    //   ],
                                                    // ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Text("$boatName",
                                                    style: AppTextStyles.h1),
                                                const SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      " $startTime to $endTime ",
                                                      style: AppTextStyles
                                                          .kPrimaryS7W4,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 60.w),
                                                      child: Text(
                                                        date,
                                                        style: AppTextStyles
                                                            .kPrimaryS7W4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                //   const SizedBox(height: 2),
                                                const SizedBox(height: 5),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.7,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            size: 15,
                                                            color: request ==
                                                                    "accept"
                                                                ? Colors.green
                                                                : AppColors
                                                                    .Sdark_blue,
                                                          ),
                                                          SizedBox(
                                                            width: 3.w,
                                                          ),
                                                          Text(
                                                            "Booked",
                                                            style: TextStyle(
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .Sdark_blue),
                                                          )
                                                        ],
                                                      ),
                                                      request == "accept"
                                                          ? Listener(
                                                              onPointerDown:
                                                                  (event) => Get.to(
                                                                      HomeScreen(
                                                                amount: price,
                                                              )),
                                                              child: const Text(
                                                                  "Requested Accepted",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .green)),
                                                            )
                                                          : const Text(
                                                              "Pendding",
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .red))
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                paymentmethod == "cash"
                                                    ? Row(
                                                        children: [
                                                          paymentverify ==
                                                                  "verify"
                                                              ? Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Verified",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: Colors.green)),
                                                                    SizedBox(
                                                                      width:
                                                                          2.w,
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .green,
                                                                      size:
                                                                          18.h,
                                                                    )
                                                                  ],
                                                                )
                                                              : const Text(
                                                                  "UnVerified",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .red)),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          Text(
                                                              "Cash Payment \$$price",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .blue)),
                                                        ],
                                                      )
                                                    : Text("UnPaid \$$price",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.blue)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 34, right: 24),
                                            width: double.infinity,
                                            height: 1,
                                            color: Colors.white)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 25),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(7.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Container(
                                                height: 90.h,
                                                width: 90.w,
                                                color: Colors.green,
                                                child: Image.network(
                                                  imgurl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              //
                                              // Image.network(
                                              //           "${retrievedboatsList?[index].image}",
                                              //           width: 76,
                                              //           height: 80,
                                              //           fit: BoxFit.cover),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Booking ID: $cid",
                                                    style: const TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11),
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment
                                                  //           .spaceBetween,
                                                  //   children: const [
                                                  //     Text(
                                                  //       "View Details",
                                                  //       style: TextStyle(
                                                  //           color: Colors.white,
                                                  //           fontWeight:
                                                  //               FontWeight.w600,
                                                  //           fontSize: 11),
                                                  //     ),
                                                  //     Icon(
                                                  //         Icons
                                                  //             .arrow_forward_ios_outlined,
                                                  //         color: Colors.white,
                                                  //         size: 15)
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 7.h,
                                              ),
                                              Text("$boatName",
                                                  style: AppTextStyles.h1),
                                              const SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    " $startTime to $endTime ",
                                                    style: AppTextStyles
                                                        .kPrimaryS7W4,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 60.w),
                                                    child: Text(
                                                      date,
                                                      style: AppTextStyles
                                                          .kPrimaryS7W4,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              //   const SizedBox(height: 2),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.7,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          size: 15,
                                                          color: request ==
                                                                  "accept"
                                                              ? Colors.green
                                                              : AppColors
                                                                  .Sdark_blue,
                                                        ),
                                                        SizedBox(
                                                          width: 3.w,
                                                        ),
                                                        Text(
                                                          "Booked",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .Sdark_blue),
                                                        )
                                                      ],
                                                    ),
                                                    request == "pending"
                                                        ? Listener(
                                                            onPointerDown:
                                                                (event) => Get.to(
                                                                    HomeScreen(
                                                              amount: price,
                                                            )),
                                                            child: const Text(
                                                                "Request Pendding",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .red)),
                                                          )
                                                        : const Text(
                                                            "Request Cancel",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors.red))
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 50,
                                                ),
                                                child: Text("Unpaid \$$price",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.blue)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                          margin: const EdgeInsets.only(
                                              left: 34, right: 24),
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.white)
                                    ],
                                  ),
                                ),
                              );

                        // Card(
                        //     child: ListTile(
                        //   leading: Image.asset(
                        //     mastercardIcon,
                        //     height: 30,
                        //     width: 50,
                        //   ),
                        //   title: Text(" $hrs"),
                        //   subtitle: Text(price.toString()),
                        //   trailing: Text(snapshot.data!.docs[index]['request']),
                        // ));
                      },
                    ));
                  }
                },
              ),

// alread**********************************************

              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: ElevatedButton(
              //       onPressed: () {
              //         setState(() {});
              //       },
              //       child: const Text("Refresh")),
              // ),
              // Expanded(
              //   child: FutureBuilder<List<Booking_Boats>>(
              //       future: boatsList,
              //       initialData: const [],
              //       builder: (BuildContext context, snapshot) {
              //         if (snapshot.data == null) {
              //           return Center(
              //               child: Image.asset('assets/no_results.png',
              //                   width: 112, height: 112));
              //         }
              //         if (snapshot.data?.isEmpty ?? true) {
              //           return Center(
              //             child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Image.asset('assets/no_results.png',
              //                       width: 112, height: 112),
              //                   const SizedBox(height: 15),
              //                   GestureDetector(
              //                       onTap: () {},
              //                       child: const Text("No Boats",
              //                           style: TextStyle(
              //                               color: Colors.blue, fontSize: 16)))
              //                 ]),
              //           );
              //         }
              //         if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              //           return ListView.separated(
              //               scrollDirection: Axis.vertical,
              //               itemCount: retrievedboatsList!.length,
              //               separatorBuilder: (context, index) =>
              //                   const SizedBox(height: 16),
              //               itemBuilder: (context, index) {
              //                 return Padding(
              //                   padding: const EdgeInsets.only(left: 16.0),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       const SizedBox(height: 25),
              //                       Row(
              //                         children: [
              //                           GestureDetector(
              //                             onTap: retrievedboatsList?[index]
              //                                         .booking_status ==
              //                                     '● Booked'
              //                                 ? () {
              //                                     debugPrint(
              //                                         retrievedboatsList?[index]
              //                                             .ratings);
              //                                     Get.to(Payment_screen(
              //                                       boat_name:
              //                                           retrievedboatsList?[
              //                                                   index]
              //                                               .boat_name,
              //                                       token_for_completetheorder:
              //                                           retrievedboatsList?[
              //                                                   index]
              //                                               .tokenforcompletation,
              //                                       start_time:
              //                                           retrievedboatsList?[
              //                                                   index]
              //                                               .start_time,
              //                                       total_amount:
              //                                           retrievedboatsList?[
              //                                                   index]
              //                                               .total_amount,
              //                                       i: index,
              //                                       documnet_id:
              //                                           retrievedboatsList?[
              //                                                   index]
              //                                               .ratings,
              //                                     ));
              //                                   }
              //                                 : () {
              //                                     con.getdata(
              //                                         retrievedboatsList?[index]
              //                                             .ratings);
              //                                     log(con.total_rating
              //                                         .toString());
              //                                     Get.to(Booking_detalis(
              //                                       index: index,
              //                                       doc_Id: retrievedboatsList?[
              //                                               index]
              //                                           .ratings,
              //                                       total_rating:
              //                                           con.total_rating,
              //                                     ));
              //                                     FirebaseFirestore.instance
              //                                         .collection('Users')
              //                                         .doc(
              //                                             auth.currentUser!.uid)
              //                                         .update({
              //                                       'bookings':
              //                                           FieldValue.increment(1)
              //                                               .toString(),
              //                                     });
              //                                   },
              //                             child: Padding(
              //                               padding: const EdgeInsets.all(7.0),
              //                               child: ClipRRect(
              //                                   borderRadius:
              //                                       BorderRadius.circular(10),
              //                                   child: Image.network(
              //                                       "${retrievedboatsList?[index].image}",
              //                                       width: 76,
              //                                       height: 80,
              //                                       fit: BoxFit.cover)),
              //                             ),
              //                           ),
              //                           Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: [
              //                               Container(
              //                                 width: MediaQuery.of(context)
              //                                         .size
              //                                         .width /
              //                                     1.6,
              //                                 height: 29,
              //                                 decoration: BoxDecoration(
              //                                   color: AppColors.blue_con,
              //                                   borderRadius:
              //                                       BorderRadius.circular(17),
              //                                 ),
              //                                 child: Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment
              //                                           .spaceBetween,
              //                                   children: [
              //                                     Padding(
              //                                       padding:
              //                                           const EdgeInsets.only(
              //                                               left: 8.0),
              //                                       child: Text(
              //                                         "Booking ID: ${retrievedboatsList?[index].booking_id?.substring(0, 7)}",
              //                                         style: const TextStyle(
              //                                             color: Colors.white,
              //                                             fontSize: 11),
              //                                       ),
              //                                     ),
              //                                     GestureDetector(
              //                                       onTap: retrievedboatsList?[
              //                                                       index]
              //                                                   .booking_status ==
              //                                               '● Booked'
              //                                           ? () {
              //                                               debugPrint(
              //                                                   retrievedboatsList?[
              //                                                           index]
              //                                                       .ratings);
              //                                               Get.to(
              //                                                   Payment_screen(
              //                                                 boat_name:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .boat_name,
              //                                                 token_for_completetheorder:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .tokenforcompletation,
              //                                                 start_time:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .start_time,
              //                                                 total_amount:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .total_amount,
              //                                                 i: index,
              //                                                 documnet_id:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .ratings,
              //                                               ));
              //                                             }
              //                                           : () {
              //                                               con.getdata(
              //                                                   retrievedboatsList?[
              //                                                           index]
              //                                                       .ratings);
              //                                               log(con.total_rating
              //                                                   .toString());
              //                                               Get.to(
              //                                                   Booking_detalis(
              //                                                 index: index,
              //                                                 doc_Id:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .ratings,
              //                                                 total_rating: con
              //                                                     .total_rating,
              //                                               ));
              //                                               FirebaseFirestore
              //                                                   .instance
              //                                                   .collection(
              //                                                       'Users')
              //                                                   .doc(auth
              //                                                       .currentUser!
              //                                                       .uid)
              //                                                   .update({
              //                                                 'bookings':
              //                                                     FieldValue
              //                                                         .increment(
              //                                                             1),
              //                                               });
              //                                             },
              //                                       child: Row(
              //                                         children: const [
              //                                           Text(
              //                                             "View Details",
              //                                             style: TextStyle(
              //                                                 color:
              //                                                     Colors.white,
              //                                                 fontWeight:
              //                                                     FontWeight
              //                                                         .w600,
              //                                                 fontSize: 11),
              //                                           ),
              //                                           Icon(
              //                                               Icons
              //                                                   .arrow_forward_ios_outlined,
              //                                               color: Colors.white,
              //                                               size: 15)
              //                                         ],
              //                                       ),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                               Text(
              //                                   "${retrievedboatsList?[index].boat_name}",
              //                                   style:
              //                                       AppTextStyles.kPrimaryS5W4),
              //                               const SizedBox(height: 5),
              //                               SizedBox(
              //                                 width: MediaQuery.of(context)
              //                                         .size
              //                                         .width /
              //                                     1.7,
              //                                 child: Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment
              //                                           .spaceBetween,
              //                                   children: [
              //                                     Text(
              //                                       "${retrievedboatsList?[index].start_time} to ${retrievedboatsList?[index].end_time}",
              //                                       style: AppTextStyles
              //                                           .kPrimaryS7W4,
              //                                     ),
              //                                   ],
              //                                 ),
              //                               ),
              //                               const SizedBox(height: 5),
              //                               SizedBox(
              //                                 width: MediaQuery.of(context)
              //                                         .size
              //                                         .width /
              //                                     1.7,
              //                                 child: Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment
              //                                           .spaceBetween,
              //                                   children: [
              //                                     Row(
              //                                       children: [
              //                                         Text(
              //                                           "${retrievedboatsList?[index].booking_status}",
              //                                           style: const TextStyle(
              //                                               color: AppColors
              //                                                   .Sdark_blue),
              //                                         )
              //                                       ],
              //                                     ),
              //                                     GestureDetector(
              //                                       onTap: retrievedboatsList?[
              //                                                       index]
              //                                                   .booking_status ==
              //                                               '● Booked'
              //                                           ? () {
              //                                               Fluttertoast.showToast(
              //                                                   msg:
              //                                                       "Booking Cancelled",
              //                                                   toastLength: Toast
              //                                                       .LENGTH_SHORT,
              //                                                   gravity:
              //                                                       ToastGravity
              //                                                           .BOTTOM_RIGHT,
              //                                                   timeInSecForIosWeb:
              //                                                       1,
              //                                                   backgroundColor:
              //                                                       Colors
              //                                                           .black,
              //                                                   textColor:
              //                                                       Colors
              //                                                           .white,
              //                                                   fontSize: 16.0);
              //                                               var getid =
              //                                                   retrievedboatsList![
              //                                                           index]
              //                                                       .documnet_id;
              //                                               FirebaseFirestore
              //                                                   .instance
              //                                                   .collection(
              //                                                       'booking_requestforowner')
              //                                                   .doc(retrievedboatsList![
              //                                                           index]
              //                                                       .boat_sender_uid)
              //                                                   .collection(
              //                                                       'allrequest')
              //                                                   .doc(getid);
              //                                               FirebaseFirestore
              //                                                   .instance
              //                                                   .collection(
              //                                                       'booking_request')
              //                                                   .doc(auth
              //                                                       .currentUser!
              //                                                       .uid)
              //                                                   .collection(
              //                                                       'allrequest')
              //                                                   .doc(getid);
              //                                             }
              //                                           : () {
              //                                               con.getdata(
              //                                                 retrievedboatsList?[
              //                                                         index]
              //                                                     .ratings,
              //                                               );
              //                                               Get.to(Remark_us(
              //                                                 owner_id: con.id,
              //                                                 oldvalue:
              //                                                     con.old_value,
              //                                                 n: con
              //                                                     .numbers_given,
              //                                                 doc_uid:
              //                                                     retrievedboatsList?[
              //                                                             index]
              //                                                         .ratings,
              //                                               ));
              //                                             },
              //                                       child: Text(
              //                                           retrievedboatsList?[
              //                                                           index]
              //                                                       .booking_status ==
              //                                                   '● Booked'
              //                                               ? 'Cancel Booking'
              //                                               : 'Add Review',
              //                                           style: AppTextStyles
              //                                               .kPrimaryS9W5),
              //                                     ),
              //                                   ],
              //                                 ),
              //                               )
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                       const SizedBox(height: 16),
              //                       Container(
              //                           margin: const EdgeInsets.only(
              //                               left: 34, right: 24),
              //                           width: double.infinity,
              //                           height: 1,
              //                           color: Colors.cyanAccent)
              //                     ],
              //                   ),
              //                 );
              //               });
              //         } else if (snapshot.connectionState ==
              //                 ConnectionState.done &&
              //             retrievedboatsList!.isEmpty) {
              //           return Center(
              //             child: ListView(
              //               children: const <Widget>[
              //                 Align(
              //                     alignment: AlignmentDirectional.center,
              //                     child: Text('No data available')),
              //               ],
              //             ),
              //           );
              //         } else {
              //           return const Center(child: CircularProgressIndicator());
              //         }
              //       }),
              // ),
            ],
          )),
    );
  }
}
