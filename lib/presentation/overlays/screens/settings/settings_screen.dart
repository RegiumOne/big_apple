import 'dart:ui';

import 'package:big_apple/common/game/common_game.dart';
import 'package:big_apple/data/dto/enum/o_auth_provider.dart';
import 'package:big_apple/generated/assets.gen.dart';
import 'package:big_apple/presentation/bloc/audio/audio_bloc.dart';
import 'package:big_apple/presentation/bloc/auth/auth_bloc.dart';
import 'package:big_apple/presentation/overlays/app_overlay.dart';
import 'package:big_apple/presentation/widgets/button_widget.dart';
import 'package:big_apple/presentation/widgets/circle_button_widget.dart';
import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_colors.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.game,
  });

  final CommonGame game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Center(
        child: _BackgroundWidget(
          title: 'Settings',
          onClose: () {
            game.overlays.remove(Overlays.settings.name);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colorLightGray,
                  borderRadius: BorderRadius.circular(AppDimension.r10),
                ),
                padding: const EdgeInsets.only(
                  left: AppDimension.s14,
                  right: AppDimension.s14,
                  top: AppDimension.s10,
                  bottom: AppDimension.s14,
                ),
                child: Column(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Row(
                          children: [
                            Expanded(
                              child: ButtonWidget.iconWithTextRow(
                                onPressed: () {
                                  _handleAuthenticationPress(state, context, OAuthProvider.google);
                                },
                                iconSvg: Assets.icons.google,
                                iconHeight: AppDimension.s26,
                                iconWidth: AppDimension.s28,
                                gap: AppDimension.s10,
                                text: state.oAuthProvider == OAuthProvider.google
                                    ? 'Sign out of Google'
                                    : 'Sign in with Google',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.2,
                                  color: Colors.white,
                                  shadows: [AppColors.shadowCrispEdge],
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimension.s6),
                            Expanded(
                              child: ButtonWidget.iconWithTextRow(
                                gradient: AppColors.darkGrayGradient,
                                shadowColor: Colors.black,
                                onPressed: () {
                                  _handleAuthenticationPress(state, context, OAuthProvider.apple);
                                },
                                iconSvg: Assets.icons.apple,
                                iconHeight: AppDimension.s24,
                                iconWidth: AppDimension.s22,
                                gap: AppDimension.s12,
                                text: state.oAuthProvider == OAuthProvider.apple
                                    ? 'Sign out of Apple'
                                    : 'Sign in with Apple',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  height: 1.2,
                                  color: Colors.white,
                                  shadows: [AppColors.shadowCrispEdge],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: AppDimension.s12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 296),
                      child: Text(
                        'Sign in with Apple or Google\nto save your progress and play on multiple devices',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.colorTaupe,
                          height: 1.16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppDimension.s6),
              BlocBuilder<AudioBloc, AudioState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorLightGray,
                            borderRadius: BorderRadius.circular(AppDimension.r10),
                          ),
                          padding: const EdgeInsets.only(
                            left: AppDimension.s12,
                            right: AppDimension.s8,
                            top: AppDimension.s8,
                            bottom: AppDimension.s8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Music',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: AppColors.colorBronze,
                                    height: 1.18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppDimension.s4),
                              ButtonWidget.icon(
                                onPressed: () {
                                  context.read<AudioBloc>().add(const AudioToggleMusicEnabledEvent());
                                },
                                iconSvg: Assets.icons.music,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimension.s10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.colorLightGray,
                            borderRadius: BorderRadius.circular(AppDimension.r10),
                          ),
                          padding: const EdgeInsets.only(
                            left: AppDimension.s12,
                            right: AppDimension.s8,
                            top: AppDimension.s8,
                            bottom: AppDimension.s8,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Sound',
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: AppColors.colorBronze,
                                    height: 1.18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppDimension.s4),
                              ButtonWidget.icon(
                                onPressed: () {
                                  context.read<AudioBloc>().add(const AudioToggleSoundEnabledEvent());
                                },
                                iconSvg: Assets.icons.sound,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppDimension.s14),
              Row(
                children: [
                  Expanded(
                    flex: 142,
                    child: ButtonWidget.withText(
                      onPressed: () {},
                      text: 'Privacy policy',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.colorBronze,
                        height: 1.18,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimension.s10),
                  Expanded(
                    flex: 160,
                    child: ButtonWidget.withText(
                      onPressed: () {},
                      text: 'Terms of Service',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.colorBronze,
                        height: 1.18,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimension.s10),
                  Expanded(
                    flex: 94,
                    child: ButtonWidget.withText(
                      onPressed: () {},
                      text: 'Credits',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.colorBronze,
                        height: 1.18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimension.s8),
              Text(
                'Your ID is: 9999999999999',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.colorTaupe,
                  height: 1.16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleAuthenticationPress(AuthState state, BuildContext context, OAuthProvider oAuthProvider) {
    if (state.oAuthProvider == oAuthProvider) {
      context.read<AuthBloc>().add(const AuthLogoutEvent());
    } else {
      context.read<AuthBloc>().add(AuthLoginEvent(oAuthProvider));
    }
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget({
    required this.title,
    required this.onClose,
    required this.child,
  });

  final String title;
  final void Function() onClose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          constraints: const BoxConstraints(
            maxHeight: 320,
            maxWidth: 482,
          ),
          padding: const EdgeInsets.only(
            top: AppDimension.s12,
            bottom: AppDimension.s14,
            left: AppDimension.s16,
            right: AppDimension.s16,
          ),
          decoration: const BoxDecoration(
            color: AppColors.colorBronze,
            borderRadius: BorderRadius.all(Radius.circular(AppDimension.r30)),
            boxShadow: [AppColors.shadowSoftBlack],
          ),
          child: Container(
            padding: const EdgeInsets.all(AppDimension.s6),
            decoration: const BoxDecoration(
              color: AppColors.colorAlabaster,
              borderRadius: BorderRadius.all(Radius.circular(AppDimension.r20)),
              boxShadow: [AppColors.shadowSoftBlack],
            ),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: AppColors.colorBronze,
              padding: EdgeInsets.zero,
              dashPattern: const [5, 5],
              radius: const Radius.circular(AppDimension.r16),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimension.s26,
                  bottom: AppDimension.s16,
                  left: AppDimension.s14,
                  right: AppDimension.s14,
                ),
                child: child,
              ),
            ),
          ),
        ),
        Positioned(
          top: -10,
          right: -10,
          child: CircleButtonWidget(
            iconSvg: Assets.icons.close,
            onTap: onClose,
          ),
        ),
        Positioned(
          top: -10,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: AppDimension.s44,
              alignment: Alignment.center,
              constraints: const BoxConstraints(maxWidth: 166),
              decoration: const BoxDecoration(
                gradient: AppColors.sunriseGlowGradient,
                borderRadius: BorderRadius.all(Radius.circular(AppDimension.r20)),
                boxShadow: [AppColors.shadowElevatedSoft],
              ),
              child: TextWidget(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  shadows: [AppColors.shadowCrispEdge],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
