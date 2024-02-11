import 'package:big_apple/data/datasources/local/data_providers/game_data_provider.dart';
import 'package:big_apple/data/models/builder.dart';
import 'package:big_apple/data/models/building.dart';
import 'package:injectable/injectable.dart';

abstract class GameRepository {
  double getMoney();

  Future<bool> setMoney(double money);

  List<Building> getBuildings();

  Future<bool> setBuildings(List<Building> buildings);

  DateTime? getLastSaveDateTime();

  Future<bool> setLastSaveDateTime(DateTime dateTime);

  List<Builder> getBuilders();

  Future<bool> setBuilders(List<Builder> builders);
}

@Injectable(as: GameRepository)
class GameRepositoryImpl implements GameRepository {
  const GameRepositoryImpl(this._gameDataProvider);

  final GameDataProvider _gameDataProvider;

  @override
  double getMoney() => _gameDataProvider.getMoney();

  @override
  Future<bool> setMoney(double money) => _gameDataProvider.setMoney(money);

  @override
  List<Building> getBuildings() => _gameDataProvider.getBuildings();

  @override
  Future<bool> setBuildings(List<Building> buildings) => _gameDataProvider.setBuildings(buildings);

  @override
  DateTime? getLastSaveDateTime() => _gameDataProvider.getLastSaveDateTime();

  @override
  Future<bool> setLastSaveDateTime(DateTime dateTime) => _gameDataProvider.setLastSaveDateTime(dateTime);

  @override
  List<Builder> getBuilders() => _gameDataProvider.getBuilders();

  @override
  Future<bool> setBuilders(List<Builder> builders) => _gameDataProvider.setBuilders(builders);
}
