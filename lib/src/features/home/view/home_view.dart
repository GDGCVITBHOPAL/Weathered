import 'package:app_settings/app_settings.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathered/src/features/map/provider/location_provider.dart';

import '../../../core/components/common.dart';
import '../../dashboard/view/dashboard_view.dart';
import '../../forecast/view/forecast_view.dart';
import '../../map/view/map_view.dart';
import '../../settings/view/settings_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission;
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      // Location services are not enabled, show error message
      setState(() {
        _locationPermissionGranted = false;
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          _locationPermissionGranted = false;
        });
        return;
      }
    }

    setState(() {
      _locationPermissionGranted = true;
      LocationNotifier().getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_locationPermissionGranted) {
      return Scaffold(
        appBar: appBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_disabled_sharp,
                color: Colors.red,
                size: 60.0,
              ),
              const Gap(10.0),
              const SizedBox(
                width: 500.0,
                child: Column(
                  children: [
                    Text(
                      'Location permission is required to use this app',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Gap(7.5),
                    Text("Restart the app again with settings enabled")
                  ],
                ),
              ),
              const Gap(15.0),
              ElevatedButton(
                  onPressed: () => {
                        AppSettings.openAppSettings(
                            type: AppSettingsType.location)
                      },
                  child: const Text("Open Location Settings"))
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: navBar(),
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
      ),
    );
  }
}
