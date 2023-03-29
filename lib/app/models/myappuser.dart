import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyAppUser extends GetxService {
  static MyAppUser get find => Get.find();

  late String id;

  String? name;

  String? email; // on reset password page, this field can be null
  String? profileurl;
  String? totalBooking;
  int? createdAt;
  bool? isBoatOwner;

  MyAppUser();

  update(MyAppUser? user) {
    if (user == null || user.id == "") return;
    id = user.id;
    isBoatOwner = user.isBoatOwner;
    name = user.name;
    email = user.email;
    profileurl = user.profileurl;
    createdAt = user.createdAt;
    totalBooking = user.totalBooking;
    // debugPrint("After update: ${toMap()}");
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'is_boat_owner': isBoatOwner ?? false,
      'name': name.toString(),
      'email': email,
      'bookings': totalBooking ?? "0",
      'profile_img': profileurl,
      'createdAt': createdAt,
    };
  }

  MyAppUser.fromMap(map, {String? userId})
      : id = userId ?? map['userId'] ?? '',
        isBoatOwner = map['is_boat_owner'] ?? false,
        name = map['name'],
        email = map['email'],
        totalBooking = map["bookings"] ?? "0",
        profileurl = map['profile_img'];

  MyAppUser.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), userId: snapshot.reference.id);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
