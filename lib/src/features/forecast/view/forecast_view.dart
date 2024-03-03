import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/components/common.dart';
import '../../../utils/style.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(8),
          Center(
            child: Text(
              'Forecast',
              style: AppStyle.textTheme.titleLarge,
            ),
          ),
          const Gap(8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return MatContainer.primary(
                      context: context,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    forecastData[index][0],
                                    style: AppStyle.textTheme.titleSmall,
                                  ),
                                  Text(forecastData[index][1]),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                // Replace this with a svg definer based on what data is supplied by the api
                                SvgPicture.asset(
                                  "assets/icons/weather/heavyrain_thunder.svg",
                                  height: 64,
                                ),
                                const Gap(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(forecastData[index][2]),
                                    Text(forecastData[index][3]),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Demo Data
// TODO: Replace Fake Data with API Data
List<List<String>> forecastData = [
  ["Nov 17", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 18", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 19", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 20", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 21", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 22", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 23", "Partly Cloudy", "35°C", "37°C"],
];
