// ignore_for_file: file_names
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weathered/src/features/search/model/modelClassCity.dart';

final String apikey = "b811e375e46ccd83825fb9cb2d9813da";

final cityWeatherProvider =
    FutureProvider.family<CityWeatherModel, String>((ref, city) async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apikey'));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return CityWeatherModel.fromJson(json);
  } else {
    throw Exception('Failed to load weather data');
  }
});
