import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/blocs/game/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListenerOverlay extends StatelessWidget {
  const ListenerOverlay({
    super.key,
    required this.game,
  });

  final AppGame game;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameLoadedState) {
          game.initBuildings(state.buildings);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
