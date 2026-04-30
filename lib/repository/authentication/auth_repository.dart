import 'dart:io';

class AppAuthUser {
  final String id;
  final String email;

  const AppAuthUser({required this.id, required this.email});
}

abstract class AuthRepository {
  Future<AppAuthUser?> registerWithEmailAndPassword(
    String email,
    String password,
  );
  Future<AppAuthUser?> logIn(String emailAddress, String password);
  Future<String?> uploadMedia(
    File file, {
    bool isVideo = false,
    bool isHeadShot = false,
  });
  Future<bool> sendPasswordOnEmail(String email);
  Future<void> signOut();
}
