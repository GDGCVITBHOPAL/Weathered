import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:weathered/src/features/map/provider/location_provider.dart';

import '../../../core/components/common.dart';
import '../components/weather_attribute.dart';
import '../data/api_call.dart';
import '../data/weather_repository.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DashBoardState();
}

class DashBoardState extends ConsumerState<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final locationNotifier = ref.watch(locationProvider.notifier);
    final currentWeatherData = ref.watch(currentWeatherDataProvider);
    return Scaffold(
      body: currentWeatherData.when(
        data: (data) {
          logger.i(data);
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
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
                            "${data.main.temp} °C",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                          Text(
                            data.weather[0].main,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MatContainer.primary(
                      context: context,
                      height: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              weatherAttribute(
                                context,
                                icon: Icons.water_drop_rounded,
                                attribute: "Humidity",
                                value: "${data.main.humidity} %",
                              ),
                              weatherAttribute(
                                context,
                                icon: Icons.wb_sunny_rounded,
                                attribute: "UV Index",
                                value: "3",
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              weatherAttribute(
                                context,
                                icon: Icons.air_rounded,
                                attribute: "Wind Speed",
                                value: data.wind.speed.toString(),
                              ),
                              weatherAttribute(
                                context,
                                icon: Icons.thermostat_rounded,
                                attribute: " Feels like ",
                                value:
                                    "${data.main.feelsLike.round().toString()}°C",
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Gap(8),
                  ],
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          logger.e(error, error: error, stackTrace: stackTrace);
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
    );
  }
}
