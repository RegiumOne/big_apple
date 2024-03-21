import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/data/dto/enum/port_menu.dart';
import 'package:big_apple/presentation/overlays/hud/hud.dart';
import 'package:big_apple/presentation/overlays/listener_overlay.dart';
import 'package:big_apple/presentation/overlays/screens/information/information_screen.dart';
import 'package:big_apple/presentation/overlays/screens/new_level/new_level_screen.dart';
import 'package:big_apple/presentation/overlays/screens/port/port_screen.dart';
import 'package:big_apple/presentation/overlays/screens/settings/settings_screen.dart';
import 'package:big_apple/presentation/overlays/screens/shop/shop_screen.dart';
import 'package:big_apple/presentation/overlays/screens/upgrade/upgrade_screen.dart';
import 'package:flutter/material.dart';

enum Overlays {
  hud,
  listener,
  shop,
  settings,
  information,
  portStorage,
  portImport,
  upgrade,
  newLevel,
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
    Overlays.portStorage.name: (context, game) => PortScreen(
          game: game,
          overlay: Overlays.portStorage.name,
          selectedMenu: PortMenu.portStorage,
        ),
    Overlays.portImport.name: (context, game) => PortScreen(
          game: game,
          overlay: Overlays.portImport.name,
          selectedMenu: PortMenu.portImport,
        ),
    Overlays.upgrade.name: (context, game) => UpgradeScreen(game: game),
    Overlays.newLevel.name: (context, game) => NewLevelScreen(game: game),
  };
}
