import 'dart:developer';

import 'package:boat/app/models/boat_data.dart';
import 'package:boat/app/modeules/home_page/controller/controller.dart';
import 'package:boat/services/uid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../themes/styles/textstyle.dart';
import '../../boat_details/boat_details.dart';

class Usual_trips extends StatefulWidget {

  Usual_trips({
    Key? key,

    required this.img,

    required this.boatname,
    required this.boatprice,

    this.overview,
    this.about_boat,
    this.feature,
    this.feature2,
    this.feature3,
    this.feature4,
    this.feature5,
    this.feature6,
    this.feature7,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,

    this.sun,
    this.boating_duration_start,
    this.boating_duration_end,
    this.doc,
  });
  String img;
  String boatname;
  String boatprice;
  var overview;
  var about_boat;
  var feature;
  var feature2;
  var feature3;
  var feature4;
  var feature5;
  var feature6;
  var feature7;
  var doc;
      String? boating_duration_start;
  String? boating_duration_end;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  String? sun;

  @override

  State<Usual_trips> createState() => _Usual_tripsState();
}

class _Usual_tripsState extends State<Usual_trips> {
  final getUid = Get.put(Uid());

  @override

    Widget build(BuildContext context) {
    return
      Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Get.to(BoatDetails_page(widget.doc));
              final con = Get.put(GetData(
                    image: widget.img,
                    boatname: widget.boatname,
                    boatprice: widget.boatprice,
                    overview: widget.overview,
                    about_boat: widget.about_boat,
                    feature: widget.feature,
                    feature2: widget.feature2,
                    feature3: widget.feature3,
                    feature4: widget.feature4,
                    feature5: widget.feature5,
                    feature6: widget.feature6,
                    feature7: widget.feature7,
                    mon: widget.mon,
                    tue: widget.tue,
                    wed: widget.wed,
                    thu: widget.thu,
                    fri: widget.fri,
                    sat: widget.sat,
                    sun: widget.sun,
                    start: widget.boating_duration_start,
                    end: widget.boating_duration_end,
                  ));

              getUid.getcurrentuser();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.img,
                fit: BoxFit.cover,
                height: 115,
                width: MediaQuery.of(context).size.width / 2.5,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "${widget.boatname}",
            style: AppTextStyles.kPrimaryS5W4,
          ),
          SizedBox(
            height: 3,
          ),
          const Text(
            "Nam porttitor blandi.",
            style: AppTextStyles.kPrimaryS7W4,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "\$${widget.boatprice}",
            style: AppTextStyles.kPrimaryS8W5,
          ),
        ],
      ),
      SizedBox(
        width: 25,
      ),
    ]);
  }
}
