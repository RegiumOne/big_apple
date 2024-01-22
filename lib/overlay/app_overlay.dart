import 'package:big_apple/screens/main_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class Overlays {
  Overlays._();
  static const main = "main";
}

class AppOverlay {
  static const List<String> initialActiveOverlays = [Overlays.main];

  static final Map<String, Widget Function(BuildContext, FlameGame)> overlayBuilderMap = {
    Overlays.main: (context, game) => MainScreen(game: game),
  };
}
