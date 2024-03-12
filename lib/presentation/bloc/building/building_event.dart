part of 'building_bloc.dart';

@immutable
sealed class BuildingEvent {}

class InitBuildingEvent extends BuildingEvent {
  InitBuildingEvent({required this.buildingInfo});

  final BuildingInfo buildingInfo;
}

class BuildBuildingEvent extends BuildingEvent {
  BuildBuildingEvent({required this.buildingInfo});

  final BuildingInfo buildingInfo;
}

class CancelBuildingEvent extends BuildingEvent {
  CancelBuildingEvent({required this.buildingInfo});

  final BuildingInfo buildingInfo;
}
