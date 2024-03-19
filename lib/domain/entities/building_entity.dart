import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';

class BuildingEntity {
  BuildingEntity({
    required this.id,
    required this.level,
    required this.x,
    required this.y,
    required this.type,
    this.constructionTimeLeft = 0,
  });

  BuildingEntity.initial({
    required this.id,
    required this.x,
    required this.y,
    required this.type,
    this.level = 1,
    this.constructionTimeLeft = 0,
  });

  final int id;
  final int level;
  final BuildingType type;
  final double x;
  final double y;
  final double constructionTimeLeft;

  BuildingEntity copyWith({
    int? id,
    int? level,
    BuildingType? type,
    double? x,
    double? y,
    double? constructionTimeLeft,
  }) {
    return BuildingEntity(
      id: id ?? this.id,
      level: level ?? this.level,
      type: type ?? this.type,
      x: x ?? this.x,
      y: y ?? this.y,
      constructionTimeLeft: constructionTimeLeft ?? this.constructionTimeLeft,
    );
  }
}
