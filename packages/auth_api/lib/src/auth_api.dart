import 'package:auth_api/auth_api.dart';

abstract class AuthApi {
  const AuthApi();
  Stream<AuthUser?> get user;
  AuthUser? get currentUser;
  Future<void> authenticate(AuthProvider provider);
  Future<void> unauthenticate();
}

class AuthException implements Exception {}
