import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color colorLightRed = Color(0xFFE14F4F);
  static const Color colorDarkRed = Color(0xFF861313);
  static const Color colorWineRed = Color(0xFF670000);
  static const Color colorCrimsonRed = Color(0xFFAE3131);
  static const Color colorChestnutRed = Color(0xFF701212);

  static const Gradient gradientWarmSunset = LinearGradient(
    colors: [
      colorLightRed,
      colorDarkRed,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const Gradient gradientVelvetWine = LinearGradient(
    colors: [
      colorCrimsonRed,
      colorChestnutRed,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
