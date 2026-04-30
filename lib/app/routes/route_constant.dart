import 'package:get/get.dart';
import 'package:untitled/screen/onboarding/onboarding_screen.dart';
import 'package:untitled/screen/splash/splash_screen.dart';

class RouteConstant {
  static const String initial = '/';
  static const String onBoarding = '/onBoarding';
}

mixin GetPageRouteHelper {
  static List<GetPage> routes = [
    GetPage(name: RouteConstant.initial, page: () => const SplashScreen()),
    GetPage(
      name: RouteConstant.onBoarding,
      page: () => const OnboardingScreen(),
    ),
  ];
}
