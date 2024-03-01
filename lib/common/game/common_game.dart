import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:flame/game.dart';

abstract class CommonGame extends FlameGame {
  Future<void> startGame({bool isNewGame = false});
  void endGame();
  void pauseGame();
  void resumeGame();
  void initBuildings(List<Building> buildings);

  /// Shows the shop overlay
  void showShop();

  /// Hides the shop overlay
  void hideShop();

  /// Places a building on the map
  void placeBuilding(BuildingType type);
}
