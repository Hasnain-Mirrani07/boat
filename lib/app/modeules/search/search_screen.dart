import 'package:boat/app/global_widgets/big_divider.dart';
import 'package:boat/app/modeules/filters/search_filters.dart';
import 'package:boat/app/modeules/search/searchservice.dart';
import 'package:boat/app/modeules/search_booking/serchdetails_Screen.dart';
import 'package:boat/app/themes/AppAssets.dart';
import 'package:boat/app/themes/AppColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/styles/textstyle.dart';
import '../boat_details/boat_details.dart';

class Search_screen extends StatefulWidget {
  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  final TextEditingController controller = TextEditingController();

  String name = "";
  var documentList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.Proyel_blue,
                      size: 22,
                    )),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Container(
                    height: 55,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        suffix: IconButton(
                          onPressed: () async {
                            controller.clear();
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.Proyel_blue,
                            size: 19,
                          ),
                        ),
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 24,
                          ),
                        ),
                        hintText: "Type here....",
                        fillColor: const Color(0xffF3F4F9),
                        filled: true,
                        hintStyle: AppTextStyles.kPrimaryS2W4,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xffF3F4F9),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xffF3F4F9),
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 13,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Big_divider(),
          const SizedBox(
            height: 23,
          ),
          Expanded(
            child:name.isEmpty ?Image.asset('assets/no_result_found.png'): StreamBuilder<QuerySnapshot>(
              stream: (name != "" && name.trim() != "")
                              ? FirebaseFirestore.instance.collection('boats').where('boat_namae', isGreaterThanOrEqualTo: name).snapshots()

                  : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null || snapshot.data!.size == 0) {
                  const Center(
                      child: Text(
                    "Oops! No result Found",
                    style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                  ));
                }


                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.5, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  var documnet_id = data.id;

                                  Get.to(Search_Boat_Booking_page(
                                    check_fav: true,
                                    favorites: false,
                                    documnet_Id: documnet_id,
                                  ));
                                },
                                child: Text(
                                  "${data['boat_namae']}",
                                  style: AppTextStyles.kPrimaryS11W4,
                                ),
                              )
                            ],
                          ),
                          Appassets.up_above,
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
