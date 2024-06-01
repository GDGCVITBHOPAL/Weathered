import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Row weatherAttribute(
  BuildContext context, {
  required IconData icon,
  required String attribute,
  required String value,
}) {
  final fontColor = Theme.of(context).colorScheme.onPrimaryContainer;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, color: fontColor, size: 32.0),
      const Gap(10),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(attribute,
              style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0)),
          Text(value, style: TextStyle(color: fontColor, fontSize: 15.0)),
        ],
      )
    ],
  );
}

Row weatherAttributeBox(
  BuildContext context, {
  required IconData icon,
  required String attribute,
  required String value,
}) {
  final fontColor = Theme.of(context).colorScheme.onPrimaryContainer;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(icon, color: fontColor, size: 30.0),
      const Gap(10),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(attribute,
              style: TextStyle(
                  color: fontColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0)),
          Text(value, style: TextStyle(color: fontColor, fontSize: 13.0)),
        ],
      )
    ],
  );
}
