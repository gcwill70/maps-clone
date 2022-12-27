import 'package:flutter_test/flutter_test.dart';
import 'package:profile_api/profile_api.dart';

void main() {
  group('Map de/serialization', () {
    const Map<String, dynamic> serialized = {
      "id": "fed89b8a0",
      "email": "test@email.com",
    };
    final deserialized = Profile(
      (p0) => p0
        ..id = serialized["id"]
        ..email = serialized["email"],
    );

    test('can be serialized', () {
      expect(deserialized.toMap(), serialized);
    });

    test('can be deserialized', () {
      expect(Profile.fromMap(serialized), deserialized);
    });
  });
}
