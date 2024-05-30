// ignore_for_file: non_constant_identifier_names
// TODO: The api key is to be removed and uncomment the import api/api_key.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weathered/src/features/dashboard/model/current_model.dart';
import 'package:weathered/src/features/map/provider/location_provider.dart';
import '../model/forecast_model.dart';
import 'weather_repository.dart';

final currentWeatherDataProvider =
    FutureProvider<CurrentWeatherModel>((ref) async {
  return await ref.read(weatherDataProvider).getCurrentWeatherData();
});

final forecastDataProvider = FutureProvider<ForecastModel>((ref) async {
  return await ref.read(weatherDataProvider).getForecastData();
});

final weatherDataProvider = Provider<WeatherDataRepository>((ref) {
  final position = ref.watch(locationProvider);
  logger.i("Position from weatherDataProvider : $position");
  return WeatherDataRepository(
      coords: LatLng(position.latitude, position.longitude));
});
