import 'package:big_apple/data/dto/builder.dart';
import 'package:big_apple/data/dto/building.dart';

abstract interface class GameRepository {
  double getMoney();

  Future<bool> setMoney(double money);

  List<Building> getBuildings();

  Future<bool> setBuildings(List<Building> buildings);

  DateTime? getLastSaveDateTime();

  Future<bool> setLastSaveDateTime(DateTime dateTime);

  List<Builder> getBuilders();

  Future<bool> setBuilders(List<Builder> builders);
}
