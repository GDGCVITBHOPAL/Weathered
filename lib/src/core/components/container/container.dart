import 'package:flutter/material.dart';

class MatContainer {
  static Container primary({
    required BuildContext context,
    required Widget child,
    double? height,
    double? width,
    double topPad = 16,
    double bottomPad = 16,
    double leftright = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      height: height,
      width: width,
      padding: EdgeInsets.fromLTRB(leftright, topPad, leftright, bottomPad),
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: child,
    );
  }
}

class MatContainer1 {
  static Container primary({
    required BuildContext context,
    required Widget child,
    double? height,
    double? width,
    double topPad = 16,
    double bottomPad = 0,
    double leftright = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      height: height,
      width: width,
      padding: EdgeInsets.fromLTRB(leftright, topPad, leftright, bottomPad),
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      child: child,
    );
  }
}
