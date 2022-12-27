part of 'location_search_bloc.dart';

abstract class LocationSearchState extends Equatable {
  const LocationSearchState();

  @override
  List<Object?> get props => [];
}

class LocationSearchIdle extends LocationSearchState {}

class LocationSearchWorking extends LocationSearchState {}

class LocationSearchPredictions extends LocationSearchState {
  final List<Prediction> predictions;

  const LocationSearchPredictions(this.predictions);

  @override
  List<Object?> get props => [predictions];
}

class LocationSearchDetails extends LocationSearchState {
  final PlaceDetails details;

  const LocationSearchDetails(this.details);

  @override
  List<Object?> get props => [details];
}

class LocationSearchPlaceId extends LocationSearchState {
  final String placeId;

  const LocationSearchPlaceId(this.placeId);

  @override
  List<Object?> get props => [placeId];
}

class LocationSearchError extends LocationSearchState {}
