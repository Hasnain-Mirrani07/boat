import 'package:boat/app/modeules/search/search_screen.dart';
import 'package:boat/app/themes/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_reistrstiong.dart';
import 'modeules/auth/controller/controller.dart';
import 'modeules/bookings and favorites/booking_page.dart';
import 'modeules/bookings and favorites/favorite.dart';
import 'modeules/home_page/home_page.dart';
import 'modeules/verified_profile.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final con = Get.put(profile_selection());


  String? uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home_page(),
    Favorite_page(),
    Booking_page(null),
    Verified_Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home_page(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: Container(
        height: 66.0,
        width: 65.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: AppColors.Sdark_blue,
            onPressed: () {
              Get.to(Search_screen());
            },
            child: Icon(Icons.search, color: Colors.white, size: 25,),
            // elevation: 5.0,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
          //we need to return a future
        },
        child: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),


      //   notchMargin: 10,
      //   child: Container(
      //   //  color: HexColor('#111216'),
      //     height: 60,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: <Widget>[
      //         MaterialButton(
      //           minWidth: 40,
      //           onPressed: () {
      //             setState(() {
      //               currentScreen =
      //                   Home_screen(); // if user taps on this dashboard tab will be active
      //               currentTab = 0;
      //             });
      //           },
      //           child: Container(
      //             width: 25,
      //               height:25,
      //               child: Image.asset('assets/bottom_icons/location.png', color: currentTab == 0 ? Colors.red : Colors.grey,fit: BoxFit.cover,)),
      //          /* child: Icon(
      //             Icons.add_location_alt,
      //             size: 30,
      //             color: currentTab == 0 ? Colors.red : Colors.grey,
      //           ),*/
      //         ),
      //         MaterialButton(
      //           minWidth: 40,
      //           onPressed: () {
      //             setState(() {
      //               currentScreen =
      //                   my_connections_home(); // if user taps on this dashboard tab will be active
      //               currentTab = 1;
      //             });
      //           },
      //           child:Container(
      //               width: 25,
      //               height:25,
      //               child: Image.asset('assets/bottom_icons/peoples.png',color: currentTab == 1 ? Colors.red : Colors.grey,fit: BoxFit.cover,)),
      //         ),
      //
      //
      //         MaterialButton(
      //           minWidth: 30,
      //           onPressed: () {
      //             setState(() {
      //               currentScreen =
      //                   Add_post(); // if user taps on this dashboard tab will be active
      //               currentTab = 2;
      //             });
      //           },
      //           child: Container(
      //               width: 25,
      //               height: 25,
      //               child: Icon(Icons.upload, color: currentTab == 2 ? Colors.red : Colors.red,size: 30,)),
      //
      //         ),
      //
      //         MaterialButton(
      //           minWidth: 40,
      //           onPressed: () {
      //             setState(() {
      //               currentScreen =
      //                   History(); // if user taps on this dashboard tab will be active
      //               currentTab = 3;
      //             });
      //           },
      //           child:Container(
      //               width: 25,
      //               height: 25,
      //               child: Image.asset('assets/bottom_icons/box_c.png',  color: currentTab == 3 ? Colors.red : Colors.grey,fit: BoxFit.cover,)),
      //
      //         ),
      //
      //         MaterialButton(
      //           minWidth: 40,
      //           onPressed: () {
      //             setState(() {
      //               currentScreen =
      //                   Near_byjobs(); // if user taps on this dashboard tab will be active
      //               currentTab = 4;
      //             });
      //           },
      //           child: Container(
      //               width: 25,
      //               height:25,
      //               child: Image.asset('assets/bottom_icons/gps.png',  color: currentTab == 4 ? Colors.red : Colors.grey,fit: BoxFit.cover,)),
      //
      //         ),
      //
      //         MaterialButton(
      //           minWidth: 40,
      //           onPressed: () {
      //             setState(() {
      //               currentScreen =
      //                   my_profile(); // if user taps on this dashboard tab will be active
      //               currentTab = 5;
      //             });
      //           },
      //           child: Icon(
      //             Icons.account_circle_sharp,
      //             size: 30,
      //             color: currentTab == 5 ? Colors.red : Colors.grey,
      //           ),
      //         ),
      //
      //
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomAppBar(
        // elevation: 20.0,

          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            height: 68,
            child: Row(

              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[
                Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavBarItemWidget(
                          title: "text44".tr,
                          icon: Icons.home,
                          isSelected: currentTab == 0,
                          onTap: () {
                            setState(() {
                              currentScreen =
                                  Home_page(); // if user taps on this dashboard tab will be active
                              currentTab = 0;
                            });
                          },),
                        NavBarItemWidget(
                          title: "text45".tr,
                          icon: Icons.favorite,
                          isSelected: currentTab == 1,
                          onTap: () {
                            setState(() {
                              currentScreen =
                                  Favorite_page(); // if user taps on this dashboard tab will be active
                              currentTab = 1;
                            });
                          },),
                      ],
                    )),
                const Flexible(flex: 2, child: SizedBox.shrink()),
                Flexible(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavBarItemWidget(
                            title: "text46".tr,
                            icon: Icons.account_balance_wallet,
                            isSelected: currentTab == 2,
                            onTap: () {
                              final User user = _auth.currentUser!;
                              uid = user.uid;
                              setState(() {
                                currentScreen =
                                    Booking_page(uid); // if user taps on this dashboard tab will be active
                                currentTab = 2;
                              });
                            }),
                        NavBarItemWidget(
                          title: "text47".tr,
                          icon:  Icons.account_circle,
                          isSelected: currentTab == 3,
                          onTap: () {
                            setState(() {
                              currentScreen =
                                  Verified_Profile(); // if user taps on this dashboard tab will be active
                              currentTab = 3;
                            });
                          },
                        )
                      ],
                    ))
                // Expanded(
                //   child: Column(
                //     children: [
                //
                //       IconButton(
                //         iconSize: 30.0,
                //         icon: Icon(Icons.home, color: currentTab == 0 ? AppColors.Sdark_blue : AppColors.light_clr),
                //         onPressed: () {
                //           setState(() {
                //             currentScreen =
                //                 Home_page(); // if user taps on this dashboard tab will be active
                //             currentTab = 0;
                //           });
                //         },
                //       ),
                //
                //
                //       Text("text44".tr, style: TextStyle(fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: currentTab == 0 ? AppColors.Sdark_blue : AppColors.light_clr),),
                //
                //     ],
                //   ),
                // ),
                //
                // Expanded(
                //   child: Column(
                //     children: [
                //       IconButton(
                //         iconSize: 30.0,
                //         icon: Icon(Icons.favorite, color: currentTab == 1 ? AppColors.Sdark_blue : AppColors.light_clr),
                //         onPressed: () {
                //           setState(() {
                //             currentScreen =
                //                 Favorite_page(); // if user taps on this dashboard tab will be active
                //             currentTab = 1;
                //           });
                //         },
                //       ),
                //       Text("text45".tr, style: TextStyle(fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: currentTab == 1 ? AppColors.Sdark_blue : AppColors.light_clr),)
                //
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Column(
                //     children: [
                //       IconButton(
                //         iconSize: 30.0,
                //         icon: Icon(Icons.account_balance_wallet, color: currentTab == 2 ? AppColors.Sdark_blue : AppColors.light_clr,),
                //         onPressed: () {
                //           final User user = _auth.currentUser!;
                //           uid = user.uid;
                //           setState(() {
                //             currentScreen =
                //                 Booking_page(uid); // if user taps on this dashboard tab will be active
                //             currentTab = 2;
                //           });
                //         },
                //       ),
                //       Text("text46".tr, style: TextStyle(fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: currentTab == 2 ? AppColors.Sdark_blue : AppColors.light_clr),)
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Column(
                //     children: [
                //       IconButton(
                //         iconSize: 30.0,
                //         icon: Icon(Icons.account_circle, color: currentTab == 3 ? AppColors.Sdark_blue : AppColors.light_clr,),
                //         onPressed: () {
                //           setState(() {
                //             currentScreen =
                //                 Verified_Profile(); // if user taps on this dashboard tab will be active
                //             currentTab = 3;
                //           });
                //         },
                //       ),
                //       Text("text47".tr, style: TextStyle(fontSize: 12,
                //           fontWeight: FontWeight.w500,
                //           color: currentTab == 3 ? AppColors.Sdark_blue : AppColors.light_clr),)
                //     ],
                //   ),
                // ),
              ],
            ),
          )
      ),

    );
  }
}


class NavBarItemWidget extends StatelessWidget {
  final String title;
  final icon;
  final bool isSelected;
  final Function onTap;

  const NavBarItemWidget({Key? key, required this.icon, required this.onTap, required this.isSelected, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            splashRadius: 24,
            iconSize: 30.0,
            icon: icon is IconData
                ? Icon(icon, color: isSelected ? AppColors.Sdark_blue : AppColors.light_clr)
                : CircleAvatar(radius: 15, backgroundImage: NetworkImage(icon), backgroundColor: Colors.transparent),
            onPressed: () => onTap()),
        Text(
          title.tr,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: isSelected ? AppColors.Sdark_blue : AppColors.light_clr),
        )
      ],
    );
  }
}