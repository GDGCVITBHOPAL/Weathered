import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathered/src/features/forecast/data/providers.dart';

import 'package:weathered/src/features/home/view/home_view.dart';
import 'package:weathered/src/features/search/services/cityWeatherProvider.dart';
import 'package:weathered/src/utils/style.dart';

final cityInputProvider = StateProvider<String>((ref) {
  return '';
});

class SearchCity extends ConsumerStatefulWidget {
  const SearchCity({super.key});

  @override
  ConsumerState<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends ConsumerState<SearchCity> {
  final TextEditingController _controller = TextEditingController();

  void _showDialog(BuildContext context, String city) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, watch, _) {
            final weatherAsyncValue = ref.watch(cityWeatherProvider(city));
            return weatherAsyncValue.when(
              data: (weather) {
                logger.i(weather);
                return AlertDialog(
                  title: Text('Weather in ${weather.cityName}'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Temperature: ${weather.main.temp} °C'),
                      Text('Description: ${weather.weather[0].description}'),
                      Image.network(
                          'https://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) {
                logger.e(error: error, error, stackTrace: stackTrace);
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text('Failed to load weather data: $error'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                "Search for other cities",
                style: AppStyle.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'City Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final city = _controller.text;
                  // Store the input data using the provider
                  ref.read(cityInputProvider.notifier).state = city;
                  // Show dialog with the input city
                  _showDialog(context, city);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
