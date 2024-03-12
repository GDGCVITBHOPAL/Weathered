import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:weathered/main.dart';

import '../../../core/components/common.dart';
import '../components/weather_attribute.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(fetchCurrentWeatherProvider).when(data: (data) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
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
                        "${data.main.temp.round()} °C",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        data.weather[0].main,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      )
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
    }, error: (error, StackTrace) {
      // print(error);
      return Scaffold(body: Center(child: Text(error.toString())));
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
