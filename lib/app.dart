import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/blocs/game/game_bloc.dart';
import 'package:big_apple/di/injector.dart';
import 'package:big_apple/overlays/app_overlay.dart';
import 'package:big_apple/widgets/loading_widget.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => inject<GameBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Big Apple',
        home: Scaffold(
          body: _Game(),
        ),
      ),
    );
  }
}

class _Game extends StatelessWidget {
  const _Game();

  @override
  Widget build(BuildContext context) {
    return GameWidget<BigAppleGame>.controlled(
      gameFactory: () => BigAppleGame(context.read<GameBloc>()),
      loadingBuilder: (context) => const _LoadingWidget(),
      overlayBuilderMap: AppOverlay.overlayBuilderMap,
      initialActiveOverlays: AppOverlay.initialActiveOverlays,
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
