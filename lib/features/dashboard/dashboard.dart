import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.wb_sunny, size: 120),
                    Gap(10),
                    Text(
                      "32°C",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Partly Cloudy",
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Gap(10),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.85,
                color: const Color(0x3897ABFF),
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [Column(), Column()],
                    ),
                    Row(
                      children: [Column(), Column()],
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
