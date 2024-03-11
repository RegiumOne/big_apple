import 'package:big_apple/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

enum BuildingCategory {
  apartments,
  commercial,
  manufactory,
  road;

  String get title {
    switch (this) {
      case BuildingCategory.apartments:
        return 'Apartments';
      case BuildingCategory.commercial:
        return 'Commercial';
      case BuildingCategory.manufactory:
        return 'Manufactory';
      case BuildingCategory.road:
        return 'Road';
    }
  }

  Gradient get gradient {
    switch (this) {
      case BuildingCategory.apartments:
        return AppColors.blueGradientLeftRight;
      case BuildingCategory.commercial:
        return AppColors.greenGradientLeftRight;
      case BuildingCategory.manufactory:
        return AppColors.orangeGradientLeftRight;
      case BuildingCategory.road:
        return AppColors.brownGradientLeftRight;
    }
  }
}
