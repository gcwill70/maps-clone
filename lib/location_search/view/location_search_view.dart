import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_webservice/places.dart';

import '../bloc/location_search_bloc.dart';

class LocationSearchView extends StatefulWidget {
  const LocationSearchView({Key? key}) : super(key: key);

  static Route<void> route(LocationSearchBloc lsBloc) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider.value(
        value: lsBloc,
        child: const LocationSearchView(),
      ),
    );
  }

  @override
  State<LocationSearchView> createState() => _LocationSearchViewState();
}

class _LocationSearchViewState extends State<LocationSearchView> {
  List<Prediction> predictions = [];

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LocationSearchBloc>(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: BlocListener<LocationSearchBloc, LocationSearchState>(
          listener: (context, state) {
            if (state is LocationSearchPredictions) {
              setState(() => predictions = state.predictions);
            } else if (state is LocationSearchDetails) {
              Navigator.pop(context);
            } else if (state is LocationSearchError) {
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.clearSnackBars();
              scaffold.showSnackBar(
                  const SnackBar(content: Text('Location search error')));
            }
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: const InputDecoration(labelText: "Search"),
                  onChanged: (value) =>
                      bloc.add(LocationSearchPredictionsRequest(value)),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const CircleAvatar(
                            child: Icon(Icons.pin_drop, color: Colors.white)),
                        title: Text(predictions[index].description ?? ''),
                        onTap: () {
                          bloc.add(LocationSearchDetailsRequest(
                              predictions[index].placeId ?? ''));
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
