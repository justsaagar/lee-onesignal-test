import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:untitled/app/helper/extension_helper.dart';

class NotificationService {
  static const String _appId = 'fe42b4bc-9e29-4186-9f2d-2c4ae656d36f';
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    try {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
      await OneSignal.initialize(_appId);
      _registerListeners();
      _isInitialized = true;
      'OneSignal initialized successfully'.infoLogs();
    } catch (e) {
      'OneSignal init error: $e'.errorLogs();
    }
  }

  Future<void> requestPermission() async {
    try {
      final bool granted = await OneSignal.Notifications.requestPermission(
        false,
      );
      'Push permission granted: $granted'.infoLogs();
    } catch (e) {
      'OneSignal permission request error: $e'.errorLogs();
    }
  }

  Future<void> setUserName(String name) async {
    final String trimmedName = name.trim();
    if (trimmedName.isEmpty) return;
    try {
      await OneSignal.User.addTagWithKey('first_name', trimmedName);
      'OneSignal tag updated: first_name=$trimmedName'.infoLogs();
    } catch (e) {
      'OneSignal setUserName error: $e'.errorLogs();
    }
  }

  Future<void> logout() async {
    try {
      await OneSignal.User.removeTag('first_name');
      await OneSignal.logout();
      'OneSignal user context cleared'.infoLogs();
    } catch (e) {
      'OneSignal logout error: $e'.errorLogs();
    }
  }

  void _registerListeners() {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      final OSNotification notification = event.notification;
      'Foreground push received: ${notification.title} | ${notification.body} | ${notification.additionalData}'
          .logs();
    });

    OneSignal.Notifications.addClickListener((event) {
      final OSNotification notification = event.notification;
      'Push clicked: ${notification.title} | ${notification.body} | ${notification.additionalData}'
          .logs();
    });

    OneSignal.InAppMessages.addDidDisplayListener((event) {
      'In-app message displayed: ${event.message.messageId}'.logs();
    });
  }
}
