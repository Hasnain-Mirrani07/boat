import 'package:cloud_firestore/cloud_firestore.dart';

class Favorites_Boat_data {
  String? fimage;
  String? fboatname;
  String? fboatprice;
  String? foverview;
  String? fabout_boat;
  String? ffeature;
  String? ffeature2;
  String? ffeature3;
  String? ffeature4;
  String? ffeature5;
  String? ffeature6;
  String? ffeature7;
  String? fmon;
  String? ftue;
  String? fwed;
  String? fthu;
  String? ffri;
  String? fsat;
  String? fsun;
  String? fstart;
  String? fend;
  String? uid;
  String? token;
  var dc_id;
  var total_rating;
  var max_persons;
  var owneruid;

  Favorites_Boat_data(
      {this.fimage,
      this.fboatname,
      this.fboatprice,
      this.foverview,
      this.fabout_boat,
      this.ffeature,
      this.ffeature2,
      this.ffeature3,
      this.ffeature4,
      this.ffeature5,
      this.ffeature6,
      this.ffeature7,
      this.fmon,
      this.ftue,
      this.fwed,
      this.fthu,
      this.ffri,
      this.fsat,
      this.fsun,
      this.fstart,
      this.fend,
      this.uid,
      this.token,
      this.dc_id,
      this.total_rating,
      this.max_persons,
      this.owneruid});

  Map<String, dynamic> toMap() {
    return {
      'boatname': fboatname,
      'owneruid': owneruid,
      'image': fimage,
      'boatprice': fboatprice,
      'overview': foverview,
      'about_boat': fabout_boat,
      'feature': ffeature,
      'feature2': ffeature2,
      'feature3': ffeature3,
      'feature4': ffeature4,
      'feature5': ffeature5,
      'feature6': ffeature6,
      'feature7': ffeature7,
      'mon': fmon,
      'tue': ftue,
      'wed': fwed,
      'thu': fthu,
      'fri': ffri,
      'sat': fsat,
      'sun': fsun,
      'start': fstart,
      "end": fend,
      "uid": uid,
      "token": token,
      "dc_id": dc_id,
      "total_rating": total_rating,
      "max_persons": max_persons,
    };
  }

  Favorites_Boat_data.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : fboatname = doc.data()!["fboat_name"],
        owneruid = doc.data()!["owneruid"],
        fimage = doc.data()!["fimage"],
        fboatprice = doc.data()!["fboat_price"],
        foverview = doc.data()!["foverview"],
        fabout_boat = doc.data()!["faboutboat"],
        ffeature = doc.data()!["ffeature1"],
        ffeature2 = doc.data()!["ffeature2"],
        ffeature3 = doc.data()!["ffeature3"],
        ffeature4 = doc.data()!["ffeature4"],
        ffeature5 = doc.data()!["ffeature5"],
        ffeature6 = doc.data()!["ffeature6"],
        ffeature7 = doc.data()!["ffeature7"],
        fmon = doc.data()!["fmon"],
        ftue = doc.data()!["ftue"],
        fwed = doc.data()!["fwed"],
        fthu = doc.data()!["fthu"],
        ffri = doc.data()!["ffri"],
        fsat = doc.data()!["fsat"],
        fsun = doc.data()!["fsun"],
        fstart = doc.data()!["fstart"],
        fend = doc.data()!["fend"],
        uid = doc.data()!["boat_sender_uid"],
        token = doc.data()!["token"],
        dc_id = doc.data()!["dc_id"],
        total_rating = doc.data()!["total_rating"],
        max_persons = doc.data()!["max_persons"];
}
