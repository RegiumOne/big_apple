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
  static const Color colorDeepMahogany = Color(0xFF3A1700);
  static const Color colorCopperBrown = Color(0xFF98603C);
  static const Color colorTaupeGray = Color(0xFFAA866F);
  static const Color colorBlackWithMediumTransparency = Color(0xA6000000);
  static const Color colorMediumTransparencyBlack = Color(0x5C000000);
  static const Color colorPaleTaupe = Color(0xFFDED7C4);
  static const Color colorDimGray = Color(0xFF646464);
  static const Color colorSlateGray = Color(0xFF858585);
  static const Color colorPaleSilver = Color(0xB2D9D3C4);
  static const Color blackGlass = Color(0x45000000);
  static const Color colorSemiTransparentCharcoal = Color(0x87000000);
  static const Color colorCopper = Color(0xFFB07C5B);
  static const Color colorLightGrey = Color(0x54DED7C4);
  static const Color colorDarkChocolate = Color(0xFF492004);
  static const Color colorBrown = Color(0xFF895534);
  static const Color colorSilver = Color(0xFFACACAC);
  static const Color colorDoveGray = Color(0xFF6B6A6A);

  static const Gradient redGradientTopBottom = LinearGradient(
    colors: [
      colorLightRed,
      colorDarkRed,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient redGradientLeftRight = LinearGradient(
    colors: [
      colorLightRed,
      colorDarkRed,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient darkRedGradient = LinearGradient(
    colors: [
      colorCrimsonRed,
      colorChestnutRed,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient sunsetPassionGradient = LinearGradient(
    colors: [
      colorSoftCoral,
      colorCarmine,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient sunriseGlowGradient = LinearGradient(
    colors: [
      colorPeach,
      colorBurntOrange,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient autumnBlazeGradient = LinearGradient(
    colors: [
      colorBurntSienna,
      colorFieryRed,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient darkGrayGradient = LinearGradient(
    colors: [
      colorDarkGray,
      colorVeryDarkGray,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient blueGradientTopBottom = LinearGradient(
    colors: [
      colorBrightBlue,
      colorUltramarineBlue,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient blueGradientLeftRight = LinearGradient(
    colors: [
      colorBrightBlue,
      colorUltramarineBlue,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient greenGradientTopBottom = LinearGradient(
    colors: [
      Color(0xFF82B22A),
      Color(0xFF558300),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient greenGradientLeftRight = LinearGradient(
    colors: [
      Color(0xFF82B22A),
      Color(0xFF558300),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient espressoSunriseGradient = LinearGradient(
    colors: [
      Color(0xFF5C361E),
      colorBrown,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient darkBlueGradient = LinearGradient(
    colors: [
      Color(0xFF2650A2),
      Color(0xFF00349C),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient orangeGradientTopBottom = LinearGradient(
    colors: [
      Color(0xFFFF9961),
      Color(0xFFFD7124),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient orangeGradientLeftRight = LinearGradient(
    colors: [
      Color(0xFFFF9961),
      Color(0xFFFD7124),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient disablesGradientTopBottom = LinearGradient(
    colors: [
      Color(0xFFB7B7B7),
      Color(0xFF9D9D9D),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient disablesGradientLeftRight = LinearGradient(
    colors: [
      Color(0xFFB7B7B7),
      Color(0xFF9D9D9D),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient brownGradientLeftRight = LinearGradient(
    colors: [
      Color(0xFF5C361E),
      colorBrown,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
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

  static const BoxShadow shadowSubtleElegance = BoxShadow(
    color: AppColors.colorDeepMahogany,
    offset: Offset(1, 1),
  );

  static const BoxShadow shadowSoftFocus = BoxShadow(
    color: AppColors.colorBlackWithMediumTransparency,
    offset: Offset(1, 1),
  );

  static const BoxShadow shadowGentleElevation = BoxShadow(
    color: AppColors.colorLightSemiTransparentBlack,
    offset: Offset(0, 4),
    blurRadius: 4,
  );
}
