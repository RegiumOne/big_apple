import 'package:big_apple/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

enum UpgradeMenu {
  upgrade;

  String get title {
    switch (this) {
      case UpgradeMenu.upgrade:
        return 'Upgrade';
    }
  }

  Gradient get gradient {
    switch (this) {
      case UpgradeMenu.upgrade:
        return AppColors.orangeGradientLeftRight;
    }
  }
}
