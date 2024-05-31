import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:weathered/src/features/dashboard/data/api_call.dart';
import 'package:weathered/src/features/forecast/data/weekly_weather_repository.dart';
import 'package:weathered/src/features/forecast/model/weekly_model_generated.dart';
import 'package:weathered/src/features/map/provider/location_provider.dart';

var logger = Logger();

final weeklyWeatherDataProvider = FutureProvider<WeeklyWeather>((ref) async {
  return await ref.read(weeklylocWeatherDataProvider).getWeeklyWeatherData();
});

final weeklylocWeatherDataProvider =
    Provider<WeeklyWeatherDataRepository>((ref) {
  final position = ref.watch(locationProvider);
  logger.i("Position from weatherDataProvider : $position");
  return WeeklyWeatherDataRepository(
      coords: LatLng(position.latitude, position.longitude));
});
