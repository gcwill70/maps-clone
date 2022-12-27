import 'package:bloc/bloc.dart';
import 'package:common_api/common_api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:maps_clone/core/core.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  final String apiKey;

  NavBloc({required this.apiKey}) : super(const NavState()) {
    on<NavStartChangedEvent>(((event, emit) {
      emit(state.copyWith(start: event.start, points: null));
    }));
    on<NavEndChangedEvent>(((event, emit) {
      emit(state.copyWith(end: event.end, points: null));
    }));
    on<NavGetRouteEvent>((event, emit) async {
      if (state.status == NavStatus.idle) {
        try {
          // TODO: change to use google_maps_webservice
          emit(state.copyWith(status: NavStatus.calculating));
          PolylinePoints points = PolylinePoints();
          PolylineResult result = await points.getRouteBetweenCoordinates(
            apiKey,
            PointLatLng(state.start!.latitude, state.start!.longitude),
            PointLatLng(state.end!.latitude, state.end!.longitude),
            avoidHighways: true,
          );
          emit(state.copyWith(status: NavStatus.idle, points: result.points));
        } catch (e) {
          emit(state.copyWith(status: NavStatus.error));
        }
      }
    });
  }
}
