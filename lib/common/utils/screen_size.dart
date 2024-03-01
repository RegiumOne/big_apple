import 'package:flutter/material.dart';

enum ScreenSize { small, medium, large }

ScreenSize getDeviceWidth(BuildContext context) {
  final double deviceWidth = MediaQuery.of(context).size.width;
  if (deviceWidth > 1024) {
    return ScreenSize.large;
  } else if (deviceWidth > 599) {
    return ScreenSize.medium;
  } else {
    return ScreenSize.small;
  }
}

bool isLargeScreen(BuildContext context) {
  return getDeviceWidth(context) == ScreenSize.large;
}

bool isSmallScreen(BuildContext context) {
  return getDeviceWidth(context) == ScreenSize.small;
}
