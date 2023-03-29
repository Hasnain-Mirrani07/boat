import 'dart:developer';
import 'dart:ui';

import 'package:boat/app/models/boat_data.dart';
import 'package:boat/app/modeules/boat_details/widgets/features.dart';
import 'package:boat/app/modeules/home_page/controller/controller.dart';
import 'package:boat/app/modeules/search_booking/search_boat_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../services/uid.dart';
import '../../bottomapp.dart';
import '../../global_widgets/back_arrow.dart';
import '../../global_widgets/reuseable_button.dart';
import '../../models/start_rating.dart';
import '../../themes/AppAssets.dart';
import '../../themes/AppColors.dart';
import '../../themes/styles/textstyle.dart';
import '../booking_boat/booking/booking_boat.dart';
import '../home_page/home_page.dart';

class Search_Boat_Booking_page extends StatefulWidget {
  Search_Boat_Booking_page({
    required this.check_fav,
    required this.favorites,
    this.documnet_Id,
  });
  bool check_fav;
  bool favorites;
  String? documnet_Id;

  @override
  State<Search_Boat_Booking_page> createState() =>
      _Search_Boat_Booking_pageState();
}

class _Search_Boat_Booking_pageState extends State<Search_Boat_Booking_page> {
  bool? fav = false;

  final con = Get.put(GetData());
  // final con1 = Get.put(Uid());
  int check = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool? load = true;
  @override
  void initState() {
    // TODO: implement initState
    getdata();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        load = false;
      }); // Prints after 1 second.
    });
    super.initState();
  }

  getdata() async {
    await FirebaseFirestore.instance
        .collection("boats")
        .doc(widget.documnet_Id)
        .get()
        .then((value) {
      Map<String, dynamic>? get_data = value.data();

      // first add the data to the Offset object
      var e = get_data?['likedby'];

      for (var i = 0; i < e!.length; i++) {
        if (e[i] == _auth.currentUser!.uid) {
          setState(() {
            fav = true;
          });
          log(fav.toString());
        } else {
          setState(() {
            fav = false;
          });
          log(fav.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(Home());

        return true;
        //we need to return a future
      },
      child: Scaffold(
          backgroundColor: const Color(0xffF5F5F5),
          body: load == false
              ? FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('boats')
                      .doc(widget.documnet_Id)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return ListView(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height / 2.3,
                                child: ClipRRect(
                                  child: ShaderMask(
                                    shaderCallback: (rect) {
                                      return const LinearGradient(
                                        begin: Alignment.centerRight,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent
                                        ],
                                      ).createShader(
                                          Rect.fromLTRB(0, 0, 0, rect.height));
                                    },
                                    blendMode: BlendMode.dstIn,
                                    child: Image.network(
                                      "${data['img1']}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 20.0, top: 20),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: fav == false
                                      ? GestureDetector(
                                          onTap: () async {
                                            getdata();
                                            fav == false
                                                ? con.favorites(
                                                    max_persons:
                                                        data['max_persons'],
                                                    total_rating:
                                                        data['total_rating'],
                                                    bname: data['boat_namae'],
                                                    bimge: data['img1'],
                                                    bprice: data['boat_price'],
                                                    features1: data['feature1'],
                                                    features2: data['feature2'],
                                                    features3: data['feature3'],
                                                    features4: data['feature4'],
                                                    features5: data['feature5'],
                                                    features6: data['feature6'],
                                                    features7: data['feature7'],
                                                    aboutboat:
                                                        data['about_boat'],
                                                    overview: data['overview'],
                                                    mo: data['monday'],
                                                    tu: data['tuesday'],
                                                    we: data['wed'],
                                                    th: data['thu'],
                                                    fr: data['fri'],
                                                    sa: data['sat'],
                                                    su: data['sun'],
                                                    start: data[
                                                        'boating_duration_start'],
                                                    end: data[
                                                        'boating_duration_end'],
                                                    uid: data['uid'],
                                                    token: data['token'],
                                                    dc_id_rating:
                                                        widget.documnet_Id,
                                                  )
                                                : null;
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: Color(0xff979797),
                                            child: Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      : const CircleAvatar(
                                          backgroundColor: Color(0xff979797),
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                        ),
                                ),
                              ),
                            ]),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 20),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Back_arrow(Colors.white)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${data['boat_namae']}",
                                    style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 7),
                                    decoration: BoxDecoration(
                                      color: AppColors.Sdark_blue,
                                      borderRadius: BorderRadius.circular(7.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 6),
                                      child: Center(
                                        child: Text(
                                          "Book Now",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                data['overview'].substring(0, 12),
                                style: AppTextStyles.kPrimaryS7W4,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              StarRating(
                                rating: data['total_rating'],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 22.0),
                          child: Text(
                            "About Boat",
                            style: AppTextStyles.kPrimaryS9W6,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(11),
                                      child: Image.network(
                                        "${data['img1']}",
                                        height: 83,
                                        fit: BoxFit.cover,
                                      ))),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    "${data['about_boat']}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black_type),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: const Text(
                            "Features",
                            style: AppTextStyles.kPrimaryS9W6,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature1']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature1'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature2']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature2'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature3']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature3'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature4']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature4'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature5']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature5'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature6']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature6'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['feature7']}",
                            style: AppTextStyles.kPrimaryS10W4,
                          ),
                        ),
                        data['feature7'] == ""
                            ? const SizedBox(
                                height: 0,
                              )
                            : const SizedBox(
                                height: 11,
                              ),
                        const SizedBox(
                          height: 27,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Overview",
                            style: AppTextStyles.kPrimaryS9W6,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "${data['overview']}",
                            style: AppTextStyles.Klight,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Reuseable_button("Continue Booking",
                              AppColors.Sdark_blue, Appassets.icon_search1, () {
                            log("${data['boating_duration_start']}");

                            Get.to(
                              SearchBooking_boat(
                                document_id: widget.documnet_Id,
                                uid: data['uid'],
                                bname: data['boat_namae'],
                                bimg: data['img1'],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ]);
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                )
              : const Center(child: const CircularProgressIndicator())),
    );
  }
}