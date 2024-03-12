import 'package:big_apple/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

enum PortMenu {
  portStorage;

  String get title {
    switch (this) {
      case PortMenu.portStorage:
        return 'Port storage';
    }
  }

  Gradient get gradient {
    switch (this) {
      case PortMenu.portStorage:
        return AppColors.brownGradientLeftRight;
    }
  }
}
