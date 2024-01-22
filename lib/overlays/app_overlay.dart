import 'package:big_apple/overlays/hud/hud.dart';
import 'package:big_apple/overlays/screens/main_screen.dart';
import 'package:big_apple/overlays/screens/pause_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

abstract class Overlays {
  Overlays._();
  static const main = "main";
  static const pause = "pause";
  static const hud = "hud";
}

class AppOverlay {
  static const List<String> initialActiveOverlays = [Overlays.main];

  static final Map<String, Widget Function(BuildContext, FlameGame)> overlayBuilderMap = {
    Overlays.main: (context, game) => MainScreen(game: game),
    Overlays.pause: (context, game) => PauseScreen(game: game),
    Overlays.hud: (context, game) => Hud(game: game),
  };
}
