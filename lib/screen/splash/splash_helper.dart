import 'dart:async';

import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/app/routes/route_helper.dart';
import 'package:untitled/screen/splash/splash_screen.dart';

class SplashScreenHelper {
  SplashScreenState state;

  SplashScreenHelper(this.state) {
    manageUser();
  }

  Future<void> manageUser() async {
    'Splash timer started. Navigating to onboarding.'.infoLogs();
    Future.delayed(const Duration(seconds: 2), () {
      RouteHelper.instance.goToOnBoarding();
    });
  }
}
