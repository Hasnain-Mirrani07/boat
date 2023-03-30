import 'dart:developer';

import 'package:boat/app/models/boat_data.dart';
import 'package:boat/app/modeules/home_page/controller/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../singaltonClass.dart';
import '../../bottomapp.dart';
import '../../global_widgets/back_arrow.dart';
import '../../global_widgets/reuseable_button.dart';
import '../../models/start_rating.dart';
import '../../themes/AppAssets.dart';
import '../../themes/AppColors.dart';
import '../../themes/styles/textstyle.dart';
import '../booking_boat/booking/booking_boat.dart';
import '../booking_boat/booking/controller.dart';

class Boat_Booking_page extends StatefulWidget {
  Boat_Booking_page({
    Key? key,
    required this.i,
    required this.check_fav,
    required this.favorites,
    this.documnet_Id,
  }) : super(key: key);

  int i;
  bool check_fav;
  bool favorites;
  String? documnet_Id;

  @override
  State<Boat_Booking_page> createState() => _Boat_Booking_pageState();
}

class _Boat_Booking_pageState extends State<Boat_Booking_page> {
  bool? fav = false;

  final con = Get.put(GetData());

  // final con1 = Get.put(Uid());
  int check = 0;

  Future<List<Boat_data>>? employeeList;
  List<Boat_data>? retrievedEmployeeList;

  int? i = 0;

  Future<void> _initRetrieval() async {
    GetData service = GetData();

    employeeList = service.retrieveEmployees();
    retrievedEmployeeList = await service.retrieveEmployees();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool? load = true;

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    _initRetrieval();

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
      Map<String, dynamic>? getData = value.data();

      // first add the data to the Offset object
      var e = getData?['likedby'];
      SessionControllerOwner().owneruid = getData?['owneruid'];

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
                  future: employeeList,
                  builder: (BuildContext context, snapshot) {
                    return ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 2.3,
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
                                    "${retrievedEmployeeList![widget.i].image}",
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
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .max_persons,
                                                  total_rating:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .total_rating,
                                                  bname: retrievedEmployeeList![
                                                          widget.i]
                                                      .boatname,
                                                  bimge: retrievedEmployeeList![
                                                          widget.i]
                                                      .image,
                                                  bprice:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .boatprice,
                                                  features1:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature,
                                                  features2:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature2,
                                                  features3:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature3,
                                                  features4:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature4,
                                                  features5:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature5,
                                                  features6:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature6,
                                                  features7:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .feature7,
                                                  aboutboat:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .about_boat,
                                                  overview:
                                                      retrievedEmployeeList![
                                                              widget.i]
                                                          .overview,
                                                  mo: retrievedEmployeeList![
                                                          widget.i]
                                                      .mon,
                                                  tu: retrievedEmployeeList![
                                                          widget.i]
                                                      .tue,
                                                  we: retrievedEmployeeList![
                                                          widget.i]
                                                      .wed,
                                                  th: retrievedEmployeeList![
                                                          widget.i]
                                                      .thu,
                                                  fr: retrievedEmployeeList![
                                                          widget.i]
                                                      .fri,
                                                  sa: retrievedEmployeeList![
                                                          widget.i]
                                                      .sat,
                                                  su: retrievedEmployeeList![
                                                          widget.i]
                                                      .sun,
                                                  start: retrievedEmployeeList![
                                                          widget.i]
                                                      .boat_start,
                                                  end: retrievedEmployeeList![
                                                          widget.i]
                                                      .boat_end,
                                                  uid: retrievedEmployeeList![
                                                          widget.i]
                                                      .boat_sender_uid,
                                                  token: retrievedEmployeeList![
                                                          widget.i]
                                                      .token,
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
                            padding: const EdgeInsets.only(left: 20.0, top: 20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${retrievedEmployeeList![widget.i].boatname}",
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
                              retrievedEmployeeList![widget.i]
                                  .overview!
                                  .substring(0, 12),
                              style: AppTextStyles.kPrimaryS7W4,
                            ),
                            const SizedBox(height: 3),
                            StarRating(
                                rating: retrievedEmployeeList![widget.i]
                                    .total_rating),
                            const SizedBox(height: 7),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.0),
                        child: Text("About Baot",
                            style: AppTextStyles.kPrimaryS9W6),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(11),
                                    child: Image.network(
                                        "${retrievedEmployeeList![widget.i].image}",
                                        height: 83,
                                        fit: BoxFit.cover))),
                            const SizedBox(width: 8),
                            Expanded(
                                flex: 5,
                                child: Text(
                                  "${retrievedEmployeeList![widget.i].about_boat}",
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_type),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 23),
                      const SizedBox(height: 22),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Features",
                          style: AppTextStyles.kPrimaryS9W6,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature2}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature2 == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature3}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature3 == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature4}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature4 == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature5}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature5 == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature6}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature6 == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].feature7}",
                            style: AppTextStyles.kPrimaryS10W4),
                      ),
                      retrievedEmployeeList![widget.i].feature7 == ""
                          ? const SizedBox(height: 0)
                          : const SizedBox(height: 11),
                      const SizedBox(height: 27),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child:
                            Text("Overview", style: AppTextStyles.kPrimaryS9W6),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                            "${retrievedEmployeeList![widget.i].overview}",
                            style: AppTextStyles.Klight),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Reuseable_button(
                            "Continue Booking",
                            AppColors.Sdark_blue,
                            Appassets.icon_search1, () async {
                          //   Get.to(HomeScreen());

                          log("${retrievedEmployeeList![widget.i].boat_start}");
                          bool isAlreadyExist = await Booking_controller()
                              .isRequestAlreadySent(widget.documnet_Id!);
                          if (isAlreadyExist) {
                            Fluttertoast.showToast(
                                msg: "Request already sent",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM_LEFT,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            return;
                          }
                          Get.to(
                            Booking_boat(
                              index: widget.i,
                              document_id: widget.documnet_Id,
                              uid: retrievedEmployeeList![widget.i]
                                  .boat_sender_uid,
                              bname: retrievedEmployeeList![widget.i].boatname,
                              bimg: retrievedEmployeeList![widget.i].image,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 8)
                    ]);
                  },
                )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}
