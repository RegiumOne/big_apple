import 'package:bloc/bloc.dart';

part 'money_event.dart';
part 'money_state.dart';

class MoneyBloc extends Bloc<MoneyEvent, MoneyState> {
  MoneyBloc() : super(const MoneyIdleState()) {
    on<MoneyUpdateEvent>(
      _update,
    );
  }

  void _update(
    MoneyUpdateEvent event,
    Emitter<MoneyState> emit,
  ) async {
    emit(
      MoneyIdleState(
        money: state.money + 1,
      ),
    );
  }
}
