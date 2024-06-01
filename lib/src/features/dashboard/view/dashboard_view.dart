import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:weathered/src/features/forecast/data/api_call_weekly.dart';
import 'package:weathered/src/features/map/provider/location_provider.dart';
import 'package:weathered/src/utils/style.dart';

import '../../../core/components/common.dart';
import '../components/weather_attribute.dart';
import '../data/api_call.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DashBoardState();
}

var logger1 = Logger();

class DashBoardState extends ConsumerState<DashBoard> {
  //for overlay of the more info on weather
  void _showMoreDetails(BuildContext context, dynamic weatherData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "More Details",
            style: AppStyle.textTheme.titleSmall,
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.water_drop_rounded,
                          attribute: "Humidity",
                          value: weatherData['Humidity'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.brightness_high_sharp,
                          attribute: "UV Index",
                          value: weatherData['UVIndex'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.sunny,
                          attribute: "Sunrise",
                          value: weatherData['Sunrise'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.cloud,
                          attribute: "Cloud %",
                          value: weatherData['Cloud %'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.tire_repair_rounded,
                          attribute: "Pressure",
                          value: weatherData['Pressure'],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.air_rounded,
                          attribute: "Wind Speed",
                          value: weatherData['WindSpeed'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.thermostat_rounded,
                          attribute: " Feels like ",
                          value: weatherData['FeelsLike'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.wb_twilight_rounded,
                          attribute: "Sunset",
                          value: weatherData['Sunset'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.visibility_rounded,
                          attribute: "Visiblity",
                          value: weatherData['Visiblity'],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
                        child: weatherAttributeBox(
                          context,
                          icon: Icons.umbrella_rounded,
                          attribute: "Rain",
                          value: weatherData['Rain'],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locationNotifier = ref.watch(locationProvider.notifier);
    final currentWeatherData = ref.watch(currentWeatherDataProvider);
    final hourlyWeatherData = ref.watch(weeklyWeatherDataProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            currentWeatherData.when(
              data: (data) {
                logger1.i(data);
                return Column(
                  children: [
                    const Gap(8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.red,
                        ),
                        Text(
                          "Current Location",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const Gap(8),
                    // TODO: Display City Name from Geocoding
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bhopal, MP",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Today',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    const Gap(18),
                    Column(
                      children: [
                        MatContainer.primary(
                          context: context,
                          topPad: 24,
                          bottomPad: 32,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "https://openweathermap.org/img/wn/${data.weather[0].icon}@4x.png",
                                    // height: 300,
                                  ),
                                  const Gap(16),
                                ],
                              ),
                              Text(
                                "${data.main.temp.toStringAsFixed(0)} °C",
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                              Text(
                                data.weather[0].main,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MatContainer1.primary(
                          context: context,
                          height: 205,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: weatherAttribute(
                                          context,
                                          icon: Icons.water_drop_rounded,
                                          attribute: "Humidity",
                                          value: "${data.main.humidity} %",
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 12.0, 12.0, 4.0),
                                        child: weatherAttribute(
                                          context,
                                          icon: Icons.brightness_high_sharp,
                                          attribute: "UV Index",
                                          value: "3",
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: weatherAttribute(
                                          context,
                                          icon: Icons.air_rounded,
                                          attribute: "Wind Speed",
                                          value: data.wind.speed.toString(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 12.0, 12.0, 4.0),
                                        child: weatherAttribute(
                                          context,
                                          icon: Icons.thermostat_rounded,
                                          attribute: " Feels like ",
                                          value:
                                              "${data.main.feelsLike.round().toString()}°C",
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                  iconSize: 35.0,
                                  onPressed: () {
                                    _showMoreDetails(context, {
                                      'iconCode': data.weather[0].icon,
                                      'temp':
                                          "${data.main.temp.toStringAsFixed(0)} °C",
                                      'description': data.weather[0].main,
                                      'Humidity': "${data.main.humidity} %",
                                      'WindSpeed': data.wind.speed.toString(),
                                      'UVIndex': "3",
                                      'FeelsLike':
                                          "${data.main.feelsLike.round().toString()}°C",
                                      'Sunrise': "1",
                                      'Sunset': "2",
                                      'Cloud %':
                                          "${data.clouds.all.toString()}%",
                                      'Visiblity':
                                          "${data.visibility.toString()} m",
                                      'Rain': data.rain?.h ?? "No Rain",
                                      'Pressure': "${data.main.pressure} Pa"
                                    });
                                  },
                                  icon: const Icon(
                                      Icons.arrow_drop_down_outlined))
                            ],
                          ),
                        ),
                        const Gap(8),
                      ],
                    ),
                  ],
                );
              },
              error: (error, stackTrace) {
                logger1.e(error, error: error, stackTrace: stackTrace);
                return Center(
                  child: Text(
                    'Error : $error',
                    textAlign: TextAlign.center,
                  ),
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),

            //for hourly forecast
            MatContainer.primary(
              context: context,
              child: Column(
                children: [
                  const Text(
                    "3 Hourly Forecast",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  const Gap(8),
                  SizedBox(
                      height: 200, // Adjust the height as needed
                      child: hourlyWeatherData.when(data: (data) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            //Time Formatter
                            DateTime date =
                                DateTime.parse(data.list[index].dtTxt);
                            String formattedDate =
                                DateFormat.MMMMd('en_US').format(date);
                            String formattedTime = DateFormat.jm().format(date);

                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                // color: Colors.blue
                              ),

                              width: 150, // Adjust the width as needed
                              margin: const EdgeInsets.all(5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(formattedDate),
                                  Text(formattedTime),
                                  Image.network(
                                      "https://openweathermap.org/img/wn/${data.list[index].weather[0].icon}@2x.png"),
                                  Text(
                                      "${data.list[index].main.temp.toStringAsFixed(0)}°C")
                                ],
                              ),
                            );
                          },
                        );
                      }, error: (error, stackTrace) {
                        logger1.e(error, error: error, stackTrace: stackTrace);
                        return Center(
                          child: Text(
                            'Error : $error',
                            textAlign: TextAlign.center,
                          ),
                        );
                      }, loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })),
                ],
              ),
            ),
            const Gap(8)
          ],
        ),
      ),
    );
  }
}
