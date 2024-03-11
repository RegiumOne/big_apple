part of 'building_bloc.dart';

@immutable
sealed class BuildingState {}

final class BuildingInitial extends BuildingState {}

final class BuildingIdle extends BuildingState {}

final class BuidlingBuild extends BuildingState {}

final class BuidlingCancelled extends BuildingState {}
