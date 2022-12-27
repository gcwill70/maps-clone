import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'geopoint.g.dart';

abstract class GeoPoint implements Built<GeoPoint, GeoPointBuilder> {
  double get latitude;
  double get longitude;

  GeoPoint._();

  factory GeoPoint([void Function(GeoPointBuilder) updates]) = _$GeoPoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(GeoPointBuilder b) => b
    ..latitude = 0
    ..longitude = 0;

  static Serializer<GeoPoint> get serializer => _$geoPointSerializer;
}
