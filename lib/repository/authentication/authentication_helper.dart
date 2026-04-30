import 'dart:io';

import 'package:untitled/app/helper/extension_helper.dart';
import 'package:untitled/repository/authentication/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AppAuthUser? _currentUser;

  // ===================================== Sign In ======================================= //
  @override
  Future<AppAuthUser?> logIn(String emailAddress, String password) async {
    try {
      if (emailAddress.isNotEmpty && password.isNotEmpty) {
        _currentUser = AppAuthUser(
          id: emailAddress,
          email: emailAddress,
        );
        'User verified successfully'.showSuccess();
        return _currentUser;
      }
    } on SocketException catch (e) {
      'Catch SocketException in logIn --> ${e.message}'.errorLogs();
      e.message.showError();
    }
    return null;
  }

  // ===================================== Sign out ======================================= //
  @override
  Future<void> signOut() async {
    _currentUser = null;
  }

  // ===================================== Register ======================================= //
  @override
  Future<AppAuthUser?> registerWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      return _currentUser = AppAuthUser(id: email, email: email);
    }
    'Unable to register user with empty credentials'.showError();
    return null;
  }

  // ===================================== Forgot Password ======================================= //

  @override
  Future<bool> sendPasswordOnEmail(String email) async {
    try {
      if (email.contains('@')) return true;
      'Please enter a valid email'.showError();
    } on SocketException catch (e) {
      'Catch SocketException in sendPasswordOnEmail --> ${e.message}'
          .errorLogs();
      e.message.showError();
      return false;
    }
    return false;
  }

  // ===================================== Upload media ======================================= //
  @override
  Future<String?> uploadMedia(
    File file, {
    bool isVideo = false,
    bool isHeadShot = false,
  }) async {
    try {
      final String fileName = file.path.split('/').last;
      'File name --> $fileName'.infoLogs();
      if (await file.exists()) {
        final String localPath = file.uri.toString();
        'File available locally: $localPath'.logs();
        return localPath;
      }
      'Selected file does not exist'.showError();
    } on SocketException catch (e) {
      'Catch SocketException in uploadMedia --> ${e.message}'.errorLogs();
      e.message.showError();
    }
    return null;
  }
}
