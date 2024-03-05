import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/app/theme.dart';
import 'package:big_apple/di/injector.dart';
import 'package:big_apple/presentation/bloc/game/game_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/loading_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => inject<GameBloc>(),
        ),
        BlocProvider(
          create: (context) => inject<AuthBloc>()..add(const AuthInitEvent()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => inject<AudioBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        title: 'Big Apple',
        home: const Scaffold(
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
      gameFactory: () => BigAppleGame(
        gameBloc: BlocProvider.of<GameBloc>(context),
        audioBloc: BlocProvider.of<AudioBloc>(context),
      ),
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
