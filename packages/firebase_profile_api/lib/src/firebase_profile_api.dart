import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profile_api/profile_api.dart';

class FirebaseProfileApi implements ProfileApi {
  final profileCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<Profile> getProfile(String id) async {
    try {
      Map<String, dynamic>? map =
          (await profileCollection.doc(id).get()).data();
      if (map == null) {
        throw ProfileNotFoundException(id);
      } else {
        return Profile.fromMap(map)!;
      }
    } on ProfileNotFoundException {
      rethrow;
    } catch (e) {
      throw ProfileApiException();
    }
  }

  @override
  Future<void> saveProfile(Profile profile) {
    try {
      return profileCollection.doc(profile.id).set(profile.toMap());
    } catch (e) {
      throw ProfileApiException();
    }
  }
}
