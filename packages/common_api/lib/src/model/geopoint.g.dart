// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geopoint.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GeoPoint> _$geoPointSerializer = new _$GeoPointSerializer();

class _$GeoPointSerializer implements StructuredSerializer<GeoPoint> {
  @override
  final Iterable<Type> types = const [GeoPoint, _$GeoPoint];
  @override
  final String wireName = 'GeoPoint';

  @override
  Iterable<Object?> serialize(Serializers serializers, GeoPoint object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'latitude',
      serializers.serialize(object.latitude,
          specifiedType: const FullType(double)),
      'longitude',
      serializers.serialize(object.longitude,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  GeoPoint deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GeoPointBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
      }
    }

    return result.build();
  }
}

class _$GeoPoint extends GeoPoint {
  @override
  final double latitude;
  @override
  final double longitude;

  factory _$GeoPoint([void Function(GeoPointBuilder)? updates]) =>
      (new GeoPointBuilder()..update(updates))._build();

  _$GeoPoint._({required this.latitude, required this.longitude}) : super._() {
    BuiltValueNullFieldError.checkNotNull(latitude, r'GeoPoint', 'latitude');
    BuiltValueNullFieldError.checkNotNull(longitude, r'GeoPoint', 'longitude');
  }

  @override
  GeoPoint rebuild(void Function(GeoPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GeoPointBuilder toBuilder() => new GeoPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GeoPoint &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, latitude.hashCode), longitude.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GeoPoint')
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GeoPointBuilder implements Builder<GeoPoint, GeoPointBuilder> {
  _$GeoPoint? _$v;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GeoPointBuilder() {
    GeoPoint._setDefaults(this);
  }

  GeoPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GeoPoint other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GeoPoint;
  }

  @override
  void update(void Function(GeoPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GeoPoint build() => _build();

  _$GeoPoint _build() {
    final _$result = _$v ??
        new _$GeoPoint._(
            latitude: BuiltValueNullFieldError.checkNotNull(
                latitude, r'GeoPoint', 'latitude'),
            longitude: BuiltValueNullFieldError.checkNotNull(
                longitude, r'GeoPoint', 'longitude'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
