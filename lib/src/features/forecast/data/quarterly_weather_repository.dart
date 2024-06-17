import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../api/api_key.dart';
import '../model/quarterly_model_generated.dart';


class QuarterlyWeatherDataRepository {
  final LatLng coords;
  QuarterlyWeatherDataRepository({required this.coords});

  // get currentWeather Data
  Future<QuarterlyWeather> getQuarterlyWeatherData() async {
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?lat=${coords.latitude}&lon=${coords.longitude}&appid=$apiKey&units=metric&cnt=40";

    return http.get(Uri.parse(url)).then((http.Response response) {
      if (response.statusCode == 200) {
        // If the response is successful, parse the data and return a QuarterlyWeather object
        return QuarterlyWeather.fromJson(json.decode(response.body));
      } else {
        const SnackBar(content: Text("Failed to load weather data"));
        // If the response is not successful, throw an exception or handle the error accordingly
        throw Exception('Failed to load weather data');
      }
    });
  }
}
