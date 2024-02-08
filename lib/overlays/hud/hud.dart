import 'package:big_apple/blocs/game/game_bloc.dart';
import 'package:big_apple/common/extensions/date_time_extension.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/widgets/text_widget.dart';
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
    return Padding(
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
                      return Text('Money: ${state.money}');
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
          Positioned(
            top: 50,
            left: 50,
            child: Draggable(
              feedback: SizedBox(
                width: 100,
                height: 200,
                child: Assets.images.mill.image(),
              ),
              childWhenDragging: Container(),
              data: "drag_data",
              child: SizedBox(
                width: 100,
                height: 200,
                child: Assets.images.mill.image(),
              ), // You can pass any data here
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
