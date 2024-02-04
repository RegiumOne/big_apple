import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/widgets/background_image_widget.dart';
import 'package:big_apple/widgets/elevated_button_widget.dart';
import 'package:big_apple/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.game,
  });

  final AppGame game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackgroundImageWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            'Big Apple',
            style: theme.textTheme.displayLarge!.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.5,
            ),
            child: Column(
              children: [
                ElevatedButtonWidget(
                  onPressed: _start,
                  child: TextWidget(
                    'Start',
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.s16),
                ElevatedButtonWidget(
                  onPressed: () {},
                  child: TextWidget(
                    'Leaderboard',
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: AppDimension.s16),
                ElevatedButtonWidget(
                  onPressed: () {},
                  child: TextWidget(
                    'Credits',
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _start() {
    game.startGame();
    game.overlays.remove(Overlays.main);
    game.overlays.add(Overlays.hud);
  }
}
