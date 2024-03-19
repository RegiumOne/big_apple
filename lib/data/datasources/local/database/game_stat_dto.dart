import 'package:big_apple/data/datasources/local/database/app_database.dart';
import 'package:big_apple/domain/entities/game_stat.dart';
import 'package:drift/drift.dart';

class GameStatDto extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get gold => real()();
  RealColumn get maxGold => real()();
  RealColumn get coal => real()();
  RealColumn get maxCoal => real()();
  RealColumn get iron => real()();
  RealColumn get maxIron => real()();
  IntColumn get electricity => integer()();
  RealColumn get ecologyLevel => real()();
  IntColumn get peoples => integer()();
  IntColumn get builders => integer()();
  IntColumn get maxBuilders => integer()();
  IntColumn get clover => integer()();
  DateTimeColumn get updatedAt => dateTime()();
}

extension GameStatDtoX on GameStatDtoData {
  GameStatistic toEntity() => GameStatistic(
        id: id,
        gold: gold,
        maxGold: maxGold,
        coal: coal,
        maxCoal: maxCoal,
        iron: iron,
        maxIron: maxIron,
        electricity: electricity,
        ecologyLevel: ecologyLevel,
        peoples: peoples,
        builders: builders,
        maxBuilders: maxBuilders,
        clover: clover,
      );
}
