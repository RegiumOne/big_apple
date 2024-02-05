import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/overlays/hud/hud.dart';
import 'package:big_apple/overlays/listener_overlay.dart';
import 'package:big_apple/overlays/screens/main_screen.dart';
import 'package:big_apple/overlays/screens/pause_screen.dart';
import 'package:flutter/material.dart';

abstract class Overlays {
  Overlays._();
  static const main = "main";
  static const pause = "pause";
  static const hud = "hud";
  static const listener = "listener";
}

class AppOverlay {
  static const List<String> initialActiveOverlays = [Overlays.main, Overlays.listener];

  static final Map<String, Widget Function(BuildContext, AppGame)> overlayBuilderMap = {
    Overlays.main: (context, game) => MainScreen(game: game),
    Overlays.pause: (context, game) => PauseScreen(game: game),
    Overlays.hud: (context, game) => Hud(game: game),
    Overlays.listener: (context, game) => ListenerOverlay(game: game),
  };
}
