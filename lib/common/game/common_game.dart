import 'package:big_apple/data/dto/building.dart';
import 'package:flame/game.dart';

abstract class CommonGame extends FlameGame {
  void startGame({bool isNewGame = false});
  void endGame();
  void pauseGame();
  void resumeGame();
  void initBuildings(List<Building> buildings);
}
