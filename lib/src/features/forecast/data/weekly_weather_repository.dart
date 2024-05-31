import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:weathered/src/features/forecast/model/weekly_model_generated.dart';

var logger = Logger();

class WeeklyWeatherDataRepository {
  //TODO : Remove API Key
  String apiKey = "b811e375e46ccd83825fb9cb2d9813da";
  final LatLng coords;
  WeeklyWeatherDataRepository({required this.coords});

  // get currentWeather Data
  Future<WeeklyWeather> getWeeklyWeatherData() async {
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?lat=25.612241&lon=85.066646&appid=b811e375e46ccd83825fb9cb2d9813da&units=metric&cnt=40";

    return http.get(Uri.parse(url)).then((http.Response response) {
      logger.i(response.body);
      if (response.statusCode == 200) {
        // If the response is successful, parse the data and return a WeeklyWeather object
        return WeeklyWeather.fromJson(json.decode(response.body));
      } else {
        const SnackBar(content: Text("Failed to load weather data"));
        // If the response is not successful, throw an exception or handle the error accordingly
        throw Exception('Failed to load weather data');
      }
    });
  }
}
