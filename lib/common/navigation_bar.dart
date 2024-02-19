import 'package:flutter/material.dart';

final navBar = NavigationBar(
  destinations: const [
    NavigationDestination(
      icon: Icon(Icons.sunny),
      label: "Home",
    ),
    NavigationDestination(
      icon: Icon(Icons.auto_graph_rounded),
      label: "Weekly",
    ),
    NavigationDestination(
      icon: Icon(Icons.map_rounded),
      label: "Setting",
    ),
    NavigationDestination(
      icon: Icon(Icons.settings),
      label: "Settings",
    )
  ],
);
