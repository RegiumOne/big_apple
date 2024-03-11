part of 'building_bloc.dart';

@immutable
sealed class BuildingEvent {}

class InitBuildingEvent extends BuildingEvent {}

class BuildBuildingEvent extends BuildingEvent {}

class CancelBuildingEvent extends BuildingEvent {}
