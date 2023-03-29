import 'dart:developer';

import 'package:boat/app/global_widgets/back_arrow.dart';
import 'package:boat/app/models/start_rating.dart';
import 'package:boat/app/modeules/boat_details/boat_details.dart';
import 'package:boat/app/modeules/home_page/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../services/uid.dart';
import '../../bottomapp.dart';
import '../../global_widgets/textfield.dart';
import '../../models/boat_data.dart';
import '../../themes/AppAssets.dart';
import '../../themes/AppColors.dart';
import '../../themes/styles/textstyle.dart';
import '../home_page/components/usual_trips.dart';
import '../home_page/controller/controller.dart';
import 'components/ui.dart';

class Offers_Details extends StatefulWidget {
  Offers_Details({this.index});
  var index;
  @override
  State<Offers_Details> createState() => _Offers_DetailsState();
}

class _Offers_DetailsState extends State<Offers_Details> {
  int i = 0;
  bool? fav = false;
  var ind;
  final con = Get.put(GetData());
  // final con1 = Get.put(Uid());
  final TextEditingController _controller = TextEditingController();
  GetData service = GetData();
  Future<List<Boat_data>>? employeeList;
  List<Boat_data>? retrievedEmployeeList;
  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  Future<void> _initRetrieval() async {
    employeeList = service.retrieveEmployees();
    retrievedEmployeeList = await service.retrieveEmployees();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<dynamic>? pointList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ));

          return true;
          //we need to return a future
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "text16".tr,
                    style: AppTextStyles.ktitle,
                  )),
              const SizedBox(height: 20),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: employeeList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Boat_data>> snapshot) {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemCount: retrievedEmployeeList!.length,
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3.4,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(14),
                                                    topLeft:
                                                        Radius.circular(14)),
                                            child: GestureDetector(
                                              onTap: () {
                                                var documnet_id =
                                                    retrievedEmployeeList?[
                                                            index]
                                                        .id;
                                                log({
                                                  retrievedEmployeeList?[index]
                                                      .check_fav
                                                }.toString());
                                                Get.to(Boat_Booking_page(
                                                  i: index,
                                                  check_fav: true,
                                                  favorites: false,
                                                  documnet_Id: documnet_id,
                                                ));
                                              },
                                              child: Image.network(
                                                "${retrievedEmployeeList![index].image}",
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(9.0),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () async {
                                              ind = index;
                                              var documnet_id =
                                                  retrievedEmployeeList?[index]
                                                      .id;
                                              await FirebaseFirestore.instance
                                                  .collection('boats')
                                                  .doc(documnet_id)
                                                  .get()
                                                  .then((DocumentSnapshot) =>
                                                      setState(() {


                                                        if (DocumentSnapshot
                                                            .data()![
                                                        'likedby'].contains(
                                                            _auth.currentUser!
                                                                .uid)) {
                                                          Fluttertoast.showToast(
                                                              msg: "Already in Favorites",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.black,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                        }else{
                                                          Fluttertoast.showToast(
                                                              msg: "Added to Favorites",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              timeInSecForIosWeb: 1,
                                                              backgroundColor: Colors.black,
                                                              textColor: Colors.white,
                                                              fontSize: 16.0
                                                          );
                                                          con.favorites(
                                                            max_persons:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .max_persons,
                                                            total_rating:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .total_rating,
                                                            bname:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .boatname,
                                                            bimge:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .image,
                                                            bprice:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .boatprice,
                                                            features1:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature,
                                                            features2:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature2,
                                                            features3:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature3,
                                                            features4:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature4,
                                                            features5:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature5,
                                                            features6:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature6,
                                                            features7:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .feature7,
                                                            aboutboat:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .about_boat,
                                                            overview:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .overview,
                                                            mo: retrievedEmployeeList![
                                                            index]
                                                                .mon,
                                                            tu: retrievedEmployeeList![
                                                            index]
                                                                .tue,
                                                            we: retrievedEmployeeList![
                                                            index]
                                                                .wed,
                                                            th: retrievedEmployeeList![
                                                            index]
                                                                .thu,
                                                            fr: retrievedEmployeeList![
                                                            index]
                                                                .fri,
                                                            sa: retrievedEmployeeList![
                                                            index]
                                                                .sat,
                                                            su: retrievedEmployeeList![
                                                            index]
                                                                .sun,
                                                            start:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .boat_start,
                                                            end:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .boat_end,
                                                            uid:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .boat_sender_uid,
                                                            token:
                                                            retrievedEmployeeList![
                                                            index]
                                                                .token,
                                                            dc_id_rating: documnet_id,
                                                          );

                                                        }
                                                      }));
                                              con.chech_staus = documnet_id;

                                            },
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xff979797),
                                                child: i == 0
                                                    ? const Icon(
                                                        Icons.favorite,
                                                        color: Colors.white,
                                                        size: 22,
                                                      )
                                                    : const Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                        size: 22,
                                                      )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 17.0, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${retrievedEmployeeList![index].boatname}",
                                              style: AppTextStyles.kPrimaryS5W4,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 7),
                                                decoration: BoxDecoration(
                                                  color: AppColors.Sdark_blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.0),
                                                ),
                                                child: const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 14.0,
                                                      vertical: 5),
                                                  child: Center(
                                                    child: Text(
                                                      "Book Now",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${retrievedEmployeeList?[index].overview!.substring(0, 12)}",
                                          style: AppTextStyles.kPrimaryS7W4,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                StarRating(
                                                  rating:
                                                      retrievedEmployeeList?[
                                                              index]
                                                          .total_rating,
                                                ),
                                                SizedBox(
                                                  width: 6,
                                                ),
                                                const Text(
                                                  "Rating",
                                                  style: AppTextStyles
                                                      .kPrimaryS7W4,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    size: 17,
                                                    color: Colors.grey,
                                                  ),
                                                  Text(
                                                    "${retrievedEmployeeList?[index].max_persons}",
                                                    style: AppTextStyles
                                                        .kPrimaryS7W4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 7,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      retrievedEmployeeList!.isEmpty) {
                    return Center(
                      child: ListView(
                        children: const <Widget>[
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: Text('No data available')),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}