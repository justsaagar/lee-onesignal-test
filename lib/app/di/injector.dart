import 'package:get_it/get_it.dart';
import 'package:untitled/app/services/notification_service.dart';
import 'package:untitled/repository/authentication/auth_repository.dart';
import 'package:untitled/repository/authentication/authentication_helper.dart';
import 'package:untitled/repository/utils/utils_helper.dart';
import 'package:untitled/repository/utils/utils_repository.dart';

/// Central dependency injection. Use [AppInjector] instead of a global GetIt variable.
/// Register dependencies in [registerAll], resolve with [get<T>].
class AppInjector {
  AppInjector._();

  static GetIt get _instance => GetIt.instance;

  static bool _initialized = false;

  /// Registers all app dependencies. Call once from main().
  static Future<void> registerAll() async {
    if (_initialized) return;
    _instance.registerSingleton<NotificationService>(NotificationService());
    _instance.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    _instance.registerSingleton<UtilsRepository>(UtilsRepositoryImpl());
    _initialized = true;
  }

  /// Returns the registered instance of [T]. Throws if not registered.
  static T get<T extends Object>() => _instance.get<T>();

  /// Returns the registered instance of [T] or null if not registered.
  static T? getIfRegistered<T extends Object>() =>
      _instance.isRegistered<T>() ? _instance.get<T>() : null;

  /// For tests: reset the injector (e.g. between tests).
  static Future<void> reset() async {
    await _instance.reset();
    _initialized = false;
  }
}
