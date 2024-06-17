import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../utils/style.dart';
import '../../home/view/home_view.dart';
import '../services/cityWeatherProvider.dart';

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
              Text(
                "Search for other cities",
                textAlign: TextAlign.center,
                style: AppStyle.textTheme.titleMedium,
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
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
                  final city = _controller.text.trim();
                  ref.read(cityInputProvider.notifier).state = city;
                },
                child: const Text('Submit'),
              ),
              const Gap(30),
              if (city.isEmpty)
                Text(
                  'Enter city name and click search',
                  style: AppStyle.textTheme.bodyLarge,
                )
              else
                Consumer(
                  builder: (context, watch, _) {
                    final weatherAsyncValue =
                        ref.watch(cityWeatherProvider(city));
                    return weatherAsyncValue.when(
                      data: (weather) {
                        return Column(
                          children: [
                            Text(
                              'Weather in ${weather.cityName}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Image.network(
                              'https://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png',
                              scale: 0.80,
                            ),
                            Text(
                              '${weather.main.temp.round()} °C',
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              weather.weather[0].description,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stackTrace) {
                        return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Text(
                              'Failed to load weather data \nPlease check the city name and retry',
                              textAlign: TextAlign.center,
                              style: AppStyle.textTheme.labelSmall,
                            ));
                      },
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
