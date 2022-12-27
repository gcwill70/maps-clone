import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
    on<MapParamsChangeEvent>((event, emit) {
      emit(state.copyWith(
        markers: event.markers,
        polylines: event.polylines,
        tiltGesturesEnabled: event.tiltGesturesEnabled,
        zoomGesturesEnabled: event.zoomGesturesEnabled,
        scrollGesturesEnabled: event.scrollGesturesEnabled,
        rotateGesturesEnabled: event.rotateGesturesEnabled,
      ));
    });
    on<MapControllerCreatedEvent>((event, emit) {
      emit(state.copyWith(controller: event.controller));
    });
    on<MapBoundsChangeEvent>((event, emit) {
      emit(state.copyWith(bounds: event.bounds));
    });
    on<MapStyleChangeEvent>((event, emit) async {
      if (state.controller != null) {
        await state.controller!.setMapStyle(event.mapStyle);
        emit(state.copyWith(mapStyle: event.mapStyle));
      }
    });
    on<MapAutoZoomEvent>(((event, emit) {
      Iterable<LatLng> positions = <LatLng>[
        ...?state.markers?.map((e) => e.position),
        ...?state.polylines?.expand(
            (e) => e.points.map((e) => LatLng(e.latitude, e.longitude)))
      ];
      if (positions.length > 1) {
        state.controller!.moveCamera(CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(
              positions.map((e) => e.latitude).reduce((a, b) => min(a, b)),
              positions.map((e) => e.longitude).reduce((a, b) => min(a, b)),
            ),
            northeast: LatLng(
              positions.map((e) => e.latitude).reduce((a, b) => max(a, b)),
              positions.map((e) => e.longitude).reduce((a, b) => max(a, b)),
            ),
          ),
          40,
        ));
      }
    }));
  }
}
