import 'dart:developer';

import 'package:boat/app/modeules/auth/views/Sign_in.dart';
import 'package:boat/services/firebase_auth_services.dart';
import 'package:boat/services/firebase_firestore_services.dart';
import 'package:boat/services/local%20notification%20service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'app/bottomapp.dart';
import 'app/languages/LocaleString.dart';
import 'app/models/myappuser.dart';
import 'app/modeules/auth/controller/auth_controller.dart';
import 'app/modeules/auth/profile_selection.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  log(message.notification!.title.toString());
}

dependencyInjection() async {
  // Get.put(LocalizationController(), permanent: true).initStorage();
  // Get.put(LocalizationController().initStorage(), permanent: true);
  Get.lazyPut(() => FirebaseAuthService(), fenix: true);
  Get.lazyPut(() => MyAppUser(), fenix: true);
  Get.lazyPut(() => FirebaseFirestoreServices(), fenix: true);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  dependencyInjection();
 // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // LocalNotificationService.initialize(null);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // LocalNotificationService.initialize(context);
    // LocalNotificationService.initState(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              theme: ThemeData(scaffoldBackgroundColor: Colors.white),
              translations: LocalString(),
              locale: const Locale('en'),
              debugShowCheckedModeBanner: false,
              home: const WrapperWidget());
        });
  }
}

class WrapperWidget extends StatelessWidget {
  final bool isSignUp;

  const WrapperWidget({Key? key, this.isSignUp = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyAppUser?>(
        future: FirebaseFirestoreServices()
            .loadMyAppUserData(uid: FirebaseAuth.instance.currentUser?.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashWidget();
          }

          if (snapshot.data != null || isSignUp) {
            MyAppUser myAppUser = MyAppUser();
            myAppUser.id = FirebaseAuth.instance.currentUser!.uid;
            isSignUp
                ? MyAppUser.find.update(myAppUser)
                : MyAppUser.find.update(snapshot.data);
            _gotoHomeOrCompleteProfileScreen();
            return SplashWidget();
          } else {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              Get.offAll(() => const Sign_in(), binding: AuthBindings());
            });
          }
          return SplashWidget();
        });
  }

  _gotoHomeOrCompleteProfileScreen() async {
    debugPrint("gotoHomeOrCompleteProfileScreen ${MyAppUser.find.toMap()}");
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // if (MyAppUser.find.profileurl == null || MyAppUser.find.name == null) {
      if (MyAppUser.find.name == null) {
        Get.offAll(const Profile_Selection(isFromAuthScreen: true));
      } else {
        Get.offAll(Home());
      }
    });
  }

  Widget SplashWidget() {
    return Center(
      child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: const Text("Loading...")

          // Lottie.asset(
          //     'assets/lottie/splash_boat.json',
          //     // width: MediaQuery.of(context).size.width,
          //     // height: 450,
          //     repeat: true,
          //     fit: BoxFit.cover,
          //   )
          // Text("Splash Image"),
          ),
    );
  }
}
