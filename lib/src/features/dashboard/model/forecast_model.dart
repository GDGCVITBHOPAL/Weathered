import 'package:weathered/src/features/dashboard/model/current_model.dart';

class ForecastModel {
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final DateTime datetime;

  ForecastModel({
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.datetime,
  });

  Map<String, dynamic> toJson() => {
        "main": main.toJson(),
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "clouds": clouds.toJson(),
        "wind": wind.toJson(),
        "visibility": visibility,
        "dt_txt": datetime.toIso8601String(),
      };

  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        main: Main.fromJson(json["main"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        clouds: Clouds.fromJson(json["clouds"]),
        wind: Wind.fromJson(json["wind"]),
        visibility: json["visibility"],
        datetime: DateTime.parse(json["dt_txt"]) ,
      );
  
}
