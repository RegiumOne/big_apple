import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'building_event.dart';
part 'building_state.dart';

@Injectable()
class BuildingBloc extends Bloc<BuildingEvent, BuildingState> {
  BuildingBloc() : super(BuildingInitial()) {
    on<InitBuildingEvent>(_handleInitBuildingEvent);
    on<BuildBuildingEvent>(_handleBuildBuildingEvent);
    on<CancelBuildingEvent>(_handleCancelBuildingEvent);
  }

  void _handleInitBuildingEvent(InitBuildingEvent event, Emitter<BuildingState> emit) {
    emit(BuildingInitial());
  }

  void _handleBuildBuildingEvent(BuildBuildingEvent event, Emitter<BuildingState> emit) {
    emit(BuidlingBuild());
  }

  void _handleCancelBuildingEvent(CancelBuildingEvent event, Emitter<BuildingState> emit) {
    emit(BuidlingCancelled());
  }
}
