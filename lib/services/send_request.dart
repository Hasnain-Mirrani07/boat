import 'package:boat/app/models/myappuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Send_BoatRequest {
  static _myPendingBookingList(String boatDocId) {
    FirebaseFirestore.instance.collection("Users").doc(MyAppUser.find.id).collection("PendingBooking").doc(boatDocId).set({
      "boatDocId": boatDocId,
    });
  }

  static isRequestAlreadySent(String boatDocId) async {
    var resp =
        await FirebaseFirestore.instance.collection("Users").doc(MyAppUser.find.id).collection("PendingBooking").doc(boatDocId).get();
    if (resp.exists) {
      return true;
    }
    return false;
  }

  static send_boatrequest({
    required String boat_name,
    required var token,
    required String image,
    required String uid,
    required String sender_uid,
    required var hours,
    required var uuid,
    required var totalamount,
    required var start,
    required var end,
    required var overview,
    required var sender_token,
    required String documnet_idforeview,
  }) async {
    FirebaseFirestore.instance.collection("pending_bookings").doc(uid).collection("allpendingboats").doc().set({
      'pending_bname': boat_name,
      'pending_bname': boat_name,
      'function_uid': uid,
      'token': token,
      'pending_bimage': image,
      'hours_perday': hours,
      'sender_uid': sender_uid,
      'id': uuid,
      'start_time': start,
      'end_time': end,
      'total_amount': totalamount,
      'overview': overview,
      'sender_token': sender_token,
      'documnet_idforeview': documnet_idforeview,
    });
    _myPendingBookingList(documnet_idforeview);
  }
}