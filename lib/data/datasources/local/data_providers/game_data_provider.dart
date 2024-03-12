import 'dart:convert';

import 'package:big_apple/data/dto/builder.dart';
import 'package:big_apple/data/dto/building_info.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _GameDataProviderKeys {
  const _GameDataProviderKeys._();

  static const moneyKey = 'money_key';
  static const buildingsKey = 'buildings_key';
  static const buildersKey = 'builders_key';
  static const lastSaveDateTimeKey = 'last_save_date_time_key';
}

@injectable
class GameDataProvider {
  const GameDataProvider(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  double getMoney() {
    return _sharedPreferences.getDouble(_GameDataProviderKeys.moneyKey) ?? 10000;
  }

  Future<bool> setMoney(double money) async {
    try {
      return _sharedPreferences.setDouble(_GameDataProviderKeys.moneyKey, money);
    } catch (e) {
      return false;
    }
  }

  List<BuildingInfo> getBuildings() {
    final List<String>? buildingString = _sharedPreferences.getStringList(_GameDataProviderKeys.buildingsKey);
    if (buildingString == null) return [];
    final buildings = buildingString.map((e) => BuildingInfo.fromJson(json.decode(e))).toList();
    return buildings;
  }

  Future<bool> setBuildings(List<BuildingInfo> buildings) async {
    try {
      final buildingsString = buildings.map((e) => json.encode(e.toJson())).toList();
      return await _sharedPreferences.setStringList(_GameDataProviderKeys.buildingsKey, buildingsString);
    } catch (e) {
      return false;
    }
  }

  List<Builder> getBuilders() {
    final List<String>? buildersString = _sharedPreferences.getStringList(_GameDataProviderKeys.buildersKey);
    if (buildersString == null) return List.generate(2, (index) => const Builder(isBusy: false));
    final builders = buildersString.map((e) => Builder.fromJson(json.decode(e))).toList();
    return builders;
  }

  Future<bool> setBuilders(List<Builder> builders) async {
    try {
      final buildersString = builders.map((e) => json.encode(e.toJson())).toList();
      return await _sharedPreferences.setStringList(_GameDataProviderKeys.buildersKey, buildersString);
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
      return _sharedPreferences.setString(_GameDataProviderKeys.lastSaveDateTimeKey, dateTime.toIso8601String());
    } catch (e) {
      return false;
    }
  }
}
