import 'package:big_apple/data/datasources/local/database/app_database.dart';
import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:big_apple/data/datasources/local/database/resources_dto.dart';
import 'package:big_apple/domain/entities/building_entity.dart';
import 'package:drift/drift.dart';

class BuildingDto extends Table {
  // This is used to store building id
  IntColumn get id => integer().unique()();

  // This is used to store building level
  IntColumn get level => integer()();

  // This is used to store buildind coordinates
  RealColumn get x => real()();
  RealColumn get y => real()();

  // This is used to store resource information
  TextColumn get resource => text().map(const ResourceConverter())();

  // This is used to store building type
  TextColumn get buildingType => textEnum<BuildingType>()();
}

extension BuildingsDtoX on List<BuildingDtoData> {
  List<BuildingEntity> toEntity() => map((e) => e.toEntity()).toList();
}

extension BuildingDtoX on BuildingDtoData {
  BuildingEntity toEntity() => BuildingEntity(
        id: id,
        level: level,
        x: x,
        y: y,
        type: buildingType,
      );
}
