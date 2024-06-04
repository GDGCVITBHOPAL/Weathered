import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../model/current_model.dart';
import '../model/forecast_model.dart';

var logger = Logger();

class WeatherDataRepository {
  //TODO : Remove API Key
  String apiKey = "b811e375e46ccd83825fb9cb2d9813da";
  final LatLng coords;
  WeatherDataRepository({required this.coords});

  // get currentWeather Data
  Future<CurrentWeatherModel> getCurrentWeatherData() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=${coords.latitude}&lon=${coords.longitude}&units=metric&appid=$apiKey";

    return http.get(Uri.parse(url)).then((http.Response response) {
      logger.i(response.body);
      if (response.statusCode == 200) {
        // If the response is successful, parse the data and return a CurrentWeatherModel object
        return CurrentWeatherModel.fromJson(json.decode(response.body));
      } else {
        const SnackBar(content: Text("Failed to load weather data"));
        // If the response is not successful, throw an exception or handle the error accordingly
        throw Exception('Failed to load weather data');
      }
    });
  }

  Future<ForecastModel> getForecastData() async {
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?lat=${coords.latitude}&lon=${coords.longitude}&units=metric&appid=$apiKey";
    return http.get(Uri.parse(url)).then((http.Response response) {
      logger.i(response);
      if (response.statusCode == 200) {
        // If the response is successful, parse the data and return a CurrentWeatherModel object
        return ForecastModel.fromJson(json.decode(response.body));
      } else {
        const SnackBar(content: Text("Failed to load Forecast data"));
        // If the response is not successful, throw an exception or handle the error accordingly
        throw Exception('Failed to load Forecast data');
      }
    });
  }
}
