import 'package:big_apple/resources/values/app_dimension.dart';
import 'package:flutter/material.dart';

class SafeAreaWidget extends StatelessWidget {
  const SafeAreaWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final hasBottomPadding = mediaQueryData.padding.bottom > 0;
    final hasLeftPadding = mediaQueryData.padding.left > 0;
    final hasRightPadding = mediaQueryData.padding.right > 0;
    return SafeArea(
      minimum: EdgeInsets.only(
        left: hasLeftPadding ? mediaQueryData.padding.left : AppDimension.s16,
        right: hasRightPadding ? mediaQueryData.padding.right : AppDimension.s16,
        bottom: hasBottomPadding ? mediaQueryData.padding.bottom : AppDimension.s18,
      ),
      child: child,
    );
  }
}
