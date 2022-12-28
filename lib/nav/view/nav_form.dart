import 'package:common_api/common_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_clone/assets/assets.dart';
import 'package:maps_clone/location/location.dart';
import 'package:maps_clone/location_search/location_search.dart';

import '../bloc/nav_bloc.dart';

class NavForm extends StatelessWidget {
  const NavForm({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        final location =
            BlocProvider.of<LocationBloc>(context).state.locationData;
        BlocProvider.of<NavBloc>(context)
            .add(NavStartChangedEvent(GeoPoint((b) => b
              ..latitude = location!.latitude
              ..longitude = location.longitude)));
        return const NavForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Text('FROM', style: Theme.of(context).textTheme.bodyMedium),
              OutlinedButton(
                  child: const Text('Your Location'), onPressed: () {}),
              const SizedBox(height: 20),
              Text('TO', style: Theme.of(context).textTheme.bodyMedium),
              BlocProvider(
                create: (context) => LocationSearchBloc(
                  apiKey: RepositoryProvider.of<AssetsRepository>(context)
                      .mapEnv['GOOGLE_MAPS_KEY']!,
                ),
                child: BlocConsumer<LocationSearchBloc, LocationSearchState>(
                  listener: (context, state) {
                    if (state is LocationSearchPlaceId) {
                      BlocProvider.of<LocationSearchBloc>(context)
                          .add(LocationSearchDetailsRequest(state.placeId));
                    } else if (state is LocationSearchDetails) {
                      final location = state.details.geometry!.location;
                      BlocProvider.of<NavBloc>(context)
                          .add(NavEndChangedEvent(GeoPoint((b) => b
                            ..latitude = location.lat
                            ..longitude = location.lng)));
                    }
                  },
                  builder: (context, state) {
                    String prompt = 'Select a Location...';
                    if (state is LocationSearchDetails) {
                      prompt = state.details.name;
                    }
                    return OutlinedButton(
                      child: Text(prompt),
                      onPressed: () {
                        Navigator.push(
                          context,
                          LocationSearchView.route(
                            lsBloc:
                                BlocProvider.of<LocationSearchBloc>(context),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: state.start != null && state.end != null
                    ? () {
                        BlocProvider.of<NavBloc>(context)
                            .add(NavGetRouteEvent());
                        Navigator.pop(context);
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.navigation),
                    Text('Go'),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
