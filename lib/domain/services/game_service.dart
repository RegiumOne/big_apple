import 'package:big_apple/data/services/game_state.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class GameService {
  BehaviorSubject<GameState> get state;

  Future<void> init();
}
