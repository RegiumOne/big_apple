import 'package:big_apple/domain/entities/building_entity.dart';

abstract interface class BuildingService {
  Future<void> build(BuildingEntity building);

  Future<void> updateLocation(int buildingId, double x, double y);

  Future<void> upgrade();
}
