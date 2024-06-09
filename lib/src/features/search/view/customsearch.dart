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

  @override
  Widget build(BuildContext context) {
    final city = ref.watch(cityInputProvider);
    final weatherAsyncValue = ref.watch(cityWeatherProvider(city));

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
            icon: const Icon(Icons.home),
          ),
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
                  ref.read(cityInputProvider.notifier).state = city;
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16),
              weatherAsyncValue.when(
                data: (weather) {
                  return Column(
                    children: [
                      Text('Weather in ${weather.cityName}'),
                      Text('Temperature: ${weather.main.temp} °C'),
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png',
                      ),
                    ],
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) {
                  return Text('Failed to load weather data: $error');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
