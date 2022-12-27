part of 'map_bloc.dart';

class MapState extends Equatable {
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final GoogleMapController? controller;
  final LatLngBounds? bounds;
  final String? mapStyle;
  final bool? tiltGesturesEnabled;
  final bool? zoomGesturesEnabled;
  final bool? scrollGesturesEnabled;
  final bool? rotateGesturesEnabled;

  const MapState({
    this.controller,
    this.markers,
    this.polylines,
    this.bounds,
    this.mapStyle,
    this.tiltGesturesEnabled,
    this.zoomGesturesEnabled,
    this.scrollGesturesEnabled,
    this.rotateGesturesEnabled,
  });

  @override
  List<Object?> get props => [
        markers,
        polylines,
        controller,
        bounds,
        mapStyle,
        tiltGesturesEnabled,
        zoomGesturesEnabled,
        scrollGesturesEnabled,
        rotateGesturesEnabled,
      ];

  MapState copyWith({
    GoogleMapController? controller,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
    LatLngBounds? bounds,
    String? mapStyle,
    bool? tiltGesturesEnabled,
    bool? zoomGesturesEnabled,
    bool? scrollGesturesEnabled,
    bool? rotateGesturesEnabled,
  }) {
    return MapState(
      controller: controller ?? this.controller,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      bounds: bounds ?? this.bounds,
      mapStyle: mapStyle ?? this.mapStyle,
      tiltGesturesEnabled: tiltGesturesEnabled ?? this.tiltGesturesEnabled,
      zoomGesturesEnabled: zoomGesturesEnabled ?? this.zoomGesturesEnabled,
      scrollGesturesEnabled:
          scrollGesturesEnabled ?? this.scrollGesturesEnabled,
      rotateGesturesEnabled:
          rotateGesturesEnabled ?? this.rotateGesturesEnabled,
    );
  }
}
