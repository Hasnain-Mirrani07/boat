import 'dart:async';
import 'dart:developer';

import 'package:boat/app/modeules/payment/payment.dart';
import 'package:boat/app/modeules/remark_us/remark_us_screen.dart';
import 'package:boat/app/modeules/settings/setings_screen.dart';
import 'package:boat/app/modeules/tracking_odrer/controller/get_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../services/firebase_firestore_services.dart';
import '../global_widgets/big_divider.dart';
import '../models/bookings_boats.dart';
import '../models/myappuser.dart';
import '../themes/AppColors.dart';
import '../themes/styles/textstyle.dart';
import 'auth/profile_selection.dart';
import 'booking_boat/booking_details.dart';
import 'bookings and favorites/controller/booking_controller.dart';

class Verified_Profile extends StatefulWidget {
  @override
  State<Verified_Profile> createState() => _Verified_ProfileState();
}

class _Verified_ProfileState extends State<Verified_Profile> {
  bool isSwitched = false;
  final con = Get.put(Get_Data());
  final con1 = Get.put(Booking_request_controller());

  Booking_request_controller service = Booking_request_controller();
  Future<List<Booking_Boats>>? boatsList;
  List<Booking_Boats>? retrievedboatsList;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _initRetrieval() async {
    boatsList = service.retrievebookingBoatdata();
    retrievedboatsList = await service.retrievebookingBoatdata();
  }

  @override
  void initState() {
    // TODO: implement initState
    _initRetrieval();
    super.initState();
  }

  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(Settings_screen());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0, top: 10, left: 18),
              child: SvgPicture.asset("assets/icons/setings.svg"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              FutureBuilder<MyAppUser?>(
                  initialData: MyAppUser.find,
                  future: FirebaseFirestoreServices().loadMyAppUserData(uid: MyAppUser.find.id),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.data != null && snapshot.data?.email != null) {
                      MyAppUser.find.update(snapshot.data);
                    }
                    return Column(
                      children: [
                        Stack(
                          children: [
                            snapshot.data?.profileurl == null
                                ? Image.asset("assets/profile_img.png", width: 90, height: 90)
                                : CircleAvatar(
                                    radius: 44,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                        radius: 70,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage('${snapshot.data?.profileurl}')),
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.to(Profile_Selection(
                                  // checking_editing: true,
                                  ));
                            },
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            snapshot.data?.name ?? "",
                            style: AppTextStyles.kPrimaryS7W5
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(snapshot.data?.totalBooking ?? "0", style: AppTextStyles.kPrimaryS10W1),
                                // Text((Get.find<LocalizationController>().isEnglish()? snapshot.data?.totalBooking ?? "0" :(snapshot
                                //     .data?.totalBooking ?? "0").toArabicNumbers),
                                //     style:
                                //     AppTextStyles
                                //         .kPrimaryS10W1),
                                const SizedBox(height: 2),
                                Text("Total Booking".tr, style: AppTextStyles.kPrimaryS10W2),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
              ////OLD CODE FOR PROFILE
              // FutureBuilder<DocumentSnapshot>(
              //     future: users.doc(_auth.currentUser?.uid).get(),
              //     builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              //       if (snapshot.connectionState == ConnectionState.done) {
              //         Map<String, dynamic> data = snapshot.data?.data() as Map<String, dynamic>;
              //         return Column(
              //           children: [
              //             Stack(
              //               children: [
              //                 data['profile_img'] == null
              //                     ? Image.asset(
              //                         "assets/profile_img.png",
              //                         width: 90,
              //                         height: 90,
              //                       )
              //                     : CircleAvatar(
              //                         radius: 44,
              //                         backgroundColor: Colors.white,
              //                         child: CircleAvatar(
              //                           radius: 70,
              //                           backgroundColor: Colors.white,
              //                           backgroundImage: NetworkImage('${data['profile_img']}'),
              //                         )),
              //               ],
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             GestureDetector(
              //                 onTap: () {
              //                   Get.to(Profile_Selection(
              //                       // checking_editing: true,
              //                       ));
              //                 },
              //                 child: Text(
              //                   "Edit Profile",
              //                   style: TextStyle(
              //                     color: Colors.blue,
              //                   ),
              //                 )),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               "${data['name'] ?? '??'}",
              //               style: AppTextStyles.kPrimaryS7W5,
              //             ),
              //             const SizedBox(
              //               height: 16,
              //             ),
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Column(
              //                   children: [
              //                     Text(
              //                       "${data['bookings']}",
              //                       style: AppTextStyles.kPrimaryS10W1,
              //                     ),
              //                     const SizedBox(
              //                       height: 2,
              //                     ),
              //                     const Text(
              //                       "Total Booking",
              //                       style: AppTextStyles.kPrimaryS10W2,
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ],
              //         );
              //       }
              //       if (snapshot.hasError) {
              //         return const Text("Something went wrong");
              //       }
              //
              //       if (snapshot.hasData && !snapshot.data!.exists) {
              //         return const Text("Document does not exist");
              //       }
              //
              //       return const Center(child: CircularProgressIndicator());
              //     }),

              const Big_divider(),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "text46".tr,
                      style: AppTextStyles.kPrimaryS12W1,
                    ),
                  )),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      color: const Color(0xff1FCC79),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xffD0DBEA),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 49,),
              // Image.asset('assets/icons/not_show.jpg',width:50,height:50,),
              // SizedBox(height: 14,),
              // Text("Noting to show",style: TextStyle(color: Colors.grey,fontSize: 14),)
              const SizedBox(
                height: 6,
              ),
            ],
          ),
          //LIST
          Expanded(
            child: FutureBuilder(
                future: boatsList,
                builder: (BuildContext context, AsyncSnapshot<List<Booking_Boats>> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Image.asset(
                        'assets/no_results.png',
                        width: 112,
                        height: 112,
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return SingleChildScrollView(
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/no_results.png',
                            width: 112,
                            height: 112,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "No Boats",
                                style: const TextStyle(color: Colors.blue, fontSize: 16),
                              ))
                        ],
                      )),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: retrievedboatsList!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 16,
                            ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: retrievedboatsList?[index].booking_status == '● Booked'
                                          ? () {
                                              debugPrint(retrievedboatsList?[index].ratings);
                                              Get.to(Payment_screen(
                                                total_amount: retrievedboatsList?[index].total_amount,
                                                i: index,
                                                documnet_id: retrievedboatsList?[index].ratings,
                                              ));
                                            }
                                          : () {
                                              con1.getdata(retrievedboatsList?[index].ratings);
                                              log(con1.total_rating.toString());
                                              Get.to(Booking_detalis(
                                                index: index,
                                                doc_Id: retrievedboatsList?[index].ratings,
                                                total_rating: con1.total_rating,
                                              ));
                                            },
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(
                                              "${retrievedboatsList?[index].image}",
                                              width: 76,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 1.6,
                                          height: 29,
                                          decoration: BoxDecoration(
                                            color: AppColors.blue_con,
                                            borderRadius: BorderRadius.circular(17),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Booking ID: ${retrievedboatsList?[index].booking_id?.substring(0, 7)}",
                                                  style: const TextStyle(color: Colors.white, fontSize: 11),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: retrievedboatsList?[index].booking_status == '● Booked'
                                                    ? () {
                                                        debugPrint(retrievedboatsList?[index].ratings);
                                                        Get.to(Payment_screen(
                                                          total_amount: retrievedboatsList?[index].total_amount,
                                                          i: index,
                                                          documnet_id: retrievedboatsList?[index].ratings,
                                                        ));
                                                      }
                                                    : () {
                                                        con1.getdata(retrievedboatsList?[index].ratings);
                                                        log(con1.total_rating.toString());
                                                        Get.to(Booking_detalis(
                                                          index: index,
                                                          doc_Id: retrievedboatsList?[index].ratings,
                                                          total_rating: con1.total_rating,
                                                        ));
                                                      },
                                                child: Row(
                                                  children: const [
                                                    Text(
                                                      "View Details",
                                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 11),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios_outlined,
                                                      color: Colors.white,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${retrievedboatsList?[index].boat_name}",
                                          style: AppTextStyles.kPrimaryS5W4,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${retrievedboatsList?[index].start_time} to ${retrievedboatsList?[index].end_time}",
                                                style: AppTextStyles.kPrimaryS7W4,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${retrievedboatsList?[index].booking_status}",
                                                    style: const TextStyle(color: AppColors.Sdark_blue),
                                                  )
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: retrievedboatsList?[index].booking_status == '● Booked'
                                                    ? () {
                                                        var getid = retrievedboatsList![index].documnet_id;
                                                        FirebaseFirestore.instance
                                                            .collection('booking_request')
                                                            .doc(auth.currentUser!.uid)
                                                            .collection('allrequest')
                                                            .doc(getid)
                                                            .delete();
                                                      }
                                                    : () {
                                                        con1.getdata(
                                                          retrievedboatsList?[index].ratings,
                                                        );
                                                        Get.to(Remark_us(
                                                          oldvalue: con1.old_value,
                                                          n: con1.numbers_given,
                                                          doc_uid: retrievedboatsList?[index].ratings,
                                                          owner_id: con1.id,
                                                        ));
                                                      },
                                                child: Text(
                                                    retrievedboatsList?[index].booking_status == '● Booked'
                                                        ? 'Cancel Booking'
                                                        : 'Add Review',
                                                    style: AppTextStyles.kPrimaryS9W5),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 34, right: 24),
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.cyanAccent,
                                )
                              ],
                            ),
                          );
                        });
                  } else if (snapshot.connectionState == ConnectionState.done && retrievedboatsList!.isEmpty) {
                    return Center(
                      child: ListView(
                        children: const <Widget>[
                          Align(alignment: AlignmentDirectional.center, child: Text('No data available')),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}