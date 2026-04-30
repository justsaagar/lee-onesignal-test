import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/app/di/injector.dart';
import 'package:untitled/app/services/notification_service.dart';

class NotificationDemoController extends GetxController {
  final NotificationService _notificationService =
      AppInjector.get<NotificationService>();
  final TextEditingController nameController = TextEditingController();
  final RxString enteredName = ''.obs;
  final RxString greetingName = 'name'.obs;

  void onNameChanged(String value) {
    enteredName.value = value.trim();
  }

  Future<void> onContinueTap() async {
    final String value = enteredName.value.trim();
    final String resolvedName = value.isEmpty ? 'name' : value;
    greetingName.value = resolvedName;
    await _notificationService.setUserName(resolvedName);
    await _notificationService.requestPermission();
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
