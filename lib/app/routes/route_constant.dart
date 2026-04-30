import 'package:get/get.dart';
import 'package:untitled/screen/notification_demo/notification_demo_screen.dart';
import 'package:untitled/screen/splash/splash_screen.dart';

class RouteConstant {
  static const String initial = '/';
  static const String notificationDemo = '/notificationDemo';
}

mixin GetPageRouteHelper {
  static List<GetPage> routes = [
    GetPage(name: RouteConstant.initial, page: () => const SplashScreen()),
    GetPage(
      name: RouteConstant.notificationDemo,
      page: () => const NotificationDemoScreen(),
    ),
  ];
}
