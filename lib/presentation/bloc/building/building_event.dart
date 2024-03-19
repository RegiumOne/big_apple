part of 'building_bloc.dart';

@immutable
sealed class BuildingEvent {}

class InitBuildingEvent extends BuildingEvent {
  InitBuildingEvent({required this.buildingEntity});

  final BuildingEntity buildingEntity;
}

class BuildBuildingEvent extends BuildingEvent {
  BuildBuildingEvent({required this.buildingEntity});

  final BuildingEntity buildingEntity;
}

class CancelBuildingEvent extends BuildingEvent {
  CancelBuildingEvent({required this.buildingEntity});

  final BuildingEntity buildingEntity;
}
