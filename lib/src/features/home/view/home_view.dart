import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/components/common.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../forecast/view/forecast_view.dart';
import '../../map/provider/location_provider.dart';
import '../../map/view/map_view.dart';
import '../../settings/view/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    requestLocationPermission();
    LocationNotifier().getLocation();
    super.initState();
  }

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
                  const DashBoard(),
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

void requestLocationPermission() async {
  LocationPermission permission;
  await Geolocator.isLocationServiceEnabled();
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      const Dialog(
        child: Text('Location permission is required to use this app'),
      );
    }
  }
}
