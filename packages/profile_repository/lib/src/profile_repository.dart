import 'package:profile_api/profile_api.dart';

class ProfileRepository {
  const ProfileRepository({
    required api,
  }) : _api = api;

  final ProfileApi _api;

  Future<Profile> getProfile(String id) async {
    return await _api.getProfile(id);
  }

  Future<void> saveProfile(Profile profile) async {
    await _api.saveProfile(profile);
  }
}
