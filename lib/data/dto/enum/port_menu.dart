import 'package:big_apple/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

enum PortMenu {
  portImport,
  portStorage;

  String get title {
    switch (this) {
      case PortMenu.portStorage:
        return 'Port storage';
      case PortMenu.portImport:
        return 'Import';
    }
  }

  Gradient get gradient {
    switch (this) {
      case PortMenu.portStorage:
        return AppColors.brownGradientLeftRight;
      case PortMenu.portImport:
        return AppColors.brownGradientLeftRight;
    }
  }
}
