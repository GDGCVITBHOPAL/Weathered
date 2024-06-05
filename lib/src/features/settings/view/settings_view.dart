// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/style.dart';
import '../model/settings_model.dart';

final Uri _url = Uri.parse('https://github.com/DSCVITBHOPAL/Weathered');

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        // const Gap(16),
        Center(
          child: Text(
            'Settings',
            style: AppStyle.textTheme.titleLarge,
          ),
        ),
        Gap(8),

        //For Dark Mode
        // The Slider is left
        Container(
          margin: EdgeInsets.fromLTRB(16, 16, 16, 5),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
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
        // Container(
        //   margin: EdgeInsets.fromLTRB(16, 16, 16, 5),
        //   decoration: BoxDecoration(
        //       color: Theme.of(context).colorScheme.primaryContainer,
        //       borderRadius: BorderRadius.circular(15.0)),
        //   padding: EdgeInsets.all(16.0),
        //   child: Row(
        //     children: [
        //       Icon(Icons.thermostat_outlined, size: 35.0),
        //       Gap(10.0),
        //       Text("Temperature Units", style: AppStyle.textTheme.labelMedium)
        //     ],
        //   ),
        // ),

        //Send Feedback
        GestureDetector(
          onTap: () {
            _launchUrl();
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 5),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
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
