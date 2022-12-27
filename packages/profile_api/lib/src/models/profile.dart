import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:profile_api/src/models/serializers.dart';

part 'profile.g.dart';

abstract class Profile implements Built<Profile, ProfileBuilder> {
  String get id;

  String? get email;

  Profile._();

  factory Profile([void Function(ProfileBuilder) updates]) = _$Profile;

  Map<String, dynamic> toMap() {
    return (serializers.toBuilder()..addPlugin(StandardJsonPlugin()))
        .build()
        .serializeWith(Profile.serializer, this) as Map<String, dynamic>;
  }

  static Profile? fromMap(Map<String, dynamic>? object) {
    return (serializers.toBuilder()..addPlugin(StandardJsonPlugin()))
        .build()
        .deserializeWith(Profile.serializer, object);
  }

  static Serializer<Profile> get serializer => _$profileSerializer;
}
