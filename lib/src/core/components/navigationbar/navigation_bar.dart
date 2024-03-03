import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation_bar_provider.dart';
export 'navigation_bar_provider.dart';

Widget navBar() {
  return Consumer(
    builder: (context, ref, child) {
      final currentIndex = ref.watch(bottomNavigationBarProvider);
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
        selectedIndex: currentIndex,
        indicatorColor: Colors.white,
        onDestinationSelected: (value) {
          // Update the selected index
          ref
              .read(bottomNavigationBarProvider.notifier)
              .update((state) => value);
        },
      );
    },
  );
}
