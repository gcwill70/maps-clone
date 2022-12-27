part of 'location_search_bloc.dart';

abstract class LocationSearchEvent extends Equatable {
  const LocationSearchEvent();

  @override
  List<Object> get props => [];
}

class LocationSearchPredictionsRequest extends LocationSearchEvent {
  final String query;

  const LocationSearchPredictionsRequest(this.query);

  @override
  List<Object> get props => [query];
}

class LocationSearchDetailsRequest extends LocationSearchEvent {
  final String placeId;

  const LocationSearchDetailsRequest(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class LocationSearchPlaceIdRequest extends LocationSearchEvent {
  final Location location;

  const LocationSearchPlaceIdRequest(this.location);

  @override
  List<Object> get props => [location];
}
