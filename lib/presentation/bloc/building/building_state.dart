part of 'building_bloc.dart';

@immutable
sealed class BuildingState {}

final class BuildingIdle extends BuildingState {}

final class BuildingPreparing extends BuildingState {
  BuildingPreparing({required this.buildingEntity});

  final BuildingEntity buildingEntity;
}

final class BuidlingBuild extends BuildingState {
  BuidlingBuild({required this.buildingEntity});

  final BuildingEntity buildingEntity;
}

final class BuidlingCancelled extends BuildingState {
  BuidlingCancelled({required this.buildingEntity});

  final BuildingEntity buildingEntity;
}
