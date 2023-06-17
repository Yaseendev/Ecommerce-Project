import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationResult {
  final LatLng position;
  final String displayPlace;

  LocationResult({
    required this.position,
    required this.displayPlace,
  });

  factory LocationResult.fromJson(Map<String, dynamic> responseData) {
    return LocationResult(
      displayPlace: responseData['display_place'] ?? '',
      position: LatLng(
        double.parse(responseData['lat'].toString()),
        double.parse(responseData['lon'].toString()),
      ),
    );
  }
}
