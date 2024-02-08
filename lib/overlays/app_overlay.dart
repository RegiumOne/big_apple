import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/overlays/hud/hud.dart';
import 'package:big_apple/overlays/listener_overlay.dart';
import 'package:big_apple/overlays/screens/main/main_screen.dart';
import 'package:big_apple/overlays/screens/pause/pause_screen.dart';
import 'package:big_apple/overlays/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';

enum Overlays {
  main,
  pause,
  hud,
  listener,
  shop,
}

class AppOverlay {
  static List<String> initialActiveOverlays = [
    Overlays.main.name,
    Overlays.listener.name,
  ];

  static final Map<String, Widget Function(BuildContext, CommonGame)> overlayBuilderMap = {
    Overlays.main.name: (context, game) => MainScreen(game: game),
    Overlays.pause.name: (context, game) => PauseScreen(game: game),
    Overlays.hud.name: (context, game) => Hud(game: game),
    Overlays.listener.name: (context, game) => ListenerOverlay(game: game),
    Overlays.shop.name: (context, game) => ShopScreen(game: game),
  };
}
