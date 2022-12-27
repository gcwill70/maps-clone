import 'package:auth_api/auth_api.dart';

class AuthRepository {
  const AuthRepository({required api}) : _api = api;

  final AuthApi _api;

  Stream<AuthUser?> get user => _api.user;

  AuthUser? get currentUser => _api.currentUser;

  Future<void> authenticate(AuthProvider provider) async {
    await _api.authenticate(provider);
  }

  Future<void> unauthenticate() async {
    return await _api.unauthenticate();
  }
}
