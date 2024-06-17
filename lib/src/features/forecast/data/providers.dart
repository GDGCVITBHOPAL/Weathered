import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../map/provider/location_provider.dart';
import '../model/quarterly_model_generated.dart';
import 'quarterly_weather_repository.dart';


final quarterlyWeatherDataProvider = FutureProvider<QuarterlyWeather>((ref) async {
  return await ref.watch(quarterlyWeatherDataRepoProvider).getQuarterlyWeatherData();
});

final quarterlyWeatherDataRepoProvider =
    Provider<QuarterlyWeatherDataRepository>((ref) {
  final coords = ref.watch(locationProvider).coords;
  return QuarterlyWeatherDataRepository(
      coords: LatLng(coords.latitude, coords.longitude));
});
