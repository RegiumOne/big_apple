import 'dart:convert';

import 'package:big_apple/data/models/building.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _GameDataProviderKeys {
  const _GameDataProviderKeys._();

  static const moneyKey = 'money_key';
  static const buildingsKey = 'buildings_key';
  static const lastSaveDateTimeKey = 'last_save_date_time_key';
}

@injectable
class GameDataProvider {
  const GameDataProvider(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  double getMoney() {
    return _sharedPreferences.getDouble(_GameDataProviderKeys.moneyKey) ?? 0;
  }

  Future<bool> setMoney(double money) async {
    try {
      return await _sharedPreferences.setDouble(_GameDataProviderKeys.moneyKey, money);
    } catch (e) {
      return false;
    }
  }

  List<Building> getBuildings() {
    final List<String>? buildingString = _sharedPreferences.getStringList(_GameDataProviderKeys.buildingsKey);
    if (buildingString == null) return [];
    final buildings = buildingString.map((e) => Building.fromJson(json.decode(e))).toList();
    return buildings;
  }

  Future<bool> setBuildings(List<Building> buildings) async {
    try {
      final buildingsString = buildings.map((e) => json.encode(e.toJson())).toList();
      return await _sharedPreferences.setStringList(_GameDataProviderKeys.buildingsKey, buildingsString);
    } catch (e) {
      return false;
    }
  }

  DateTime? getLastSaveDateTime() {
    final String? dateTimeString = _sharedPreferences.getString(_GameDataProviderKeys.lastSaveDateTimeKey);
    if (dateTimeString != null) {
      return DateTime.tryParse(dateTimeString);
    }
    return null;
  }

  Future<bool> setLastSaveDateTime(DateTime dateTime) async {
    try {
      return await _sharedPreferences.setString(_GameDataProviderKeys.lastSaveDateTimeKey, dateTime.toIso8601String());
    } catch (e) {
      return false;
    }
  }
}
