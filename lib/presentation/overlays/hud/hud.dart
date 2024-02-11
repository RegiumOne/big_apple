import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/common/extensions/date_time_extension.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Hud extends StatelessWidget {
  const Hud({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimension.s16, vertical: AppDimension.s10),
        child: Column(
          children: [
            Row(
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
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: AppDimension.s16, vertical: AppDimension.s10),
                ),
                child: const Text(
                  "Shop",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pause() {
    game.pauseGame();
  }
}
