part of 'money_bloc.dart';

abstract class MoneyEvent {
  const MoneyEvent();
}

class MoneyUpdateEvent extends MoneyEvent {
  const MoneyUpdateEvent();
}
