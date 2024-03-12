part of 'building_bloc.dart';

@immutable
sealed class BuildingEvent {}

class InitBuildingEvent extends BuildingEvent {
  InitBuildingEvent({required this.buildingId});

  final int buildingId;
}

class BuildBuildingEvent extends BuildingEvent {
  BuildBuildingEvent({required this.buildingId});

  final int buildingId;
}

class CancelBuildingEvent extends BuildingEvent {
  CancelBuildingEvent({required this.buildingId});

  final int buildingId;
}
