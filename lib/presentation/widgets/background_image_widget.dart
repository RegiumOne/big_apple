import 'package:big_apple/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({
    super.key,
    this.child = const SizedBox.shrink(),
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: const BoxDecoration(color: Color(0x6615171F)),
            child: Assets.images.background.image(fit: BoxFit.cover),
          ),
        ),
        child,
      ],
    );
  }
}
