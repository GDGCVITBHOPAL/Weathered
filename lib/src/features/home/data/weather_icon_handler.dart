import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherIconHandler {
  static SvgPicture? getImage({
    required String iconCode,
    double? height,
    double? width,
    BoxFit fit = BoxFit.contain,
  }) {
    switch (iconCode) {
      case '01d':
        const assetPath = 'assets/icons/weather/clear_sky_day.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '01n':
        const assetPath = 'assets/icons/weather/clear_sky_night.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '02d':
        const assetPath = 'assets/icons/weather/few_clouds_day.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '02n':
        const assetPath = 'assets/icons/weather/few_clouds_night.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '03d':
        const assetPath = 'assets/icons/weather/scattered_clouds_day.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '03n':
        const assetPath = 'assets/icons/weather/scattered_clouds_night.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '04d':
        const assetPath = 'assets/icons/weather/broken_clouds.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '04n':
        const assetPath = 'assets/icons/weather/broken_clouds.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '09d':
        const assetPath = 'assets/icons/weather/drizzle.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '09n':
        const assetPath = 'assets/icons/weather/drizzle.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '10d':
        const assetPath = 'assets/icons/weather/rain_day.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '10n':
        const assetPath = 'assets/icons/weather/rain_night.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '11d':
        const assetPath = 'assets/icons/weather/thunderstorm.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '50d':
        const assetPath = 'assets/icons/weather/mist.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      case '50n':
        const assetPath = 'assets/icons/weather/mist.svg';
        return SvgPicture.asset(
          assetPath,
          height: height,
          width: width,
          fit: fit,
        );
      default:
        return null;
    }
  }
}
