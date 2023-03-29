import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Boat_data {
  String? image;
  String? boatname;
  String? boatprice;
  String? overview;
  String? about_boat;
  String? feature;
  String? feature2;
  String? feature3;
  String? feature4;
  String? feature5;
  String? feature6;
  String? feature7;
  String? mon;
  String? tue;
  String? wed;
  String? thu;
  String? fri;
  String? sat;
  String? sun;
  var boat_start;
  var boat_end;
  String? boat_sender_uid;
  String? token;
  String? id;
  var total_rating;
  var max_persons;
  var check_fav;

  Boat_data({
    this.image,
    this.boatname,
    this.boatprice,
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
    this.boat_start,
    this.boat_end,
    this.boat_sender_uid,
    this.token,
    this.id,
    this.total_rating,
    this.max_persons,
    this.check_fav,
  });

  Map<String, dynamic> toMap() {
    return {
      'boatname': boatname,
      'image': image,
      'boatprice': boatprice,
      'overview': overview,
      'about_boat': about_boat,
      'feature': feature,
      'feature2': feature2,
      'feature3': feature3,
      'feature4': feature4,
      'feature5': feature5,
      'feature6': feature6,
      'feature7': feature7,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thu': thu,
      'fri': fri,
      'sat': sat,
      'sun': sun,
      'boat_start': boat_start,
      "boat_end": boat_end,
      "uid": boat_sender_uid,
      "id": id,
      "total_rating": total_rating,
      "max_persons":max_persons,
      "check_fav":check_fav,
    };
  }

  Boat_data.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
  : boatname = doc.data()!["boat_namae"],
  image = doc.data()!["img1"],
   boatprice = doc.data()!["boat_price"],
  overview = doc.data()!["overview"],
  about_boat = doc.data()!["about_boat"],
  feature = doc.data()!["feature1"],
  feature2 = doc.data()!["feature2"],
  feature3 = doc.data()!["feature3"],
  feature4 = doc.data()!["feature4"],
  feature5 = doc.data()!["feature5"],
  feature6 = doc.data()!["feature6"],
  feature7 = doc.data()!["feature7"],
  mon = doc.data()!["monday"],
  tue = doc.data()!["tuesday"],
  wed = doc.data()!["wed"],
  thu = doc.data()!["thu"],
  fri= doc.data()!["fri"],
  sat= doc.data()!["sat"],
  sun= doc.data()!["sun"],
  boat_start= doc.data()!["boating_duration_start"],
  boat_end= doc.data()!["boating_duration_end"],
  boat_sender_uid= doc.data()!["uid"],
  token= doc.data()!["token"],
        total_rating= doc.data()!["total_rating"],
        max_persons= doc.data()!["max_persons"],
        check_fav= doc.data()!["check_fav"],
  id= doc.id;
}
