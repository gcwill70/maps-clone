part of 'location_bloc.dart';

class LocationState extends Equatable {
  final PermissionStatus? status;
  final LocationData? locationData;

  const LocationState({
    this.status,
    this.locationData,
  });

  @override
  List<Object?> get props => [status, locationData];

  LocationState copyWith(
      {PermissionStatus? status, LocationData? locationData}) {
    return LocationState(
      status: status ?? this.status,
      locationData: locationData ?? this.locationData,
    );
  }
}
