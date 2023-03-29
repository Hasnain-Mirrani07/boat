import 'package:boat/app/models/favorites_model.dart';
import 'package:boat/app/modeules/boat_details/boat_details.dart';
import 'package:boat/app/modeules/boat_details/favorites%20boat_deatils.dart';
import 'package:boat/app/modeules/home_page/components/favorites_view_all.dart';
import 'package:boat/app/modeules/home_page/controller/controller.dart';
import 'package:boat/app/modeules/offers&details/offers_and_details.dart';
import 'package:boat/app/themes/styles/textstyle.dart';
import 'package:boat/services/uid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../models/boat_data.dart';

class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  final TextEditingController _controller = TextEditingController();

  int selectedIndex = 0;

  int currentIndex = 0;
  final getUid = Get.put(Uid());

  GetData service = GetData();
  Future<List<Boat_data>>? employeeList;

  // List<Boat_data>? retrievedEmployeeList;

  GetData service1 = GetData();

  Future<List<Favorites_Boat_data>>? favList;
  List<Favorites_Boat_data>? retrievedfavList;

  @override
  void initState() {
    super.initState();
    setState(() {
      _initRetrieval();
      _favlists();
    });
  }

  Future refresh() async {
    setState(() {
      employeeList;
    });
  }

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> _initRetrieval() async {
    employeeList = service.retrieveEmployees();
    // retrievedEmployeeList = await service.retrieveEmployees();
  }

  Future<void> _favlists() async {
    favList = service1.retrievefavoritesBoatdata();
    retrievedfavList = await service1.retrievefavoritesBoatdata();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  var i;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: SmartRefresher(
        physics: const BouncingScrollPhysics(),
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 56),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Text("text16".tr, style: AppTextStyles.ktitle)),
                  const SizedBox(height: 55),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("text13".tr, style: AppTextStyles.kPrimaryS9W6),
                      GestureDetector(
                        onTap: () {
                          getUid.getcurrentuser();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Offers_Details(index: i)));
                        },
                        child: Text(
                          "text14".tr,
                          style: const TextStyle(
                              color: Color(0xff494AFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  //usual trips
                  Container(
                    height: 184,
                    padding: const EdgeInsets.only(left: 7.0),
                    child: FutureBuilder(
                        future: employeeList,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Boat_data>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData == false ||
                              snapshot.hasError ||
                              snapshot.data == null ||
                              snapshot.data?.isEmpty == true) {
                            return const Center(
                              child: Align(
                                  alignment: AlignmentDirectional.center,
                                  child: Text('No trips available')),
                            );
                          }
                          final retrievedEmployeeList = snapshot.data;

                          return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: retrievedEmployeeList!.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 150),
                              itemBuilder: (context, index) {
                                i = index;
                                return Row(children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          var documnetId =
                                              retrievedEmployeeList[index].id;

                                          Get.to(Boat_Booking_page(
                                              i: index,
                                              check_fav: true,
                                              favorites: false,
                                              documnet_Id: documnetId));
                                          getUid.getcurrentuser();
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                              '${retrievedEmployeeList[index].image}',
                                              fit: BoxFit.cover,
                                              height: 110,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                          "${retrievedEmployeeList[index].boatname}",
                                          style: AppTextStyles.kPrimaryS5W4),
                                      const SizedBox(height: 3),
                                      Text(
                                          retrievedEmployeeList[index]
                                              .overview!
                                              .substring(0, 12),
                                          style: AppTextStyles.kPrimaryS7W4),
                                      const SizedBox(height: 3),
                                      Text(
                                          "\$${retrievedEmployeeList[index].boatprice}",
                                          style: AppTextStyles.kPrimaryS9W8),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                ]);
                              });
                        }),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("text15".tr, style: AppTextStyles.kPrimaryS9W6),
                      GestureDetector(
                          onTap: () {
                            getUid.getcurrentuser();
                            Get.to(const Favorites_viewall());
                          },
                          child: Text(
                            "text14".tr,
                            style: const TextStyle(
                                color: Color(0xff494AFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: FutureBuilder(
                      future: favList,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Favorites_Boat_data>> snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return SizedBox(
                            height: 184,
                            child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: retrievedfavList?.length == null
                                    ? 0
                                    : retrievedfavList!.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      height: 150,
                                    ),
                                itemBuilder: (context, index) {
                                  return Row(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var documnetId1 =
                                                retrievedfavList?[index].dc_id;

                                            Get.to(Favorites_Boat_details(
                                              imgurl: retrievedfavList?[index]
                                                  .fimage,
                                              name: retrievedfavList?[index]
                                                  .fboatname,
                                              uid: retrievedfavList?[index].uid,
                                              i: index,
                                              check_fav: true,
                                              favorites: true,
                                              documnet_Id: documnetId1,
                                            ));
                                            getUid.getcurrentuser();
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                              '${retrievedfavList?[index].fimage}',
                                              fit: BoxFit.cover,
                                              height: 110,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.6,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "${retrievedfavList?[index].fboatname}",
                                          style: AppTextStyles.kPrimaryS5W4,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          retrievedfavList![index]
                                              .foverview!
                                              .substring(0, 12),
                                          style: AppTextStyles.kPrimaryS7W4,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "\$${retrievedfavList?[index].fboatprice}",
                                          style: AppTextStyles.kPrimaryS9W8,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                  ]);
                                }),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.done &&
                            retrievedfavList == null) {
                          return Center(
                            child: ListView(
                              children: const <Widget>[
                                Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Text('No data available'))
                              ],
                            ),
                          );
                        } else {
                          return const Center(child: Text("No Favorites"));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
