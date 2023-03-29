import 'package:boat/app/models/boat_data.dart';
import 'package:boat/app/models/favorites_model.dart';
import 'package:boat/services/uid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GetData extends GetxController {
  var chech_staus;

  GetData({
    Key? key,
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
    this.start,
    this.end,
  });

  var image;
  String? boatname;
  var boatprice;
  var overview;
  var about_boat;
  var feature;
  var feature2;
  var feature3;
  var feature4;
  var feature5;
  var feature6;
  var feature7;
  var mon;
  var tue;
  var wed;
  var thu;
  var fri;
  var sat;
  var sun;
  String? start;
  String? end;

  final check = false;

  final getuid = Get.put(Uid());

  void upadate() {
    image;
    boatname;
    boatprice;
    overview;
    about_boat;
    feature;
    feature2;
    feature3;
    feature4;
    feature5;
    feature6;
    feature7;
    mon;
    tue;
    wed;
    thu;
    fri;
    sat;
    sun;
    String? start;
    String? end;
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Boat_data>> retrieveEmployees() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("boats").get();
    return snapshot.docs.map((docSnapshot) => Boat_data.fromDocumentSnapshot(docSnapshot)).toList();
  }

  // Future<List<Boat_data>> _getEmployeeBoats() async {
  //   List<Boat_data> employees = [];
  //   var data = await _db.collection("boats").get();
  //   for (var element in data.docs) {
  //     employees.add(Boat_data.fromDocumentSnapshot(element));
  //   }
  //   return employees;
  // }

  // Future<List<Boat_data>> retrieveEmployeesBAHADUR() async {
  //   List<Boat_data> boats = [];
  //   boats  = await _getEmployeeBoats();
  //   // QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("boats").get();
  //   // print("snapshot ${snapshot.docs.length}");
  //   // snapshot.docs.map((docSnapshot) {
  //   //   print(docSnapshot.data());
  //   //   try {
  //   //     boats.add(Boat_data.fromDocumentSnapshot(docSnapshot));
  //   //   } catch (e) {
  //   //     print("errretrieveEmployees $e");
  //   //   }
  //   // });
  //   //
  //   // print("boats $boats");
  //   return boats;
  // }

  String? uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<dynamic> alldata = [];
  bool? checking_fav = false;

  Future<List<Favorites_Boat_data>> retrievefavoritesBoatdata() async {
    final User user = _auth.currentUser!;
    uid = user.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection("favorites").doc(uid).collection('users_favorites').get();
    return snapshot.docs.map((docSnapshot) => Favorites_Boat_data.fromDocumentSnapshot(docSnapshot)).toList();
  }

  favorites(
      {bname,
      bimge,
      bprice,
      overview,
      features1,
      features2,
      features3,
      features4,
      features5,
      features6,
      features7,
      aboutboat,
      mo,
      tu,
      we,
      th,
      fr,
      sa,
      su,
      start,
      end,
      token,
      dc_id_rating,
      total_rating,
      max_persons,
      uid}) {
    List<String> userId = [_auth.currentUser!.uid];
    FirebaseFirestore.instance.collection('boats').doc(dc_id_rating).update({
      'likedby': FieldValue.arrayUnion(userId),
    });

    FirebaseFirestore.instance
        .collection("favorites")
        .doc(_auth.currentUser!.uid)
        .collection("users_favorites")
        .doc(dc_id_rating)
        .set({
      'fboat_name': bname,
      'fimage': bimge,
      'fboat_price': bprice,
      'foverview': overview,
      'faboutboat': aboutboat,
      'ffeature1': features1,
      'ffeature2': features2,
      'ffeature3': features3,
      'ffeature4': features4,
      'ffeature5': features5,
      'ffeature6': features6,
      'ffeature7': features7,
      'fmon': mo,
      'ftue': tu,
      'fwed': we,
      'fthu': th,
      'ffri': fr,
      'fsat': sa,
      'fsun': su,
      'fstart': start,
      'fend': end,
      'boat_sender_uid': uid,
      'token': token,
      'dc_id': dc_id_rating,
      'total_rating': total_rating,
      'max_persons': max_persons,
    });
  }
}