import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/uid.dart';
import '../../../bottomapp.dart';
import '../../../models/favorites_model.dart';
import '../../../models/start_rating.dart';
import '../../../themes/AppColors.dart';
import '../../../themes/styles/textstyle.dart';
import '../../boat_details/favorites boat_deatils.dart';
import '../controller/controller.dart';

class Favorites_viewall extends StatefulWidget {
  const Favorites_viewall({Key? key}) : super(key: key);

  @override
  State<Favorites_viewall> createState() => _Favorites_viewallState();
}

class _Favorites_viewallState extends State<Favorites_viewall> {
  final TextEditingController _controller = TextEditingController();
  final getUid = Get.put(Uid());
  GetData service1 = GetData();

  Future<List<Favorites_Boat_data>>? favList;
  List<Favorites_Boat_data>? retrievedfavList;
  @override
  void initState() {
    super.initState();
    _favlists();
  }

  Future<void> _favlists() async {
    favList = service1.retrievefavoritesBoatdata();
    retrievedfavList = await service1.retrievefavoritesBoatdata();
  }

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
              const SizedBox(
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
              Expanded(
                child: FutureBuilder(
                  future: favList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Favorites_Boat_data>> snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return SizedBox(
                        height: 184,
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemCount: retrievedfavList!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
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
                                                  var documnetId1 =
                                                      retrievedfavList?[index]
                                                          .dc_id;

                                                  Get.to(Favorites_Boat_details(
                                                    imgurl:
                                                        retrievedfavList?[index]
                                                            .fimage,
                                                    name:
                                                        retrievedfavList?[index]
                                                            .fboatname,
                                                    uid:
                                                        retrievedfavList?[index]
                                                            .uid,
                                                    i: index,
                                                    check_fav: true,
                                                    favorites: true,
                                                    documnet_Id: documnetId1,
                                                  ));
                                                },
                                                child: Image.network(
                                                  "${retrievedfavList![index].fimage}",
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
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
                                                "${retrievedfavList![index].fboatname}",
                                                style:
                                                    AppTextStyles.kPrimaryS5W4,
                                              ),
                                              GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 7),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.Sdark_blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.0),
                                                  ),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                            retrievedfavList![index]
                                                .foverview!
                                                .substring(0, 12),
                                            style: AppTextStyles.kPrimaryS7W4,
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              StarRating(
                                                rating: retrievedfavList![index]
                                                    .total_rating,
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
                                                      "${retrievedfavList![index].max_persons}",
                                                      style: AppTextStyles
                                                          .kPrimaryS7W4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Center(child: Text("No Favorites"));
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
