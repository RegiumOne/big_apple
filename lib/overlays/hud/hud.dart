import 'package:big_apple/blocs/money/money_bloc.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  const Hud({
    super.key,
    required this.game,
  });

  final FlameGame game;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimension.s10),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: _pause,
                icon: const Icon(Icons.pause, color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: BlocBuilder<MoneyBloc, MoneyState>(
                builder: (context, state) {
                  return Text('Money: ${state.money}');
                },
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  void _pause() {
    game.overlays.remove(Overlays.hud);
    game.overlays.add(Overlays.pause);
    game.pauseEngine();
  }
}
