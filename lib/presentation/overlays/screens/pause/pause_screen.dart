import 'dart:ui';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/presentation/widgets/elevated_button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.s32),
          margin: const EdgeInsets.symmetric(vertical: AppDimension.s16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppDimension.r10),
              topRight: Radius.circular(AppDimension.r10),
              bottomRight: Radius.circular(AppDimension.r10),
              bottomLeft: Radius.circular(AppDimension.r10),
            ),
          ),
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
                      onPressed: _resume,
                      child: TextWidget(
                        'Resume',
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimension.s16),
                    ElevatedButtonWidget(
                      onPressed: _exit,
                      child: TextWidget(
                        'Exit',
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
        ),
      ),
    );
  }

  void _resume() {
    game.resumeGame();
  }

  void _exit() {
    game.overlays.remove(Overlays.pause.name);
    game.overlays.add(Overlays.main.name);
    game.resumeEngine();
    game.endGame();
  }
}
