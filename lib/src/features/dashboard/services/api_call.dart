// ignore_for_file: non_constant_identifier_names
// TODO: The api key is to be removed and uncomment the import api/api_key.dart

import 'dart:convert';
// import '../../../api/api_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathered/src/features/dashboard/model/current_model.dart';
import 'package:http/http.dart' as http;

final CurrentWeatherRepositoryProvider =
    Provider((ref) => CurrentWeatherRepository());

class CurrentWeatherRepository {
  String apiKey = "b811e375e46ccd83825fb9cb2d9813da";
  Future<CurrentWeather> fetchWeatherData() async {
    String url =
        "https://api.openweathermap.org/data/2.5/weather?lat=25.612241&lon=85.066646&units=metric&appid=$apiKey";
    return http.get(Uri.parse(url)).then((http.Response response) {
      if (response.statusCode == 200) {
        // If the response is successful, parse the data and return a CurrentWeather object
        return CurrentWeather.fromJson(json.decode(response.body));
      } else {
        const SnackBar(content: Text("Failed to load weather data"));
        // If the response is not successful, throw an exception or handle the error accordingly
        throw Exception('Failed to load weather data');
      }
    });
  }
}
