import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

part 'location_search_event.dart';
part 'location_search_state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final String apiKey;

  LocationSearchBloc({required this.apiKey}) : super(LocationSearchIdle()) {
    on<LocationSearchPredictionsRequest>((event, emit) async {
      emit(LocationSearchWorking());
      try {
        final response =
            await GoogleMapsPlaces(apiKey: apiKey).autocomplete(event.query);
        emit(LocationSearchPredictions(response.predictions));
      } catch (e) {
        emit(LocationSearchError());
      }
    });
    on<LocationSearchDetailsRequest>((event, emit) async {
      emit(LocationSearchWorking());
      try {
        final response = await GoogleMapsPlaces(apiKey: apiKey)
            .getDetailsByPlaceId(event.placeId);
        emit(LocationSearchDetails(response.result));
      } catch (e) {
        emit(LocationSearchError());
      }
    });
    on<LocationSearchPlaceIdRequest>(((event, emit) async {
      emit(LocationSearchWorking());
      try {
        final response = await GoogleMapsGeocoding(apiKey: apiKey)
            .searchByLocation(event.location);
        emit(LocationSearchPlaceId(response.results[0].placeId));
      } catch (e) {
        emit(LocationSearchError());
      }
    }));
  }
}
