// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weathered/constants/style.dart';
import 'package:weathered/features/settings/switch.dart';

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
        Gap(10),

        //For Dark Mode
        // The Slider is left
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 5),
          decoration: BoxDecoration(
              color: Color(0x3897ABFF),
              borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.nightlight_round, size: 35.0),
              Gap(10.0),
              Text("Dark Mode", style: AppStyle.textTheme.labelMedium),

              // this is done to keep the Switch Widget to left
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SwitchMode(),
                  ],
                ),
              )
            ],
          ),
        ),

        //Temperature Unit
        //The change method is left to be implemented
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 5),
          decoration: BoxDecoration(
              color: Color(0x3897ABFF),
              borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.thermostat_outlined, size: 35.0),
              Gap(10.0),
              Text("Temperature Units", style: AppStyle.textTheme.labelMedium)
            ],
          ),
        ),

        //Send Feedback
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 5),
          decoration: BoxDecoration(
              color: Color(0x3897ABFF),
              borderRadius: BorderRadius.circular(15.0)),
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.mail_outline_rounded, size: 35.0),
              Gap(10.0),
              Text("Send Feedback", style: AppStyle.textTheme.labelMedium)
            ],
          ),
        ),

        // Made with Love
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("Made With <3 GDSC VITB"), Gap(20.0)],
          ),
        )
      ],
    ));
  }
}
