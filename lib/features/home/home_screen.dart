import 'package:flutter/material.dart';

import '../../common/app_bar.dart';
import '../../common/navigation_bar.dart';
import '../dashboard/dashboard.dart';
import '../forecast/forecast_screen.dart';
import '../map/map_screen.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        bottomNavigationBar: navBar(_currentPageIndex),
        body: [
          const Dashboard(),
          const ForecastScreen(),
          const MapScreen(),
          const SettingsScreen()
        ][_currentPageIndex]);
  }
}
