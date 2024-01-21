import 'package:big_apple/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;
  const BackgroundImageWidget({
    Key? key,
    this.child = const SizedBox.shrink(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: const BoxDecoration(color: Color(0x6615171F)),
            child: Image.asset(
              Assets.images.background.path,
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
