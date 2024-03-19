import 'package:big_apple/data/services/game_service_impl.dart';
import 'package:big_apple/domain/services/building_service.dart';
import 'package:big_apple/domain/services/game_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GameServiceModule {
  @lazySingleton
  GameServiceImpl get gameServiceImpl;

  @lazySingleton
  GameService gameService(GameServiceImpl gameServiceImpl) => gameServiceImpl;
  
  @lazySingleton
  BuildingService buildingService(GameServiceImpl gameServiceImpl) => gameServiceImpl;
}
