import 'package:big_apple/domain/services/game_service.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/auth/auth_bloc.dart';
import 'package:big_apple/presentation/bloc/building/building_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:big_apple/big_apple_game.dart';
import 'package:big_apple/common/app/theme.dart';
import 'package:big_apple/di/injector.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/loading_widget.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => inject<GameHudBloc>()),
        BlocProvider(create: (context) => inject<BuildingBloc>()),
        BlocProvider(create: (context) => inject<AudioBloc>()),
        BlocProvider(create: (context) => inject<AuthBloc>()..add(const AuthInitEvent()), lazy: false),
      ],
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        title: 'EcoCity Architects',
        home: const Scaffold(
          body: _Game(),
        ),
      ),
    );
  }
}

class _Game extends StatefulWidget {
  const _Game();

  @override
  State<_Game> createState() => _GameState();
}

class _GameState extends State<_Game> {
  @override
  void initState() {
    super.initState();
    inject<GameService>().state.listen(
          (state) => state.whenOrNull(
            initBuildings: (gameStatistic, buildinds) => BlocProvider.of<GameHudBloc>(context).add(
              GameHudEvent.updateStatistic(gameStatistic),
            ),
            updateStat: (gameStatistic, buildinds) => BlocProvider.of<GameHudBloc>(context).add(
              GameHudEvent.updateStatistic(gameStatistic),
            ),
            onNewLevel: (gameStatistic, buildinds, newLevel) {
              debugPrint('New level: $newLevel');
              // TODO(hrubalskyi): Implement new level UI
              return;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget<BigAppleGame>.controlled(
      gameFactory: () => BigAppleGame(
        buildingBloc: BlocProvider.of<BuildingBloc>(context),
        gameBloc: BlocProvider.of<GameHudBloc>(context),
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
