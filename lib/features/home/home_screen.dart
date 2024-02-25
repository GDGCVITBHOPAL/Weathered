import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/common.dart';

import '../dashboard/dashboard.dart';
import '../forecast/forecast_screen.dart';
import '../map/map_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        bottomNavigationBar: navBar(),
        // Using Consumer just here coz don't wanna rebuild the whole screen
        body: DynamicColorBuilder(
          builder: (lightDynamic, darkDynamic) {
            return Consumer(
              builder: (context, ref, child) {
                return [
                  const Dashboard(),
                  const ForecastScreen(),
                  const MapScreen(),
                  const SettingsScreen()
                ][ref.watch(bottomNavigationBarProvider)];
              },
            );
          },
        ));
  }
}
