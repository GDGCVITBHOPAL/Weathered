import 'package:flutter/material.dart';

class AppStyle {
  static TextTheme get _textTheme => ThemeData().textTheme;
  static TextTheme textTheme = _textTheme.copyWith(
    titleLarge: const TextStyle(
      fontSize: 28,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: const TextStyle(
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: const TextStyle(
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    ),
    /*  */
    labelMedium: const TextStyle(
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
    labelSmall: const TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
    ),
  );
}
