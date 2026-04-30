import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationDemoController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final RxString enteredName = ''.obs;
  final RxString greetingName = 'name'.obs;

  void onNameChanged(String value) {
    enteredName.value = value.trim();
  }

  void onContinueTap() {
    final String value = enteredName.value.trim();
    greetingName.value = value.isEmpty ? 'name' : value;
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
