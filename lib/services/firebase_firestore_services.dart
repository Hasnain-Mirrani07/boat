
import '../app/firebase_paths.dart';
import '../app/models/myappuser.dart';

abstract class FirebaseFirestoreImpl {
  Future<MyAppUser?> loadMyAppUserData({required String? uid});
}

class FirebaseFirestoreServices extends FirebaseFirestoreImpl {
  @override
  Future<MyAppUser?> loadMyAppUserData({required String? uid}) async {
    if (uid == null) return null;
    final snapshot = await FirebasePaths.users(uid).get();
    MyAppUser user = MyAppUser.fromSnapshot(snapshot);
    return user;
  }
}