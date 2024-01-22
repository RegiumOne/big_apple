import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:big_apple/widgets/loading_widget.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final game = GameWidget<BigAppleGame>.controlled(
      gameFactory: () => BigAppleGame(),
      loadingBuilder: (context) => const _LoadingWidget(),
      overlayBuilderMap: AppOverlay.overlayBuilderMap,
      initialActiveOverlays: AppOverlay.initialActiveOverlays,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Big Apple',
      home: Scaffold(body: game),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.background,
      child: const Center(
        child: LoadingWidget(),
      ),
    );
  }
}
