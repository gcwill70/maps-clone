import 'package:common_api/common_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_clone/map/map.dart';
import 'package:maps_clone/nav/nav.dart';
import 'package:uuid/uuid.dart';

class HomeMapView extends StatelessWidget {
  const HomeMapView({
    Key? key,
  }) : super(key: key);

  Set<Marker>? mapMarker(GeoPoint? geoPoint, BitmapDescriptor icon) {
    if (geoPoint == null) return null;
    return {
      Marker(
        markerId: MarkerId(const Uuid().v4()),
        icon: icon,
        position: LatLng(geoPoint.latitude, geoPoint.longitude),
      )
    };
  }

  Set<Polyline>? mapPolyline(List<PointLatLng>? points) {
    if (points == null) return null;
    return {
      Polyline(
        polylineId: PolylineId(const Uuid().v4()),
        points: points.map((x) => LatLng(x.latitude, x.longitude)).toList(),
        width: 3,
        color: Colors.white,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NavBloc, NavState>(
          listener: (context, state) {
            final messenger = ScaffoldMessenger.of(context);
            if (state.status == NavStatus.calculating) {
              messenger
                ..clearSnackBars()
                ..showSnackBar(
                  const SnackBar(content: Text('Getting directions...')),
                );
            } else if (state.status == NavStatus.error) {
              messenger
                ..clearSnackBars()
                ..showSnackBar(
                  const SnackBar(content: Text('Error getting directions')),
                );
            } else {
              messenger.clearSnackBars();
              if (state.points != null) {
                BlocProvider.of<MapBloc>(context)
                  ..add(
                    MapParamsChangeEvent(
                      markers: {
                        ...?mapMarker(
                          state.start,
                          BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueOrange,
                          ),
                        ),
                        ...?mapMarker(
                          state.end,
                          BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueRed,
                          ),
                        ),
                      },
                      polylines: {
                        ...?mapPolyline(state.points),
                      },
                      tiltGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                    ),
                  )
                  ..add(MapAutoZoomEvent());
              }
            }
          },
        ),
      ],
      child: const MapView(),
    );
  }
}
