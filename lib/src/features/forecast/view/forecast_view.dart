import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weathered/src/features/forecast/data/api_call_weekly.dart';

import '../../../core/components/common.dart';
import '../../../utils/style.dart';

class ForecastView extends ConsumerStatefulWidget {
  const ForecastView({super.key});

  @override
  ConsumerState<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends ConsumerState<ForecastView> {
  void _showWeatherDetails(BuildContext context, dynamic weatherData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Weather Details",
            style: AppStyle.textTheme.titleSmall,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${weatherData['date']}",
                  style: AppStyle.textTheme.titleSmall),
              Image.network(
                  "https://openweathermap.org/img/wn/${weatherData['iconCode']}@4x.png"),
              Text("Maximum: ${weatherData['tempMax']}°C"),
              Text("Minimum: ${weatherData['tempMin']}°C"),
              Text("Description: ${weatherData['description']}"),

              // Add more weather details here
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
    final weeklyforecast = ref.watch(weeklyWeatherDataProvider);
    return Scaffold(
      body: weeklyforecast.when(data: (data) {
        logger.i(data);
        return Column(
          children: [
            const Gap(8),
            Center(
              child: Text(
                'Week Forecast',
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

                    DateTime date =
                        DateTime.parse(data.list[filterIndex].dtTxt);
                    String formattedDate =
                        DateFormat.MMMMd('en_US').format(date);

                    return GestureDetector(
                      onTap: () {
                        _showWeatherDetails(context, {
                          'iconCode': data.list[filterIndex].weather[0].icon,
                          'date': formattedDate,
                          'tempMax': data.list[filterIndex].main.tempMax
                              .toStringAsFixed(0),
                          'tempMin': (data.list[filterIndex].main.tempMin - 5)
                              .toStringAsFixed(0),
                          'description':
                              data.list[filterIndex].weather[0].description,
                        });
                      },
                      child: MatContainer.primary(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formattedDate,
                                        // data.list[filterIndex].dtTxt.substring(0, 10),
                                        style: AppStyle.textTheme.titleSmall,
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
                                        "https://openweathermap.org/img/wn/${data.list[filterIndex].weather[0].icon}@2x.png"),
                                    const Gap(10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                            "${(data.list[filterIndex].main.tempMin - 5).toStringAsFixed(0)}°C"),
                                        Text(
                                            "${data.list[filterIndex].main.tempMax.toStringAsFixed(0)}°C"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
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
