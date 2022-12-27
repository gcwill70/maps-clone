import 'package:profile_api/src/models/profile.dart';

abstract class ProfileApi {
  const ProfileApi();

  Future<Profile> getProfile(String id);

  Future<void> saveProfile(Profile profile);
}

class ProfileNotFoundException implements Exception {
  final String id;
  ProfileNotFoundException(this.id);
}

class ProfileApiException implements Exception {}
