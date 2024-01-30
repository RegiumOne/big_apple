part of 'money_bloc.dart';

abstract class MoneyState {
  const MoneyState({
    required this.money,
  });

  final int money;
}

class MoneyIdleState extends MoneyState {
  const MoneyIdleState({
    super.money = 0,
  });
}
