part of 'building_bloc.dart';

@immutable
sealed class BuildingState {}

final class BuildingIdle extends BuildingState {}

final class BuildingPreparing extends BuildingState {
  BuildingPreparing({required this.buildingInfo});

  final BuildingInfo buildingInfo;
}

final class BuidlingBuild extends BuildingState {
  BuidlingBuild({required this.buildingInfo});

  final BuildingInfo buildingInfo;
}

final class BuidlingCancelled extends BuildingState {
  BuidlingCancelled({required this.buildingInfo});

  final BuildingInfo buildingInfo;
}
