import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color colorLightRed = Color(0xFFE14F4F);
  static const Color colorDarkRed = Color(0xFF861313);
  static const Color colorWineRed = Color(0xFF670000);
  static const Color colorCrimsonRed = Color(0xFFAE3131);
  static const Color colorChestnutRed = Color(0xFF701212);
  static const Color colorBronze = Color(0xFF875230);
  static const Color colorAlabaster = Color(0xFFF9F4E5);
  static const Color colorSoftCoral = Color(0xFFD77474);
  static const Color colorCarmine = Color(0xFFB82121);
  static const Color colorSemiTransparentBlack = Color(0x99000000);
  static const Color colorLightSemiTransparentBlack = Color(0x40000000);
  static const Color colorPeach = Color(0xFFFF985F);
  static const Color colorBurntOrange = Color(0xFFD34B00);
  static const Color colorMediumSemiTransparentBlack = Color(0x73000000);
  static const Color colorLightGray = Color(0xFFD9D3C4);
  static const Color colorBurntSienna = Color(0xFFC75A47);
  static const Color colorFieryRed = Color(0xFFC75A47);
  static const Color colorRust = Color(0xFFA62313);
  static const Color colorDarkGray = Color(0xFF474747);
  static const Color colorVeryDarkGray = Color(0xFF212121);
  static const Color colorTaupe = Color(0xFFA47F63);
  static const Color colorRoyalBlue = Color(0xFF002F8D);
  static const Color colorBrightBlue = Color(0xFF3D78EE);
  static const Color colorUltramarineBlue = Color(0xFF0E00AB);
  static const Color colorAlmondMilk = Color(0xFFE2D0BC);

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

  static const Gradient gradientSunsetPassion = LinearGradient(
    colors: [
      colorSoftCoral,
      colorCarmine,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradientSunriseGlow = LinearGradient(
    colors: [
      colorPeach,
      colorBurntOrange,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradientAutumnBlaze = LinearGradient(
    colors: [
      colorBurntSienna,
      colorFieryRed,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradientDarkGray = LinearGradient(
    colors: [
      colorDarkGray,
      colorVeryDarkGray,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient gradientDeepOceanGlide = LinearGradient(
    colors: [
      colorBrightBlue,
      colorUltramarineBlue,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const BoxShadow shadowSoftBlack = BoxShadow(
    color: AppColors.colorSemiTransparentBlack,
    offset: Offset(0, 4),
    blurRadius: 8.8,
  );

  static const BoxShadow shadowElevatedSoft = BoxShadow(
    color: AppColors.colorMediumSemiTransparentBlack,
    offset: Offset(0, 4),
    blurRadius: 7.6,
  );

  static const BoxShadow shadowCrispEdge = BoxShadow(
    color: AppColors.colorLightSemiTransparentBlack,
    offset: Offset(2, 2),
  );
}
