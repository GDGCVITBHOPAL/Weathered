// ignore_for_file: non_constant_identifier_names

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathered/src/features/dashboard/services/api_call.dart';
import 'src/features/home/view/home_view.dart';

final fetchCurrentWeatherProvider = FutureProvider((ref) {
  final CurrentWeatherRepository = ref.watch(CurrentWeatherRepositoryProvider);
  return CurrentWeatherRepository.fetchWeatherData();
});

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
          // setting the color scheme
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          // if the dynamic color is null
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
          darkColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeView(),
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: lightColorScheme.copyWith(),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: darkColorScheme.copyWith(),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
