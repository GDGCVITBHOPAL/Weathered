import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathered/src/features/dashboard/data/weather_repository.dart';

final fakeP = Position(
  longitude: 77.412613,
  latitude: 23.259933,
  timestamp: DateTime.now(),
  accuracy: 10.0,
  altitude: 100.0,
  altitudeAccuracy: 5.0,
  heading: 90.0,
  headingAccuracy: 2.0,
  speed: 20.0,
  speedAccuracy: 1.0,
);

class LocationNotifier extends StateNotifier<Position> {
  LocationNotifier() : super(fakeP);

  void updateLocation() async {
    try {
      state = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      return Future.error("Failed to get location: $e");
    }
  }

  Future<List<Placemark>> getCity(Position position) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      logger.i(placemarks);
      return placemarks;
    } catch (e) {
      return [];
    }
  }
}

final locationProvider = StateNotifierProvider<LocationNotifier, Position>(
    (ref) => LocationNotifier());

class PermissionNotifier extends StateNotifier<bool> {
  PermissionNotifier() : super(false);

  Future<bool> getPerms() async {
    bool locationService = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (locationService == true && permission != LocationPermission.denied) {
      return true;
    } else {
      return false;
    }
  }
}

final permissionProvider = StateNotifierProvider<PermissionNotifier, bool>(
    (ref) => PermissionNotifier());
