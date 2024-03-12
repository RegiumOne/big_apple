import 'package:big_apple/data/dto/building_info.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'building_event.dart';
part 'building_state.dart';

@Injectable()
class BuildingBloc extends Bloc<BuildingEvent, BuildingState> {
  BuildingBloc() : super(BuildingIdle()) {
    on<InitBuildingEvent>(_handleInitBuildingEvent);
    on<BuildBuildingEvent>(_handleBuildBuildingEvent);
    on<CancelBuildingEvent>(_handleCancelBuildingEvent);
  }

  void _handleInitBuildingEvent(InitBuildingEvent event, Emitter<BuildingState> emit) {
    emit(BuildingPreparing(buildingInfo: event.buildingInfo));
  }

  void _handleBuildBuildingEvent(BuildBuildingEvent event, Emitter<BuildingState> emit) {
    emit(BuidlingBuild(buildingId: event.buildingId));
  }

  void _handleCancelBuildingEvent(CancelBuildingEvent event, Emitter<BuildingState> emit) {
    emit(BuidlingCancelled(buildingId: event.buildingId));
  }
}
