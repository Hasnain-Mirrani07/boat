import 'package:firebase_auth/firebase_auth.dart';

class Uid {
  var check_fav;
  String? uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void getcurrentuser() {
    final User user = _auth.currentUser!;
    uid = user.uid;
  }
}