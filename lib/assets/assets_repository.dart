import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AssetsRepository {
  final Map<String, BitmapDescriptor?> bitmapDescriptors = {};

  final Map<String, String?> mapStyles = {
    'assets/map_styles/dark.json': null,
  };

  final Map<String, Widget?> svgWidgets = {};

  final Map<String, String?> mapEnv = {};
}
