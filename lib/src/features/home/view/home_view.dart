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
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_disabled_sharp,
                color: Colors.red,
                size: 60.0,
              ),
              Gap(10.0),
              SizedBox(
                width: 500.0,
                child: Text(
                  'Location permission is required to use this app',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
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
