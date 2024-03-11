import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final buildingStateProvider = StateProvider<BuildingState>(
  (ref) => BuildingInitial(),
);

@immutable
abstract class BuildingState {}

class BuildingIdle extends BuildingState {}

class BuildingInitial extends BuildingState {}

class BuildingBuildState extends BuildingState {}

class BuildingCancelledState extends BuildingState {}
