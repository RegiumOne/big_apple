part of 'building_bloc.dart';

@immutable
sealed class BuildingState {}

final class BuildingIdle extends BuildingState {}

final class BuildingPreparing extends BuildingState {
  BuildingPreparing({required this.buildingId});

  final int buildingId;
}

final class BuidlingBuild extends BuildingState {
  BuidlingBuild({required this.buildingId});

  final int buildingId;
}

final class BuidlingCancelled extends BuildingState {
  BuidlingCancelled({required this.buildingId});

  final int  buildingId;
}
