// ignore_for_file: non_constant_identifier_names
// TODO: The api key is to be removed and uncomment the import api/api_key.dart

import 'dart:convert';
// import '../../../api/api_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathered/src/features/dashboard/model/current_model.dart';
import 'package:http/http.dart' as http;

final CurrentWeatherDataProvider = FutureProvider((ref) async {
  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print(":position is $position");
  final currentWeatherRepository = CurrentWeatherRepository();
  return currentWeatherRepository.fetchWeatherData(position: position);
});

class CurrentWeatherRepository {
  String apiKey = "b811e375e46ccd83825fb9cb2d9813da";
  Future<CurrentWeather> fetchWeatherData({required Position position}) async {
    try {
      final lat = position.latitude;
      final long = position.longitude;
      String url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&appid=$apiKey";

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
    } catch (e) {
      throw "Error is in Repo";
    }
  }
}
