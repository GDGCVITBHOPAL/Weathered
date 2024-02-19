import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weathered/common/app_bar.dart';
import 'package:weathered/common/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      bottomNavigationBar: navBar,
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_sharp,
                color: Colors.red,
              ),
              Text(
                "Current Location",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Roboto'),
              )
            ],
          ),
          const Gap(10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bhopal, Madhya Pradesh",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: 'Roboto'),
              )
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Today',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const Gap(30),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width * 0.85,
                color: const Color(0x3897ABFF),
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.wb_sunny, size: 120),
                    Gap(10),
                    Text(
                      "32°C",
                      style: TextStyle(fontSize: 30, fontFamily: 'Roboto'),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
