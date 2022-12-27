import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'auth_user.dart';

part 'serializers.g.dart';

@SerializersFor(
  [AuthUser],
)
final Serializers serializers = _$serializers;
final standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
