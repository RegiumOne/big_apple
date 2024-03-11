import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/enum/building_type.dart';
import 'package:flame/game.dart';

abstract class CommonGame extends FlameGame {
  Future<void> startGame({bool isNewGame = false});
  void endGame();
  void pauseGame();
  void resumeGame();
  void checkMusic();
  void initBuildings(List<Building> buildings);

  /// Places a building on the map
  void placeBuilding(BuildingType type);
  void removeBuildingById(int id);
  void buildBuildingById(int id);
}
