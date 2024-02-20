import 'package:flutter/material.dart';

// NavigationBar navBar() {
//   return BottomNavigationBar(items: [bot],)
// }

NavigationBar navBar(int selectedIndex) {
  int _selectedIndex = selectedIndex;
  return NavigationBar(
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.sunny),
        label: "Home",
      ),
      NavigationDestination(
        icon: Icon(Icons.auto_graph_rounded),
        label: "Forecast",
      ),
      NavigationDestination(
        icon: Icon(Icons.map_rounded),
        label: "Map",
      ),
      NavigationDestination(
        icon: Icon(Icons.settings),
        label: "Settings",
      ),
    ],
    selectedIndex: _selectedIndex,
    onDestinationSelected: (int currentPageIndex) {
      _selectedIndex = currentPageIndex;
    },
  );
}
