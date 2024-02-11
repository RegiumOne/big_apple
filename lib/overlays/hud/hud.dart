import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/blocs/game/game_bloc.dart';
import 'package:big_apple/common/extensions/date_time_extension.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  const Hud({
    super.key,
    required this.game,
  });

  final AppGame game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimension.s16, vertical: AppDimension.s10),
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
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Money: ${state.money}'),
                      const SizedBox(width: AppDimension.s16),
                      Text('Builders: ${state.availableBuilders.length}/${state.builders.length}'),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: BlocBuilder<GameBloc, GameState>(
                builder: (context, state) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        state is GameSavingState ? Icons.refresh_rounded : Icons.save,
                        color: theme.colorScheme.onSurface,
                        size: 14,
                      ),
                      const SizedBox(width: AppDimension.s4),
                      TextWidget(
                        state.lastSaveDateTime?.yearMonthDayTime() ?? '',
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _pause() {
    game.pauseGame();
  }
}
