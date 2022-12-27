import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:maps_clone/core/core.dart';
import 'package:maps_clone/home/home.dart';
import 'package:maps_clone/location/location.dart';

class LocationViewController extends StatelessWidget {
  const LocationViewController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        // TODO: use BlocConsumer to add events
        final locationBloc = BlocProvider.of<LocationBloc>(context);
        if (state.status == null) {
          locationBloc.add(LocationPermissionRequested());
          return const LoadingView();
        } else if (state.status == PermissionStatus.granted) {
          if (state.locationData != null) {
            return const HomePage();
          } else {
            return const LoadingView();
          }
        } else {
          return const Center(
            child: Text('Error getting location permission'),
          );
        }
      },
    );
  }
}
