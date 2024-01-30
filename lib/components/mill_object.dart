import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/blocs/money/money_bloc.dart';
import 'package:flame/components.dart';

class MillObject extends SpriteComponent with HasGameReference<BigAppleGame> {
  MillObject({
    required Vector2 position,
    required super.size,
    required super.sprite,
  }) : super(
          priority: position.y.toInt() + 100,
          position: position,
        ) {
    debugMode = true;
  }

  double _timer = 0;

  @override
  void update(double dt) {
    super.update(dt);

    _timer += dt;

    if (_timer >= 1.0) {
      game.moneyBloc.add(const MoneyUpdateEvent());
      _timer = 0;
    }
  }
}
