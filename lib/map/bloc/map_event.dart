part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

class MapParamsChangeEvent extends MapEvent {
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final bool? tiltGesturesEnabled;
  final bool? zoomGesturesEnabled;
  final bool? scrollGesturesEnabled;
  final bool? rotateGesturesEnabled;

  const MapParamsChangeEvent({
    this.markers,
    this.polylines,
    this.tiltGesturesEnabled,
    this.zoomGesturesEnabled,
    this.scrollGesturesEnabled,
    this.rotateGesturesEnabled,
  });

  @override
  List<Object?> get props => [
        markers,
        polylines,
        tiltGesturesEnabled,
        zoomGesturesEnabled,
        scrollGesturesEnabled,
        rotateGesturesEnabled,
      ];
}

class MapControllerCreatedEvent extends MapEvent {
  final GoogleMapController controller;

  const MapControllerCreatedEvent(this.controller);

  @override
  List<Object?> get props => [controller];
}

class MapBoundsChangeEvent extends MapEvent {
  final LatLngBounds bounds;

  const MapBoundsChangeEvent(this.bounds);

  @override
  List<Object?> get props => [bounds];
}

class MapStyleChangeEvent extends MapEvent {
  final String? mapStyle;

  const MapStyleChangeEvent(this.mapStyle);

  @override
  List<Object?> get props => [mapStyle];
}

class MapAutoZoomEvent extends MapEvent {}

class MapErrorEvent extends MapEvent {}
