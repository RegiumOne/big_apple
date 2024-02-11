import 'package:json_annotation/json_annotation.dart';

import 'package:big_apple/data/models/enum/building_type.dart';

part 'building.g.dart';

@JsonSerializable()
class Building {
  const Building({
    required this.coordinates,
    required this.type,
    required this.constructionTimeLeft,
  });

  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  final Coordinates coordinates;
  final BuildingType type;
  final double constructionTimeLeft;

  Building copyWith({
    Coordinates? coordinates,
    BuildingType? type,
    double? constructionTimeLeft,
  }) {
    return Building(
      coordinates: coordinates ?? this.coordinates,
      type: type ?? this.type,
      constructionTimeLeft: constructionTimeLeft ?? this.constructionTimeLeft,
    );
  }
}

@JsonSerializable()
class Coordinates {
  const Coordinates({required this.x, required this.y});

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  final double x;
  final double y;
}
