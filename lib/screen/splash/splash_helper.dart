import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/app/routes/route_helper.dart';
import 'package:untitled/screen/splash/splash_screen.dart';

class SplashScreenHelper {
  SplashScreenState state;

  SplashScreenHelper(this.state) {
    manageUser();
  }

  Future<void> manageUser() async {
    'FirebaseAuth.instance.currentUser --> ${FirebaseAuth.instance.currentUser?.uid}'
        .infoLogs();
    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
      } else {
        RouteHelper.instance.goToOnBoarding();
      }
    });
  }
}
