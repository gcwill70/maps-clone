import 'package:auth_api/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthApi implements AuthApi {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthApi({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<AuthUser?> authenticate(AuthProvider provider) async {
    try {
      if (provider == AuthProvider.anon) {
        return await _authAnon();
      } else if (provider == AuthProvider.google) {
        return await _authGoogle();
      } else {
        throw AuthException();
      }
    } catch (e) {
      throw AuthException();
    }
  }

  Future<AuthUser?> _authGoogle() async {
    final gAccount = await GoogleSignIn().signIn();
    final gAuth = await gAccount!.authentication;
    final gCredential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    final credential = await _firebaseAuth.signInWithCredential(gCredential);
    return _firebaseUserToAuthUser(credential.user);
  }

  Future<AuthUser?> _authAnon() async {
    final credential = await _firebaseAuth.signInAnonymously();
    return _firebaseUserToAuthUser(credential.user);
  }

  @override
  AuthUser? get currentUser {
    return _firebaseUserToAuthUser(_firebaseAuth.currentUser);
  }

  @override
  Future<void> unauthenticate() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw AuthException();
    }
  }

  @override
  Stream<AuthUser?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return _firebaseUserToAuthUser(firebaseUser);
    });
  }

  AuthUser? _firebaseUserToAuthUser(User? firebaseUser) {
    if (firebaseUser == null) {
      return null;
    } else {
      return AuthUser(
        (b) => b
          ..id = firebaseUser.uid
          ..email = firebaseUser.email,
      );
    }
  }
}
