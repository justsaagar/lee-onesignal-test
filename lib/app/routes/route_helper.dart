import 'package:get/get.dart';
import 'package:untitled/app/routes/route_constant.dart';

class RouteHelper {
  static final RouteHelper instance = RouteHelper._internal();

  factory RouteHelper() => instance;

  RouteHelper._internal();

  void goToBack() => Get.back();

  void goToOnBoarding() => Get.toNamed(RouteConstant.onBoarding);
}
