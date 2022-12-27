import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_clone/assets/assets_repository.dart';
import 'package:maps_clone/location/location.dart';

import '../bloc/map_bloc.dart';

class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<MapBloc>(context);
        final location =
            BlocProvider.of<LocationBloc>(context).state.locationData;
        return GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          tiltGesturesEnabled: state.tiltGesturesEnabled ?? true,
          zoomGesturesEnabled: state.zoomGesturesEnabled ?? true,
          scrollGesturesEnabled: state.scrollGesturesEnabled ?? true,
          rotateGesturesEnabled: state.rotateGesturesEnabled ?? true,
          initialCameraPosition: CameraPosition(
            zoom: 15,
            target: LatLng(location!.latitude!, location.longitude!),
          ),
          onMapCreated: (GoogleMapController controller) async {
            bloc
              ..add(MapControllerCreatedEvent(controller))
              ..add(MapStyleChangeEvent(
                  RepositoryProvider.of<AssetsRepository>(context)
                      .mapStyles['assets/map_styles/dark.json']))
              ..add(MapBoundsChangeEvent(await controller.getVisibleRegion()));
          },
          markers: state.markers ?? const <Marker>{},
          polylines: state.polylines ?? const <Polyline>{},
          onCameraMove: (poisiton) async {
            bloc.add(MapBoundsChangeEvent(
                await bloc.state.controller!.getVisibleRegion()));
          },
        );
      },
    );
  }
}
