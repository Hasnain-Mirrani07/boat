import 'package:boat/app/models/bookings_boats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/favorites_model.dart';

class Booking_request_controller extends GetxController
{
  var total_rating;
  var old_value;
  var numbers_given;
  var id;
  Future<void> getdata(doc_id) async {
 await FirebaseFirestore.instance.collection('boats').doc(doc_id)
        .get().then((DocumentSnapshot) {
          total_rating=DocumentSnapshot.data()!['total_rating'];
          numbers_given=DocumentSnapshot.data()!['numbers'];
          old_value=DocumentSnapshot.data()!['rating'];
         id=DocumentSnapshot.data()!['id'];
    }
    );





  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
String? uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Booking_Boats>> retrievebookingBoatdata() async {

    final User user = _auth.currentUser!;
    uid = user.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await _db.collection("booking_request").doc(uid).collection('allrequest').get();
    return snapshot.docs
        .map((docSnapshot) => Booking_Boats.fromDocumentSnapshot(docSnapshot))
        .toList();
  }
}