import 'package:big_apple/data/dto/apartment.dart';
import 'package:big_apple/data/dto/commercial.dart';
import 'package:big_apple/data/dto/enum/apartment_type.dart';
import 'package:big_apple/data/dto/enum/commercial_type.dart';
import 'package:big_apple/data/dto/enum/manufactory_type.dart';
import 'package:big_apple/data/dto/enum/road_type.dart';
import 'package:big_apple/data/dto/manufactory.dart';
import 'package:big_apple/data/dto/road.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:big_apple/data/dto/building.dart';

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
  @JsonKey(fromJson: _buildingFromJson, toJson: _buildingToJson)
  final Building building;
  final double constructionTimeLeft;

  Map<String, dynamic> toJson() => _$BuildingInfoToJson(this);

  BuildingInfo copyWith({
    int? id,
    Coordinates? coordinates,
    Building? building,
    double? constructionTimeLeft,
  }) {
    return BuildingInfo(
      id: id ?? this.id,
      coordinates: coordinates ?? this.coordinates,
      building: building ?? this.building,
      constructionTimeLeft: constructionTimeLeft ?? this.constructionTimeLeft,
    );
  }

  static Building _buildingFromJson(Map<String, dynamic> json) {
    final String type = json['type'];
    final isApartment = ApartmentType.values.any((e) => e.name == type);
    final isCommercial = CommercialType.values.any((e) => e.name == type);
    final isManufactory = ManufactoryType.values.any((e) => e.name == type);
    final isRoad = RoadType.values.any((e) => e.name == type);
    if (isApartment) {
      return Apartment.fromJson(json);
    } else if (isCommercial) {
      return Commercial.fromJson(json);
    } else if (isManufactory) {
      return Manufactory.fromJson(json);
    } else if (isRoad) {
      return Road.fromJson(json);
    }
    throw Exception('Building type is missing');
  }

  static Map<String, dynamic> _buildingToJson(Building building) {
    if (building is Apartment) return building.toJson();
    if (building is Commercial) return building.toJson();
    if (building is Manufactory) return building.toJson();
    if (building is Road) return building.toJson();
    throw Exception('Unknown Building type');
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
