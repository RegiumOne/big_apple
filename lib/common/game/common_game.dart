import 'package:flame/game.dart';

import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';

abstract class CommonGame extends FlameGame {
  Future<void> startGame({bool isNewGame = false});
  void endGame();
  void pauseGame();
  void resumeGame();
  void checkMusic();

  /// Places a building on the map
  void placeBuilding(BuildingType type);
  void removeBuildingById(int id);
  Future<Vector2>? buildBuildingById(int id);
}
