import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/presentation/overlays/hud/hud.dart';
import 'package:big_apple/presentation/overlays/listener_overlay.dart';
import 'package:big_apple/presentation/overlays/screens/information/information_screen.dart';
import 'package:big_apple/presentation/overlays/screens/port/port_screen.dart';
import 'package:big_apple/presentation/overlays/screens/settings/settings_screen.dart';
import 'package:big_apple/presentation/overlays/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';

enum Overlays {
  hud,
  listener,
  shop,
  settings,
  information,
  port,
}

class AppOverlay {
  static List<String> initialActiveOverlays = [
    Overlays.hud.name,
    Overlays.listener.name,
  ];

  static final Map<String, Widget Function(BuildContext, CommonGame)> overlayBuilderMap = {
    Overlays.hud.name: (context, game) => Hud(game: game),
    Overlays.listener.name: (context, game) => ListenerOverlay(game: game),
    Overlays.shop.name: (context, game) => ShopScreen(game: game),
    Overlays.settings.name: (context, game) => SettingsScreen(game: game),
    Overlays.information.name: (context, game) => InformationScreen(game: game),
    Overlays.port.name: (context, game) => PortScreen(game: game),
  };
}
