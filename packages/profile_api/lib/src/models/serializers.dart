import 'package:built_value/serializer.dart';
import 'package:profile_api/src/models/profile.dart';

part 'serializers.g.dart';

@SerializersFor([
  Profile,
])
final Serializers serializers = _$serializers;
