import 'package:big_apple/data/dto/building.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:flame/game.dart';

abstract class CommonGame extends FlameGame {
  Future<void> startGame({bool isNewGame = false});
  void endGame();
  void pauseGame();
  void resumeGame();
  void checkMusic();
  void initBuildings(List<BuildingInfo> buildings);

  /// Places a building on the map
  void placeBuilding(Building type);
  void removeBuildingById(int id);
  Future<Vector2>? buildBuildingById(int id);
}
