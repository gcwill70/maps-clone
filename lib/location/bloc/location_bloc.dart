import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late final Location _location;

  LocationBloc() : super(const LocationState()) {
    _location = Location();
    _location.onLocationChanged.listen((location) {
      add(LocationChangedEvent(location));
    }, onError: (obj) {
      add(LocationErrorEvent());
    });
    on<LocationPermissionRequested>((event, emit) async {
      try {
        final status = await _location.requestPermission();
        emit(state.copyWith(status: status));
      } catch (_) {
        emit(const LocationState());
      }
    });
    on<LocationChangedEvent>((event, emit) {
      emit(state.copyWith(locationData: event.locationData));
    });
    on<LocationErrorEvent>((event, emit) {
      emit(const LocationState().copyWith(status: state.status));
    });
  }
}
