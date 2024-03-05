import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/components/common.dart';
import '../components/weather_attribute.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(8),
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
                ),
              )
            ],
          ),
          const Gap(8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bhopal, Madhya Pradesh",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const Gap(18),
          Column(
            children: [
              MatContainer.primary(
                context: context,
                topPad: 24,
                bottomPad: 32,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/weather/cloudy_night.svg",
                          height: 200,
                        ),
                        const Gap(16),
                      ],
                    ),
                    Text(
                      "32°C",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                    Text(
                      "Partly Cloudy",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    )
                  ],
                ),
              ),
              MatContainer.primary(
                context: context,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        weatherAttribute(
                          context,
                          icon: Icons.water_drop_rounded,
                          attribute: "Humidity",
                          value: "94%",
                        ),
                        weatherAttribute(
                          context,
                          icon: Icons.wb_sunny_rounded,
                          attribute: "UV Index",
                          value: "3",
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        weatherAttribute(
                          context,
                          icon: Icons.air_rounded,
                          attribute: "Wind Speed",
                          value: "13 kmph",
                        ),
                        weatherAttribute(
                          context,
                          icon: Icons.thermostat_rounded,
                          attribute: " Feels like ",
                          value: "32°C",
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Gap(8),
            ],
          ),
        ],
      ),
    );
  }
}
