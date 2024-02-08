import 'package:json_annotation/json_annotation.dart';

import 'package:big_apple/data/dto/enum/building_type.dart';

part 'building.g.dart';

@JsonSerializable(explicitToJson: true)
class Building {
  const Building({
    required this.coordinates,
    required this.type,
  });

  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);

  final Coordinates coordinates;
  final BuildingType type;

  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  Building copyWith({
    Coordinates? coordinates,
    BuildingType? type,
  }) {
    return Building(
      coordinates: coordinates ?? this.coordinates,
      type: type ?? this.type,
    );
  }
}

@JsonSerializable()
class Coordinates {
  const Coordinates({required this.x, required this.y});

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);

  final double x;
  final double y;

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
