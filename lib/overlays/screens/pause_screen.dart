import 'dart:ui';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:big_apple/widgets/elevated_button_widget.dart';
import 'package:big_apple/widgets/text_widget.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PauseScreen extends StatelessWidget {
  const PauseScreen({
    super.key,
    required this.game,
  });

  final FlameGame game;

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
    game.overlays.remove(Overlays.pause);
    game.overlays.add(Overlays.hud);
    game.resumeEngine();
  }

  void _exit() {
    game.overlays.remove(Overlays.pause);
    game.overlays.add(Overlays.main);
    game.resumeEngine();
    (game as BigAppleGame).reset();
  }
}
