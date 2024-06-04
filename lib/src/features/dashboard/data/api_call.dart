import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../map/provider/location_provider.dart';
import '../model/current_model.dart';
import '../model/forecast_model.dart';
import 'weather_repository.dart';

final currentWeatherDataProvider =
    FutureProvider<CurrentWeatherModel>((ref) async {
  return await ref.watch(weatherDataProvider).getCurrentWeatherData();
});

final forecastDataProvider = FutureProvider<ForecastModel>((ref) async {
  return await ref.watch(weatherDataProvider).getForecastData();
});

final weatherDataProvider = Provider<WeatherDataRepository>((ref) {
  final sd = ref.watch(locationProvider).coords;
  print("Position from weatherDataProvider : $sd");
  return WeatherDataRepository(coords: LatLng(sd.latitude, sd.longitude));
});
