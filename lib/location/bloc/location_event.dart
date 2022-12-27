part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationPermissionRequested extends LocationEvent {}

class LocationChangedEvent extends LocationEvent {
  final LocationData locationData;

  const LocationChangedEvent(this.locationData);
}

class LocationErrorEvent extends LocationEvent {}
