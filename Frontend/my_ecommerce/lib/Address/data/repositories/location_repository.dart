import 'package:geolocator/geolocator.dart';
import 'package:my_ecommerce/Utils/services/location_service.dart';

class LocationRepository {
  late final LocationService _locationService;

  LocationRepository({
    required LocationService locationService,
  }) {
    this._locationService = locationService;
  }

  Future<Position?> getCurrentPosition() async {
    try {
      return await _locationService.determinePosition();
    } catch (e) {
      return null;
    }
  }

  Future<bool> isServiceEnable() async {
    return await _locationService.checkLocationServiceEnabled();
  }

  Future<bool> openLocationSettings() async =>
      await _locationService.openSettings();

}