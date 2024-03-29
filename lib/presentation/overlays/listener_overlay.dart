import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';
import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListenerOverlay extends StatefulWidget {
  const ListenerOverlay({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  State<ListenerOverlay> createState() => _ListenerOverlayState();
}

class _ListenerOverlayState extends State<ListenerOverlay> {
  @override
  void initState() {
    context.read<AudioBloc>().add(const AudioInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GameHudBloc, GameHudState>(
          listener: (context, state) {
            if (state.showNewLevel) {
              widget.game.overlays.add(Overlays.newLevel.name);
            }
          },
        ),
        BlocListener<AudioBloc, AudioState>(
          listener: (context, state) {
            AudioService.instance.setMusicEnabled(state.isMusicEnabled);
            AudioService.instance.setSoundEnabled(state.isSoundEnabled);
            if (state is AudioCheckMusicState) {
              widget.game.checkMusic();
            }
          },
        ),
      ],
      child: const SizedBox.shrink(),
    );
  }
}
