import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:weathered/src/features/forecast/model/quarterly_model_generated.dart';

import '../../map/provider/location_provider.dart';
import 'quarterly_weather_repository.dart';

var logger = Logger();

final quarterlyWeatherDataProvider = FutureProvider<QuarterlyWeather>((ref) async {
  return await ref.watch(quarterlyWeatherDataRepoProvider).getQuarterlyWeatherData();
});

final quarterlyWeatherDataRepoProvider =
    Provider<QuarterlyWeatherDataRepository>((ref) {
  final coords = ref.watch(locationProvider).coords;
  return QuarterlyWeatherDataRepository(
      coords: LatLng(coords.latitude, coords.longitude));
});
