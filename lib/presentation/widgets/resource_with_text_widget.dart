import 'package:big_apple/presentation/widgets/text_widget.dart';
import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResourceWithTextWidget extends StatelessWidget {
  const ResourceWithTextWidget({
    super.key,
    required this.resourceTypeIcon,
    required this.value,
  });

  final String resourceTypeIcon;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SvgPicture.asset(
          resourceTypeIcon,
          width: AppDimension.s50,
          height: AppDimension.s50,
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -6,
          child: Center(
            child: _TextWithBorderWidget(value: value),
          ),
        ),
      ],
    );
  }
}

class _TextWithBorderWidget extends StatelessWidget {
  const _TextWithBorderWidget({
    required this.value,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        TextWidget(
          '$value',
          style: theme.textTheme.titleMedium?.copyWith(
            height: 1,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = Colors.black,
          ),
        ),
        TextWidget(
          '$value',
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.white,
            height: 1,
            shadows: [
              const Shadow(
                color: Colors.black,
                offset: Offset(1, 1),
                blurRadius: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
