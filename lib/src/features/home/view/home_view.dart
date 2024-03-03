import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weathered/src/features/settings/view/settings_view.dart';

import '../../../core/components/common.dart';

import '../../dashboard/view/dashboard_view.dart';
import '../../forecast/view/forecast_view.dart';
import '../../map/view/map_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                  const ForecastView(),
                  const MapView(),
                  const SettingsView(),
                ][ref.watch(bottomNavigationBarProvider)];
              },
            );
          },
        ));
  }
}
