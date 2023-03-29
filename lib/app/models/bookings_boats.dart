import 'package:cloud_firestore/cloud_firestore.dart';

class Booking_Boats {
  String? end_time;
  String? start_time;
  String? booking_id;
  String? image;
  String? boat_name;
  String? sender_uid;
  var hours_perday;
  var total_amount;
  var overview;
  var ratings;
  var booking_status;
  var documnet_id;
  var boat_sender_uid;
  var tokenforcompletation;

  Booking_Boats({
    this.image,
    this.end_time,
    this.start_time,
    this.booking_id,
    this.boat_name,
    this.sender_uid,
    this.hours_perday,
    this.total_amount,
    this.overview,
    this.ratings,
    this.booking_status,
    this.documnet_id,
    this.boat_sender_uid,
    this.tokenforcompletation,
  });

  Map<String, dynamic> toMap() {
    return {
      'boatname': boat_name,
      'image': image,
      'booking_id': booking_id,
      'hours_perday': hours_perday,
      'start_time': start_time,
      'end_time': end_time,
      'sender_uid': sender_uid,
      'total_amount': total_amount,
      'overview': total_amount,
      'ratings': ratings,
      'booking_status': booking_status,
      'documnet_id': documnet_id,
      'boat_sender_uid': boat_sender_uid,
      'tokenforcompletation': tokenforcompletation,
    };
  }

  Booking_Boats.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : boat_name = doc.data()!["rbname"],
        image = doc.data()!["rbimage"],
        total_amount = doc.data()!["rtotal_amount"],
        sender_uid = doc.data()!["rbuid"],
        end_time = doc.data()!["rend"],
        booking_id = doc.data()!["rbooking_id"],
        hours_perday = doc.data()!["rhours"],
        start_time = doc.data()!["rstart"],
        overview = doc.data()!["roverview"],
        ratings = doc.data()!["documnet_id"],
        booking_status = doc.data()!["booking_status"],
        boat_sender_uid = doc.data()!["rbuid"],
        tokenforcompletation = doc.data()!["token"],
        documnet_id = doc.id;
}
