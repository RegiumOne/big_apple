import 'package:big_apple/data/datasources/local/database/building_type_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_info.g.dart';

@JsonSerializable(explicitToJson: true)
class BuildingInfo {
  const BuildingInfo({
    required this.id,
    required this.coordinates,
    required this.building,
    required this.constructionTimeLeft,
  });

  factory BuildingInfo.fromJson(Map<String, dynamic> json) => _$BuildingInfoFromJson(json);

  final int id;
  final Coordinates coordinates;
  final BuildingType building;
  final double constructionTimeLeft;

  Map<String, dynamic> toJson() => _$BuildingInfoToJson(this);

  BuildingInfo copyWith({
    int? id,
    Coordinates? coordinates,
    BuildingType? building,
    double? constructionTimeLeft,
  }) {
    return BuildingInfo(
      id: id ?? this.id,
      coordinates: coordinates ?? this.coordinates,
      building: building ?? this.building,
      constructionTimeLeft: constructionTimeLeft ?? this.constructionTimeLeft,
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
