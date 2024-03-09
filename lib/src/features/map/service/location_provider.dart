import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationProvider = FutureProvider<Position>((ref) async {
  final location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return location;
});

final permissionProvider = FutureProvider<bool>((ref) async {
  bool locationService = await Geolocator.isLocationServiceEnabled();
  LocationPermission permission = await Geolocator.checkPermission();
  if (locationService == true && permission != LocationPermission.denied ) {
    return true;
  } else {
    return false;
  }
});