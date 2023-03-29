import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../services/fcm_services.dart';
import '../../../../services/send_request.dart';

class Booking_controller extends GetxController {
  var sender_uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<bool> isRequestAlreadySent(String boatDocId)async {
    bool requestSent = false;
    requestSent =  await Send_BoatRequest.isRequestAlreadySent(boatDocId);
    return requestSent;
  }
  void send_request(
      {uid,
      boatname,
      boatimage,
      var hoursperday,
      start_time,
      end_time,
      total_amount,
      uuid,
      sender_uid,
      overview,
      token,sender_token,documnet_idforeview}) {
    final User user = _auth.currentUser!;

    sender_uid = user.uid;
    Send_BoatRequest.send_boatrequest(
        token: token,
        overview: overview,
        boat_name: boatname,
        uuid: uuid,
        start: start_time,
        end: end_time,
        totalamount: total_amount,
        hours: hoursperday,
        image: boatimage,
        uid: uid,
        documnet_idforeview:documnet_idforeview,
        sender_uid: sender_uid,sender_token: sender_token);

    FcmPushNotiService.fetchFcmDetail(
      message: 'You have new request',
      friendFcmToken: token,
      title: boatname,
    );
  }
}