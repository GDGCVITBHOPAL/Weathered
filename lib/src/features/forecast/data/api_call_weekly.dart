import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../map/provider/location_provider.dart';
import '../model/weekly_model_generated.dart';
import 'weekly_weather_repository.dart';

var logger = Logger();

final weeklyWeatherDataProvider = FutureProvider<WeeklyWeather>((ref) async {
  return await ref.watch(weeklylocWeatherDataProvider).getWeeklyWeatherData();
});

final weeklylocWeatherDataProvider =
    Provider<WeeklyWeatherDataRepository>((ref) {
  final coords = ref.watch(locationProvider).coords;
  logger.i("Position from weatherDataProvider : $coords");
  return WeeklyWeatherDataRepository(
      coords: LatLng(coords.latitude, coords.longitude));
});
