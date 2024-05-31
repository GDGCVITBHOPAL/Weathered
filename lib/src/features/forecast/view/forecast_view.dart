import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:weathered/src/features/forecast/data/api_call_weekly.dart';

import '../../../core/components/common.dart';
import '../../../utils/style.dart';

class ForecastView extends ConsumerStatefulWidget {
  const ForecastView({super.key});

  @override
  ConsumerState<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends ConsumerState<ForecastView> {
  @override
  Widget build(BuildContext context) {
    final weeklyforecast = ref.watch(weeklyWeatherDataProvider);
    return Scaffold(
      body: weeklyforecast.when(data: (data) {
        logger.i(data);
        return Column(
          children: [
            const Gap(8),
            Center(
              child: Text(
                'Weekly Forecast',
                style: AppStyle.textTheme.titleLarge,
              ),
            ),
            const Gap(8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final filterIndex = index * 8;
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
                                    SizedBox(
                                      height: 50,
                                      width: 170,
                                      child: Text(
                                        data.list[filterIndex].dtTxt
                                            .substring(0, 10),
                                        style: AppStyle.textTheme.titleSmall,
                                      ),
                                    ),
                                    Text(data.list[filterIndex].weather[0]
                                        .description),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  // Replace this with a svg definer based on what data is supplied by the api
                                  Image.network(
                                    "https://openweathermap.org/img/wn/${data.list[0].weather[0].icon}@2x.png",
                                    // height: 300,
                                  ),
                                  const Gap(10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                          "${data.list[filterIndex].main.tempMin.toStringAsFixed(0)}°C"),
                                      Text(
                                          "${data.list[filterIndex].main.tempMax.toStringAsFixed(0)}°C"),
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
        );
      }, error: (error, stackTrace) {
        logger.e(error, error: error, stackTrace: stackTrace);
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
      }),
    );
  }
}

// Demo Data
// TODO: Replace Fake Data with API Data

List<List<String>> forecastData = [
  ["Nov 17", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 18", "Sunny", "35°C", "37°C"],
  ["Nov 19", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 20", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 21", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 22", "Partly Cloudy", "35°C", "37°C"],
  ["Nov 23", "Partly Cloudy", "35°C", "37°C"],
];
