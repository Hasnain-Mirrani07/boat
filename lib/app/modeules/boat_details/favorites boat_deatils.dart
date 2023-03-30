import 'package:boat/app/modeules/booking_boat/favorite_booking_boat.dart';
import 'package:boat/app/modeules/home_page/controller/controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/uid.dart';
import '../../../singaltonClass.dart';
import '../../bottomapp.dart';
import '../../global_widgets/back_arrow.dart';
import '../../global_widgets/reuseable_button.dart';
import '../../models/favorites_model.dart';
import '../../models/start_rating.dart';
import '../../themes/AppAssets.dart';
import '../../themes/AppColors.dart';
import '../../themes/styles/textstyle.dart';

class Favorites_Boat_details extends StatefulWidget {
  Favorites_Boat_details({
    Key? key,
    required this.i,
    required this.check_fav,
    required this.favorites,
    required this.imgurl,
    required this.name,
    required this.uid,
    this.documnet_Id,
  }) : super(key: key);
  int i;
  bool check_fav;
  bool favorites;
  String? documnet_Id;
  String? name;
  String? imgurl;
  String? uid;

  @override
  State<Favorites_Boat_details> createState() => _Favorites_Boat_detailsState();
}

class _Favorites_Boat_detailsState extends State<Favorites_Boat_details> {
  final con = Get.put(GetData());
  final con1 = Get.put(Uid());
  int check = 0;
  var rating;
  var old_value;
  var number;
  var data;
  var owneruid;
  Future<void> getdata() async {
    await FirebaseFirestore.instance
        .collection('boats')
        .doc(widget.documnet_Id)
        .get()
        .then((doc) => {data = doc.data()})
        .catchError((error) => {
              debugPrint("Error on get data from User"),
              print(error.toString())
            });
    SessionControllerOwner().owneruid = data["owneruid"];
    rating = data["total_rating"];
    old_value = data["rating"];
    number = data["numbers"];
  }

  GetData service1 = GetData();

  Future<List<Favorites_Boat_data>>? favList;
  List<Favorites_Boat_data>? retrievedfavList;
  Future<void> _favlists() async {
    favList = service1.retrievefavoritesBoatdata();
    retrievedfavList = await service1.retrievefavoritesBoatdata();
  }

  var load = true;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _favlists();
      getdata();
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
                future: favList,
                builder: (BuildContext context, snapshot) {
                  return ListView(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
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
                                        ).createShader(Rect.fromLTRB(
                                            0, 0, 0, rect.height));
                                      },
                                      blendMode: BlendMode.dstIn,
                                      child: Image.network(
                                        "${retrievedfavList![widget.i].fimage}",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 20),
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Back_arrow(Colors.white)),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 17.0, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${retrievedfavList![widget.i].fboatname}",
                                        style: const TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(right: 7),
                                        decoration: BoxDecoration(
                                          color: AppColors.Sdark_blue,
                                          borderRadius:
                                              BorderRadius.circular(7.0),
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
                                    retrievedfavList![widget.i]
                                        .foverview!
                                        .substring(0, 12),
                                    style: AppTextStyles.kPrimaryS7W4,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  StarRating(
                                    rating: rating,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 17.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          child: Image.network(
                                            "${retrievedfavList![widget.i].fimage}",
                                            height: 83,
                                            fit: BoxFit.cover,
                                          ))),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        "${retrievedfavList![widget.i].fabout_boat}",
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
                              child: Text(
                                "Features",
                                style: AppTextStyles.kPrimaryS9W6,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature == ""
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : const SizedBox(
                                    height: 11,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature2}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature2 == ""
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : const SizedBox(
                                    height: 11,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature3}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature3 == ""
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : const SizedBox(
                                    height: 11,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature4}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature4 == ""
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : const SizedBox(
                                    height: 11,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature5}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature5 == ""
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : const SizedBox(
                                    height: 11,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature6}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature6 == ""
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : const SizedBox(
                                    height: 11,
                                  ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].ffeature7}",
                                style: AppTextStyles.kPrimaryS10W4,
                              ),
                            ),
                            retrievedfavList![widget.i].ffeature7 == ""
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "${retrievedfavList![widget.i].foverview}",
                                style: AppTextStyles.Klight,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Reuseable_button(
                                  "Continue Booking",
                                  AppColors.Sdark_blue,
                                  Appassets.icon_search1, () async {
                                // bool isAlreadyExist = await Booking_controller()
                                //     .isRequestAlreadySent(widget.documnet_Id!);
                                // if (isAlreadyExist) {
                                //   Fluttertoast.showToast(
                                //       msg: "Request already sent",
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.BOTTOM_LEFT,
                                //       timeInSecForIosWeb: 1,
                                //       backgroundColor: Colors.black,
                                //       textColor: Colors.white,
                                //       fontSize: 16.0);
                                //   return;
                                // }
                                Get.to(
                                  Favorite_Booking_Boat(
                                    index: widget.i,
                                    uid: retrievedfavList![widget.i].uid,
                                    bname:
                                        retrievedfavList![widget.i].fboatname,
                                    bimg: retrievedfavList![widget.i].fimage,
                                    totalrating: rating,
                                    doc_id: widget.documnet_Id,
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 8,
                            )
                          ]),
                    ],
                  );
                },
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
