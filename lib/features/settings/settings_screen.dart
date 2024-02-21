import 'package:flutter/material.dart';
import 'package:weathered/constants/style.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Center(
          child: Text(
            'Settings',
            style: AppStyle.textTheme.titleLarge,
          ),
        ),
      ],
    ));
  }
}
