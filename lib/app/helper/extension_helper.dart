import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:untitled/app/constant/color_constant.dart';
import 'package:url_launcher/url_launcher.dart';

SystemUiOverlayStyle changeStatusBarIconColor({bool lightColor = false}) {
  return SystemUiOverlayStyle(
    statusBarIconBrightness: lightColor ? Brightness.light : Brightness.dark,
  );
}

extension SnackBar on String {
  dynamic showError() {
    Get.snackbar(
      'oops!'.tr.toLowerCase(),
      toLowerCase(),
      backgroundColor: AppColorConstant.appWhite,
      colorText: AppColorConstant.appBlack,
    );
  }

  dynamic showSuccess() {
    return Get.snackbar(
      'success'.tr,
      toLowerCase(),
      backgroundColor: AppColorConstant.appGreenColor,
      colorText: AppColorConstant.appBlack,
    );
  }

  void logs() {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 0)).d(this);
    }
  }

  void infoLogs() {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 0)).i(this);
    }
  }

  void traceLogs() {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 0)).t(this);
    }
  }

  void warningLogs() {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 0)).w(this);
    }
  }

  void errorLogs() {
    if (kDebugMode) {
      Logger(printer: PrettyPrinter(methodCount: 0)).e(this);
    }
  }

  Future<void> launchStoreRating() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: this,
      queryParameters: {'subject': 'App Feedback'},
    );
    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      e.toString().errorLogs();
    }
  }
}
