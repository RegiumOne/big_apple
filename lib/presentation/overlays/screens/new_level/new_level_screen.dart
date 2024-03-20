import 'dart:ui';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/common/services/audio_service.dart';
import 'package:big_apple/data/dto/enum/audio_file.dart';
import 'package:big_apple/data/dto/enum/resource_type.dart';
import 'package:big_apple/presentation/bloc/game_hud/game_hud_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/background_center_widget.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/resource_with_text_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewLevelScreen extends StatefulWidget {
  const NewLevelScreen({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  State<NewLevelScreen> createState() => _NewLevelScreenState();
}

class _NewLevelScreenState extends State<NewLevelScreen> {
  @override
  void initState() {
    AudioService.instance.playSound(AudioFile.positiveNotificationNewLevel, isImportant: true);
    super.initState();
  }

  @override
  void dispose() {
    widget.game.checkMusic();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: BlocBuilder<GameHudBloc, GameHudState>(
          builder: (context, state) {
            final level = state.gameStat.ecologyLevel.floor();
            return BackgroundCenterWidget(
              level: level,
              title: 'LEVEL UP!',
              secondBackgroundColor: AppColors.colorCopper,
              dottedBorderColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextWidget(
                    'Congratulations! You have reached level $level',
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  TextWidget(
                    'This is your reward:',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: AppDimension.s6),
                  Container(
                    height: AppDimension.s110,
                    width: AppDimension.s96,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.colorLightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(AppDimension.r10)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ResourceWithTextWidget(
                          resourceTypeIcon: ResourceType.wood.icon(isWhite: true),
                          value: 40,
                        ),
                        const SizedBox(height: AppDimension.s6),
                        TextWidget(
                          'Wood',
                          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimension.s6),
                  ButtonWidget(
                    width: AppDimension.s158,
                    height: AppDimension.s32,
                    borderRadius: AppDimension.r6,
                    gradient: AppColors.blueGradientTopBottom,
                    gradientPress: AppColors.darkBlueGradient,
                    shadowColor: AppColors.colorRoyalBlue,
                    childShadowColor: AppColors.colorMediumTransparencyBlack,
                    childShadowOffset: const Offset(2, 2),
                    text: 'Super!',
                    onPressed: () {
                      widget.game.overlays.remove(Overlays.newLevel.name);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
